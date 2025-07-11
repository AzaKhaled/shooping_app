import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/helper_functions/build_error_bar.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_cubit.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_state.dart';

class AddtocardViewBody extends StatelessWidget {
  const AddtocardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartItems = state.cartItems;
        final totalPrice = context.read<CartCubit>().totalPrice;

        if (cartItems.isEmpty) {
          return Center(
            child: Text(
              "Cart is empty",
              style: TextStyle(color: theme.colorScheme.onBackground),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                itemCount: cartItems.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, index) {
                  final item = cartItems[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.w),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          item.product.thumbnail,
                          width: 50.w,
                          height: 50.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item.product.title,
                        style: TextStyles.montserrat400_10_black.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 11.sp),
                              children: [
                                TextSpan(
                                  text: "Price: ",
                                  style: TextStyles.montserrat500_12_grey
                                      .copyWith(
                                        fontSize: 10.sp,
                                        color: theme.hintColor,
                                      ),
                                ),
                                TextSpan(
                                  text:
                                      "\$ ${item.product.price.toStringAsFixed(2)}",
                                  style: TextStyles.montserrat500_12_grey
                                      .copyWith(
                                        color: Colors.green[700],

                                        fontSize: 10.sp,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 10.sp),
                              children: [
                                TextSpan(
                                  text: "Quantity: ",
                                  style: TextStyles.montserrat500_12_grey
                                      .copyWith(
                                        fontSize: 10.sp,
                                        color: Colors.green[700],
                                      ),
                                ),
                                TextSpan(
                                  text: "${item.quantity}",
                                  style: TextStyles.montserrat500_12_grey
                                      .copyWith(
                                        color: Colors.green[700],
                                        fontSize: 10.sp,
                                      ),
                                ),
                                TextSpan(
                                  text: "   |   ",
                                  style: TextStyle(color: theme.hintColor),
                                ),
                                TextSpan(
                                  text: "Total: ",
                                  style: TextStyles.montserrat500_12_grey
                                      .copyWith(
                                        fontSize: 10.sp,
                                        color: Colors.green[700],
                                      ),
                                ),
                                TextSpan(
                                  text:
                                      "\$ ${(item.product.price * item.quantity).toStringAsFixed(2)}",
                                  style: TextStyles.montserrat500_12_grey
                                      .copyWith(
                                        color: Colors.green[700],

                                        fontSize: 10.sp,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: theme.colorScheme.error,
                        ),
                        onPressed: () {
                          context.read<CartCubit>().removeFromCart(
                            item.product,
                          );
                          buildSnackBarMessage(
                            context: context,
                            message: "Deleted successfully!",
                            backgroundColor: Colors.red,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyles.montserrat500_12_grey.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.hintColor,
                    ),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
