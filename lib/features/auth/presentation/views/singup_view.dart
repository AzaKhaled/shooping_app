import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/api_data_service.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_hub/features/auth/presentation/cubits/signup/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';

class SingUpView extends StatelessWidget {
  const SingUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => SignupCubit(
            AuthRepoImpl(
              firebaseAuthService: FirebaseAuthService(),
              databaseService:
                  FakeDatabaseService(), // ✅ لو بتستخدم FirestoreService
            ),
          ),
      child: const Scaffold(
        body: SafeArea(child: SignUpViewBodyBlocConsumer()),
      ),
    );
  }
}
