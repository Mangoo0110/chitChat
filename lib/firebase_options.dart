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
    apiKey: 'AIzaSyDaFjLv6rI8WNsKR43rPYucI9LzQt8HI0g',
    appId: '1:494242411428:web:9d4916a8514c74d6a24731',
    messagingSenderId: '494242411428',
    projectId: 'chitchat-e540c',
    authDomain: 'chitchat-e540c.firebaseapp.com',
    storageBucket: 'chitchat-e540c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0LG996tUZqs_Y_9DwH0lI1Uc1gEcrxIw',
    appId: '1:494242411428:android:127ea74d8aedf3a5a24731',
    messagingSenderId: '494242411428',
    projectId: 'chitchat-e540c',
    storageBucket: 'chitchat-e540c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAq34ZJJeXEluhhcaCCUBiR26i9bFsoqEk',
    appId: '1:494242411428:ios:80bd3a8ef7bf0e02a24731',
    messagingSenderId: '494242411428',
    projectId: 'chitchat-e540c',
    storageBucket: 'chitchat-e540c.appspot.com',
    iosClientId: '494242411428-fubklo92p58o91a99hnhf5a6mjod86rt.apps.googleusercontent.com',
    iosBundleId: 'com.example.chitchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAq34ZJJeXEluhhcaCCUBiR26i9bFsoqEk',
    appId: '1:494242411428:ios:f9d989b257cd0d40a24731',
    messagingSenderId: '494242411428',
    projectId: 'chitchat-e540c',
    storageBucket: 'chitchat-e540c.appspot.com',
    iosClientId: '494242411428-3s1gqrch0lb5fqcngpipuvui6m9ldol3.apps.googleusercontent.com',
    iosBundleId: 'com.example.chitchat.RunnerTests',
  );
}
