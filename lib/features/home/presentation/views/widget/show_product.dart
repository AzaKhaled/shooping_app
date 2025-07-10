import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_cubit.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_state.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/product_card.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product>? products; // << الجديد

  const ProductsGrid({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    if (products != null) {
      return buildGrid(products!);
    }

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          return buildGrid(state.products);
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildGrid(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}
