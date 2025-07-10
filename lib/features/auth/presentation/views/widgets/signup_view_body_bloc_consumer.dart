import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/mainlayout/MainLayoutView.dart';
import 'package:fruits_hub/core/helper_functions/build_error_bar.dart';
import 'package:fruits_hub/features/addtocard/presentation/cubits/addtocard/addtocard_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/cubits/signup/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:fruits_hub/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpViewBodyBlocConsumer extends StatelessWidget {
  const SignUpViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            context.read<FavoriteCubit>().loadFavoritesFromPrefs();
            context.read<CartCubit>().loadCartFromPrefs();
            if (state is SignupSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainLayoutView()),
                (route) => false,
              );
              buildSnackBarMessage(
            context:context, 
            message:'SignIn Successeful',
            backgroundColor: Colors.green);
            }
            if (state is SignupFailure) {
              buildSnackBarMessage(context:context, 
          message:state.message
          );
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is SignupLoading ? true : false,
              child: SignupViewBody(),
            );
          },
        );
      },
    );
  }
}
