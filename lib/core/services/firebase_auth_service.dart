import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruits_hub/core/errors/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and e.code: ${e.code}',
      );

      if (e.code == 'weak-password') {
        throw CustomException(message: 'weak-password');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          message: 'An account already exists with this email address.',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          message: 'Please check your internet connection.',
        );
      } else {
        throw CustomException(
          message: 'Something went wrong. Please try again later.',
        );
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}',
      );

      throw CustomException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and e.code: ${e.code}',
      );

      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        throw CustomException(message: 'The email or password is incorrect');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          message: 'Please check your internet connection.',
        );
      } else {
        throw CustomException(
          message: 'Something went wrong. Please try again later.',
        );
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthService.siginWithEmailAndPassword: ${e.toString()}',
      );

      throw CustomException(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return (await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    )).user!;
  }
}
