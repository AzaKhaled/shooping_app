import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';

class DioService {
  final Dio dio;

  DioService()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://dummyjson.com/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  Future<List<Map<String, String>>> getCategoriesWithImages() async {
    try {
      final categoriesResponse = await dio.get('products/categories');

      final List categories = categoriesResponse.data as List;
      final List<String> categorySlugs =
          categories
              .map(
                (e) =>
                    (e is Map && e['slug'] != null)
                        ? e['slug'].toString()
                        : null,
              )
              .where((slug) => slug != null)
              .cast<String>()
              .toList();

      List<Map<String, String>> result = [];
      final List<String> emptyCategories = [];

      for (var category in categorySlugs) {
        try {
          final response = await dio.get('products/category/$category');
          final List<dynamic> products = response.data['products'];

          if (products.isEmpty) {
            emptyCategories.add(category);
            log(' No products in category: $category');
            continue;
          }

          result.add({
            'name': category,
            'imageUrl': products[0]['thumbnail'] ?? '',
          });
        } catch (e) {
          emptyCategories.add(category);
          log(' Error loading category "$category": $e');
        }
      }

      if (emptyCategories.isNotEmpty) {
        log('🆔 Empty categories found: ${emptyCategories.join(', ')}');
      }

      return result;
    } catch (e) {
      log('Error fetching categories with images: $e');
      rethrow;
    }
  }

 Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await dio.get('products/search?q=$query');
      final List<dynamic> data = response.data['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }

// Future<List<Product>> fetchSortedProducts({String sortBy = 'title', String order = 'asc'}) async {
//   try {
//     final response = await dio.get('products', queryParameters: {
//       'sortBy': sortBy,
//       'order': order,
//     });

//     final List<dynamic> data = response.data['products'];
//     return data.map((json) => Product.fromJson(json)).toList();
//   } catch (e) {
//     throw Exception('Fetch sorted products error: $e');
//   }
// }

Future<List<Product>> fetchAllProducts({String order = 'asc'}) async {
  try {
    final response = await dio.get('products');
    final List<dynamic> data = response.data['products'];
    List<Product> products = data.map((e) => Product.fromJson(e)).toList();

    // ترتيب حسب العنوان
    products.sort((a, b) {
      if (order == 'asc') {
        return a.title.compareTo(b.title);
      } else {
        return b.title.compareTo(a.title);
      }
    });

    return products;
  } catch (e) {
    throw Exception('Error fetching all products: $e');
  }
}

}
