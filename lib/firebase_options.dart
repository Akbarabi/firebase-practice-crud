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
    apiKey: 'AIzaSyBt569wp64_USgSNv-0eNVnSz-1RZRAYpE',
    appId: '1:669545311498:web:92a77d528766b43d651ef3',
    messagingSenderId: '669545311498',
    projectId: 'crud-perform',
    authDomain: 'crud-perform.firebaseapp.com',
    storageBucket: 'crud-perform.appspot.com',
    measurementId: 'G-STG0VHREM0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBL3IqInJ0cHDB5LtEFlAy5iFSdTozrze8',
    appId: '1:669545311498:android:9dce494103630fb8651ef3',
    messagingSenderId: '669545311498',
    projectId: 'crud-perform',
    storageBucket: 'crud-perform.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCClwMFWwWzyCRFDYwRbPGJgmZl2thu_p8',
    appId: '1:669545311498:ios:3ce3fea3d5b4b218651ef3',
    messagingSenderId: '669545311498',
    projectId: 'crud-perform',
    storageBucket: 'crud-perform.appspot.com',
    iosBundleId: 'com.example.simpleCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCClwMFWwWzyCRFDYwRbPGJgmZl2thu_p8',
    appId: '1:669545311498:ios:3ce3fea3d5b4b218651ef3',
    messagingSenderId: '669545311498',
    projectId: 'crud-perform',
    storageBucket: 'crud-perform.appspot.com',
    iosBundleId: 'com.example.simpleCrud',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBt569wp64_USgSNv-0eNVnSz-1RZRAYpE',
    appId: '1:669545311498:web:2e18c9d293445fd8651ef3',
    messagingSenderId: '669545311498',
    projectId: 'crud-perform',
    authDomain: 'crud-perform.firebaseapp.com',
    storageBucket: 'crud-perform.appspot.com',
    measurementId: 'G-WH93TR8HVS',
  );
}