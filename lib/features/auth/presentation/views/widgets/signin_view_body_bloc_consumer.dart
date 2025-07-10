import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/mainlayout/MainLayoutView.dart';
import 'package:fruits_hub/core/helper_functions/build_error_bar.dart';
import 'package:fruits_hub/core/utils/widgets/custom_progress_hud.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/cubits/signin/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/singin_view_body.dart';
import 'package:fruits_hub/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';

class SignInViewBodyBlocConsumer extends StatelessWidget {
  const SignInViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          context.read<FavoriteCubit>().loadFavoritesFromPrefs();
          context.read<CartCubit>().loadCartFromPrefs();

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainLayoutView()),
            (route) => false,
          );
          buildSnackBarMessage(
            context:context, 
            message:'SignIn Successeful',
            backgroundColor: Colors.green);
        }
        if (state is SigninFailure) {
          buildSnackBarMessage(context:context, 
          message:state.message
          );
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is SigninLoading ? true : false,
          child: SigninViewBody(),
        );
      },
    );
  }
}
