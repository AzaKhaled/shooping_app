import 'package:bloc/bloc.dart';
import 'package:fruits_hub/core/services/dio_service.dart';
import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final DioService dioService;
  String currentOrder = 'asc';
  String? currentSearch;
  String? currentCategory;

  ProductCubit(this.dioService) : super(ProductInitial());

  Future<void> fetchProducts({String? search, String? category, String order = 'asc'}) async {
    emit(ProductLoading());

    currentOrder = order;
    currentSearch = search;
    currentCategory = category;

    try {
      String endpoint = 'products';
      if (search != null && search.isNotEmpty) {
        endpoint = 'products/search?q=$search';
      } else if (category != null && category.isNotEmpty) {
        endpoint = 'products/category/$category';
      }

      final response = await dioService.dio.get(endpoint);
      final List<dynamic> data = response.data['products'];
      final products = data.map((json) => Product.fromJson(json)).toList();

      if (order == 'desc') {
  products.sort((a, b) => b.title.compareTo(a.title)); // ترتيب تنازلي حسب الاسم
} else {
  products.sort((a, b) => a.title.compareTo(b.title)); // ترتيب تصاعدي حسب الاسم
}


      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to load products: $e'));
    }
  }

  /// Toggle sorting using current search/category
  void toggleSort() {
    final newOrder = currentOrder == 'asc' ? 'desc' : 'asc';
    fetchProducts(
      order: newOrder,
      search: currentSearch,
      category: currentCategory,
    );
  }

  void decreaseProductStock(int productId) {
  if (state is ProductLoaded) {
    final loadedState = state as ProductLoaded;
    final updatedProducts = loadedState.products.map((product) {
      if (product.id == productId && product.stock > 0) {
        return product.copyWith(stock: product.stock - 1);
      }
      return product;
    }).toList();

    emit(ProductLoaded(updatedProducts));
  }
}

}
