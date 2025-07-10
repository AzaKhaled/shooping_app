import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helper_functions/build_error_bar.dart';
import 'package:fruits_hub/core/utils/widgets/custombutton.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_cubit.dart';
import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_cubit.dart';
import 'package:fruits_hub/mainlayout/MainLayoutView.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    final isOutOfStock = product.stock == 0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation ?? 1,
        centerTitle: true,
        title: Text(
          product.title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product.thumbnail, height: 200),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  "Rating: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                buildRatingStars(product.rating),
                const SizedBox(width: 8),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
            CustomButton(
              text: product.stock == 0 ? 'Out of Stock' : 'Add to Cart',
              onPressed:
                  product.stock == 0
                      ? null
                      : () {
                        context.read<CartCubit>().addToCart(product);
                        context.read<ProductCubit>().decreaseProductStock(
                          product.id,
                        ); 
                        buildSnackBarMessage(
            context:context, 
            message:"Aded successfully!",
            backgroundColor: Colors.green);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => const MainLayoutView(initialIndex: 2),
                          ),
                        );
                      },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (rating >= index + 1) {
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (rating > index && rating < index + 1) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.grey, size: 16);
        }
      }),
    );
  }
}
