import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/helper_functions/build_error_bar.dart';
import 'package:fruits_hub/core/utils/widgets/custombutton.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_cubit.dart';
import 'package:fruits_hub/features/home/data/repos/models/products_models.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_cubit.dart';
import 'package:fruits_hub/mainlayout/MainLayoutView.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final productCubit = context.read<ProductCubit>();
    final isOutOfStock = product.stock == 0;
    final discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return  Scaffold(
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
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: product.images.length,
            options: CarouselOptions(
              height: 250,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 0.9,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, _) {
              final imageUrl = product.images[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 12.h),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: product.images.length,
            effect: WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Color(0xffFA7189),
              dotColor: Colors.grey.shade300,
            ),
          ),

          SizedBox(height: 16.h),
          Text(
            product.title,
            style: const TextStyle(
              color: Color(0xffFA7189),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(product.description, style: const TextStyle(fontSize: 16)),
          SizedBox(height: 8.h),

          Row(
            children: [
              Text(
                '\$${discountedPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '-${product.discountPercentage.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xffFA7189),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
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
        ],
      ),
    ),
  ),

  /// ✅ الزرار هنا ثابت تحت
  bottomNavigationBar: Padding(
    padding: const EdgeInsets.all(16.0),
    child: CustomButton(
      text: isOutOfStock ? 'Out of Stock' : 'Add to Cart',
      onPressed: isOutOfStock
          ? null
          : () {
              final discountedProduct = product.copyWith(
                price: discountedPrice,
              );

              context.read<CartCubit>().addToCart(discountedProduct);
              productCubit.decreaseProductStock(product.id);

              buildSnackBarMessage(
                context: context,
                message: "Added successfully!",
                backgroundColor: Colors.green,
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainLayoutView(initialIndex: 2),
                ),
              );
            },
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
