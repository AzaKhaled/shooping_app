import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helper_functions/build_error_bar.dart';
import 'package:fruits_hub/core/utils/widgets/custom_progress_hud.dart';
import 'package:fruits_hub/features/auth/presentation/cubits/signin/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/singin_view_body.dart';
import 'package:fruits_hub/features/home/home_view.dart';



class SignInViewBodyBlocConsumer extends StatelessWidget {
  const SignInViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
       if(state is SigninSuccess){

Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const HomeView()),
  (route) => false,
);
       }
       if(state is SigninFailure){
         buildErrorBar(context, state.message);
       }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is SigninLoading ? true : false,
          child: SigninViewBody());
      },
    );
  }
}
