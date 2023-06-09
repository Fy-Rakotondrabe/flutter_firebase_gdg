// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfGCRc5U8oKGZzEaL15AXnAAtzw10mpt4',
    appId: '1:675662814721:android:03a72748f02acf1627ea00',
    messagingSenderId: '675662814721',
    projectId: 'flutter-firebase-worksho-2c972',
    storageBucket: 'flutter-firebase-worksho-2c972.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9auoyTVSg2_eYpftBZoHN10MMdEfx9AY',
    appId: '1:675662814721:ios:66ed8827dd6cc55d27ea00',
    messagingSenderId: '675662814721',
    projectId: 'flutter-firebase-worksho-2c972',
    storageBucket: 'flutter-firebase-worksho-2c972.appspot.com',
    iosClientId: '675662814721-oo96dvuns1n2k4j2if359uh7b1t218s6.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebase',
  );
}
