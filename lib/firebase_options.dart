// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDVtg425zGzPicjujIXwmMQWi_o9av_70A',
    appId: '1:897153629553:web:3052bc12c5f70bc535cad0',
    messagingSenderId: '897153629553',
    projectId: 'fruit-hub-d24ec',
    authDomain: 'fruit-hub-d24ec.firebaseapp.com',
    storageBucket: 'fruit-hub-d24ec.firebasestorage.app',
    measurementId: 'G-TNHRKQ5J0G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-sBzHLpviHQendwL0QQXYeoHJ1t7RQJA',
    appId: '1:897153629553:android:f3a645bd07361e9435cad0',
    messagingSenderId: '897153629553',
    projectId: 'fruit-hub-d24ec',
    storageBucket: 'fruit-hub-d24ec.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBV3PLpCSvX8PRzuqqB-0ArDPesIRvRs14',
    appId: '1:897153629553:ios:33a50040d17ad66c35cad0',
    messagingSenderId: '897153629553',
    projectId: 'fruit-hub-d24ec',
    storageBucket: 'fruit-hub-d24ec.firebasestorage.app',
    androidClientId: '897153629553-99tt309mu0edmcktlec6436ii1dsbfki.apps.googleusercontent.com',
    iosClientId: '897153629553-03lklcbbkpm30k3c2c86dlqsbh8rcemu.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBV3PLpCSvX8PRzuqqB-0ArDPesIRvRs14',
    appId: '1:897153629553:ios:33a50040d17ad66c35cad0',
    messagingSenderId: '897153629553',
    projectId: 'fruit-hub-d24ec',
    storageBucket: 'fruit-hub-d24ec.firebasestorage.app',
    androidClientId: '897153629553-99tt309mu0edmcktlec6436ii1dsbfki.apps.googleusercontent.com',
    iosClientId: '897153629553-03lklcbbkpm30k3c2c86dlqsbh8rcemu.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDVtg425zGzPicjujIXwmMQWi_o9av_70A',
    appId: '1:897153629553:web:2ac22139aa5bdbac35cad0',
    messagingSenderId: '897153629553',
    projectId: 'fruit-hub-d24ec',
    authDomain: 'fruit-hub-d24ec.firebaseapp.com',
    storageBucket: 'fruit-hub-d24ec.firebasestorage.app',
    measurementId: 'G-VDL4BQWFHT',
  );
}
