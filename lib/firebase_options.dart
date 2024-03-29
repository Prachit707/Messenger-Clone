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
    apiKey: 'AIzaSyDtWxySzwSImr_Q5pI_5OX19xmLl4mWBT0',
    appId: '1:707009485155:web:c1067f0fd479e1a49b1b56',
    messagingSenderId: '707009485155',
    projectId: 'messengerclone-e7d56',
    authDomain: 'messengerclone-e7d56.firebaseapp.com',
    storageBucket: 'messengerclone-e7d56.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCu8OTRNXheb2r5MQS7Sgw_IMq8rYRqIeM',
    appId: '1:707009485155:android:2b37fc0e7b3ca0479b1b56',
    messagingSenderId: '707009485155',
    projectId: 'messengerclone-e7d56',
    storageBucket: 'messengerclone-e7d56.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHQ0fAADZNTaKhtDyr1xWUi2x9pWVUa-o',
    appId: '1:707009485155:ios:15ecaf833cde21739b1b56',
    messagingSenderId: '707009485155',
    projectId: 'messengerclone-e7d56',
    storageBucket: 'messengerclone-e7d56.appspot.com',
    androidClientId: '707009485155-r03a1fvgm4a35t5gsi5sp3l0hj4nkph0.apps.googleusercontent.com',
    iosClientId: '707009485155-5iv1lj1rl0r9buv2a4tlncpnhekbc910.apps.googleusercontent.com',
    iosBundleId: 'com.example.messengerClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCHQ0fAADZNTaKhtDyr1xWUi2x9pWVUa-o',
    appId: '1:707009485155:ios:d4be40ce25ffe3a29b1b56',
    messagingSenderId: '707009485155',
    projectId: 'messengerclone-e7d56',
    storageBucket: 'messengerclone-e7d56.appspot.com',
    androidClientId: '707009485155-r03a1fvgm4a35t5gsi5sp3l0hj4nkph0.apps.googleusercontent.com',
    iosClientId: '707009485155-kiv2s0f8f9ss8tr19qa4mbtv6bl1grnf.apps.googleusercontent.com',
    iosBundleId: 'com.example.messengerClone.RunnerTests',
  );
}
