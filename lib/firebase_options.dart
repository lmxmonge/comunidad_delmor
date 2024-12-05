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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDeQn5RaKMK6T8MYRTsAnEAiEMGXh2gBVk',
    appId: '1:705808373390:web:9f7e98cf376f7b8bbb5bdf',
    messagingSenderId: '705808373390',
    projectId: 'comunidad-delmor',
    authDomain: 'comunidad-delmor.firebaseapp.com',
    storageBucket: 'comunidad-delmor.firebasestorage.app',
    measurementId: 'G-NPK8VQLVB5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPv4uionMbtMWhIIW3Y6l5BGJuUNCdxzY',
    appId: '1:705808373390:android:6a76d6f4a5595d72bb5bdf',
    messagingSenderId: '705808373390',
    projectId: 'comunidad-delmor',
    storageBucket: 'comunidad-delmor.firebasestorage.app',
  );
}