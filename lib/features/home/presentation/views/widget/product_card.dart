import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/product_details_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOutOfStock = product.stock == 0;
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);
    return InkWell(
      onTap:
          isOutOfStock
              ? null
              : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsView(product: product),
                  ),
                );
              },
      child: Card(
        color: theme.colorScheme.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side:
              isOutOfStock
                  ? const BorderSide(color: Colors.red, width: 2)
                  : BorderSide.none,
        ),
        shadowColor: Colors.black12,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Opacity(
                              opacity: isOutOfStock ? 0.5 : 1,
                              child: Image.network(
                                product.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<FavoriteCubit, List<Product>>(
                          builder: (context, favorites) {
                            final isFav = context
                                .read<FavoriteCubit>()
                                .isFavorite(product);
                            return Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<FavoriteCubit>().toggleFavorite(
                                    product,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.background
                                        .withOpacity(0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: theme.colorScheme.error,
                                    size: 20,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isOutOfStock ? Colors.grey : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isOutOfStock ? Colors.grey : Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Available: ${product.stock}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isOutOfStock ? Colors.red : Colors.blueGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${discountedPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          '-${product.discountPercentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xffFA7189),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
                  Row(
                    children: [
                      buildRatingStars(product.rating),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (isOutOfStock)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  alignment: Alignment.center,
                  child: const Text(
                    'OUT OF STOCK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Widget buildRatingStars(double rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      if (rating >= index + 1) {
        return const Icon(Icons.star, color: Colors.amber, size: 14);
      } else if (rating > index && rating < index + 1) {
        return const Icon(Icons.star_half, color: Colors.amber, size: 14);
      } else {
        return const Icon(Icons.star_border, color: Colors.grey, size: 14);
      }
    }),
  );
}
