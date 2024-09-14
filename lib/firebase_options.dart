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
    apiKey: 'AIzaSyBLJdVFAvGXPpyw4NdDNp6SiV5Ou6pBcGM',
    appId: '1:501979676643:web:4c8343db9f76c574ca6ad6',
    messagingSenderId: '501979676643',
    projectId: 'stripe-payment-e5122',
    authDomain: 'stripe-payment-e5122.firebaseapp.com',
    storageBucket: 'stripe-payment-e5122.appspot.com',
    measurementId: 'G-SNQYXR8KR9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeb7tnBiiA1OskUX5ydWhjiCAICds6B14',
    appId: '1:501979676643:android:93339265ff87a354ca6ad6',
    messagingSenderId: '501979676643',
    projectId: 'stripe-payment-e5122',
    storageBucket: 'stripe-payment-e5122.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjGP-ACTKcLuI1pKdVnTDEqz_y37kXAZ4',
    appId: '1:501979676643:ios:66f70ad88eec33b3ca6ad6',
    messagingSenderId: '501979676643',
    projectId: 'stripe-payment-e5122',
    storageBucket: 'stripe-payment-e5122.appspot.com',
    iosBundleId: 'com.example.stripePayment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjGP-ACTKcLuI1pKdVnTDEqz_y37kXAZ4',
    appId: '1:501979676643:ios:66f70ad88eec33b3ca6ad6',
    messagingSenderId: '501979676643',
    projectId: 'stripe-payment-e5122',
    storageBucket: 'stripe-payment-e5122.appspot.com',
    iosBundleId: 'com.example.stripePayment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLJdVFAvGXPpyw4NdDNp6SiV5Ou6pBcGM',
    appId: '1:501979676643:web:bc71e3d3577ffa96ca6ad6',
    messagingSenderId: '501979676643',
    projectId: 'stripe-payment-e5122',
    authDomain: 'stripe-payment-e5122.firebaseapp.com',
    storageBucket: 'stripe-payment-e5122.appspot.com',
    measurementId: 'G-R2SZTWET9F',
  );
}
