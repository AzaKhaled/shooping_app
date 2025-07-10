import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/product_card.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/custom_home_appbar.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // تحميل الفيفوريت أول ما الصفحة تتبني
    context.read<FavoriteCubit>().loadFavoritesFromPrefs();

    final favorites = context.watch<FavoriteCubit>().state;

    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: CustomHomeAppbar(),
          ),
          Expanded(
            child:
                favorites.isEmpty
                    ? const Center(child: Text("No favorite products yet."))
                    : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final product = favorites[index];
                        return ProductCard(product: product);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
