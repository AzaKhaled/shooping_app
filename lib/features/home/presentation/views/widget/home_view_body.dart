import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_cubit.dart';
import 'package:fruits_hub/features/home/presentation/cubit/products/all_products_state.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/custom_all_categories.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/custom_home_appbar.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/custom_row_sorting.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/custom_search.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/show_product.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  /// Search
                  CustomSearch(
                    controller: searchController,
                    onChanged: (query) {
                      if (query.isEmpty) {
                        context.read<ProductCubit>().fetchProducts();
                      } else {
                        context.read<ProductCubit>().fetchProducts(
                          search: query,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 30.h),

                  /// Sort Button
                  CustomRowSorting(
                    onSort: () {
                      context.read<ProductCubit>().toggleSort();
                    },
                  ),
                  SizedBox(height: 30.h),

                  /// Categories
                  CustomAllCategories(searchController: searchController),
                  SizedBox(height: 25.h),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/images/myshop.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150.h,
                    ),
                  ),

                  SizedBox(height: 25.h),

                  /// Products
                  BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const CircularProgressIndicator(
                          color:  Color(0xFFFA7189),
                        );
                      } else if (state is ProductLoaded) {
                        return ProductsGrid(products: state.products);
                      } else if (state is ProductError) {
                        return Text(state.message);
                      } else {
                        return const SizedBox(); // Initial state
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        /// ثابت أعلى الصفحة
        Positioned(top: 0, left: 0, right: 0, child: CustomHomeAppbar()),
      ],
    );
  }
}
