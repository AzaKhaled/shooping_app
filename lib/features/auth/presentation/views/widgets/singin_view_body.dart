import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/core/utils/widgets/custombutton.dart';
import 'package:fruits_hub/core/utils/widgets/customtextfiled.dart';
import 'package:fruits_hub/features/auth/presentation/cubits/signin/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/singup_view.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/forgeted_password.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/have_an_account_section.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/password_field.dart';
import 'package:fruits_hub/core/utils/widgets/circler_buttom.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;
  late bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                SizedBox(height: 60.h),

                Text(
                  'Welcome Back!',
                  style: TextStyles.montserrat700_36.copyWith(
                    fontSize: 28.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 40.h),
                CustomTextFormField(
                  onSaved: (value) {
                    email = value!;
                  },
                  preffixIcon: const Icon(Icons.person_rounded),
                  hintText: 'Username or Email',
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 18.h),
                PasswordField(
                  hintText: 'Password',
                  onSaved: (value) {
                    password = value!;
                  },
                ),

                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetedPassword(),
                          ),
                        );
                      },
                      child: Text(
                        'forgot password?',
                        style: TextStyles.montserrat400_12_red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      context.read<SigninCubit>().signin(email, password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },

                  text: 'Login',
                ),
                SizedBox(height: 18.h),
                const OrDivider(),
                SizedBox(height: 26.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularImageButton(
                      onPressed: () {
                        context.read<SigninCubit>().signinWithGoogle();
                      },
                      imagePath: Assets.googleLogin,
                      size: 40,
                    ),
                    SizedBox(width: 20.w),
                    CircularImageButton(
                      onPressed: () {
                        context.read<SigninCubit>().signinWithFacebook();
                      },
                      imagePath: Assets.facebookLogin,
                      size: 40,
                    ),
                  ],
                ),
                SizedBox(height: 26.h),
                HaveAnAccountSection(
                  leadingText: 'Create An Account ',
                  actionText: 'Sign Up',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingUpView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
