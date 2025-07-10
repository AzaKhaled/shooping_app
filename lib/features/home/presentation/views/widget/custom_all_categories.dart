import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/features/home/presentation/cubit/category/category_cubit.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_cubit.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/category_iteams.dart';

class CustomAllCategories extends StatelessWidget {
  final TextEditingController searchController;

  const CustomAllCategories({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoaded) {
          final categories = state.categories;

          return SizedBox(
            height: 100,
            
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CategoryItem(
                    name: 'All',
                    imageUrl: Assets.AllCategories,
                    onTap: () {
                      searchController.clear();
                      context.read<ProductCubit>().fetchProducts();
                    },
                  );
                }

                final category = categories[index - 1];
                final name = category['name'] ?? 'Unknown';
                final imageUrl = category['imageUrl'] ?? '';

                return CategoryItem(
                  name: name,
                  imageUrl: imageUrl,
                  onTap: () {
                    searchController.clear();
                    context.read<ProductCubit>().fetchProducts(category: name);
                  },
                );
              },
            ),
          );
        } else if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
