import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fruits_hub/core/errors/failures.dart';
import 'package:fruits_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';
import '../../../domain/entites/user_entity.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;

  Future<void> signin(String email, String password) async {
    emit(SigninLoading());
    var result = await authRepo.signinWithEmailAndPassword(email, password);
    result.fold((Failure failure) {
      // log(' Signin Error: ${failure.message}');
      emit(SigninFailure(message: failure.message));
    }, (UserEntity userEntity) => emit(SigninSuccess(userEntity: userEntity)));
  }

  Future<void> signinWithGoogle() async {
    emit(SigninLoading());
    var result = await authRepo.signinWithGoogle();
    result.fold((Failure failure) {
      // log(' Google Signin Error: ${failure.message}');
      emit(SigninFailure(message: failure.message));
    }, (UserEntity userEntity) => emit(SigninSuccess(userEntity: userEntity)));
  }

  Future<void> signinWithFacebook() async {
    emit(SigninLoading());
    var result = await authRepo.signinWithFacebook();
    result.fold((Failure failure) {
      // log('Facebook Signin Error: ${failure.message}');
      emit(SigninFailure(message: failure.message));
    }, (UserEntity userEntity) => emit(SigninSuccess(userEntity: userEntity)));
  }
}
