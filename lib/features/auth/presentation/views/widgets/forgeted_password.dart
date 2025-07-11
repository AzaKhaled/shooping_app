import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/core/utils/widgets/custombutton.dart';
import 'package:fruits_hub/core/utils/widgets/customtextfiled.dart';

class ForgetedPassword extends StatefulWidget {
  const ForgetedPassword({super.key});

  @override
  State<ForgetedPassword> createState() => _ForgetedPasswordState();
}

class _ForgetedPasswordState extends State<ForgetedPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),

              Center(
                child: Text(
                  'Forget Password',
                  style: TextStyles.montserrat700_36.copyWith(fontSize: 28.sp),
                ),
              ),

              SizedBox(height: 35.h),

              CustomTextFormField(
                onSaved: (value) {
                  email = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                preffixIcon: const Icon(Icons.email_rounded),
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),

              SizedBox(height: 16.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('*', style: TextStyles.montserrat400_12_red),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      'We will send you a message to set or reset your new password',
                      softWrap: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              CustomButton(
                text: 'Submit',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: email,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password reset email sent. Check your inbox.',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message ?? 'An error occurred'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
