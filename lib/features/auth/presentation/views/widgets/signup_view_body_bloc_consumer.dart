import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helper_functions/build_error_bar.dart';
import 'package:fruits_hub/features/auth/presentation/cubits/signup/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:fruits_hub/features/home/home_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpViewBodyBlocConsumer extends StatelessWidget {
  const SignUpViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeView()),
                (route) => false,
              );
            }
            if (state is SignupFailure) {
              buildErrorBar(context, state.message);
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
