import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/api_data_service.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_hub/features/auth/presentation/cubits/signin/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/signin_view_body_bloc_consumer.dart';

class SiginView extends StatelessWidget {
  const SiginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        AuthRepoImpl(
          databaseService: FakeDatabaseService(),
          firebaseAuthService: FirebaseAuthService(),
        ),
      ),
      child: const SignInViewBodyBlocConsumer(),
    );
  }
}
