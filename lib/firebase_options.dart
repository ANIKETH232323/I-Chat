// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  String avc =dotenv.get('GOOGLE_API_KE');
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
    apiKey: 'avc',
    appId: '1:1055445263937:android:5e0fa786d97fac185548c0',
    messagingSenderId: '1055445263937',
    projectId: 'i-chat-d0b42',
    storageBucket: 'i-chat-d0b42.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'avc',
    appId: '1:1055445263937:ios:1545da50efd278155548c0',
    messagingSenderId: '1055445263937',
    projectId: 'i-chat-d0b42',
    storageBucket: 'i-chat-d0b42.appspot.com',
    androidClientId: '1055445263937-k6vcnmiebg8e87om04i0ruvm0vlaladl.apps.googleusercontent.com',
    iosClientId: '1055445263937-qp2rm3ajaiviqi28hoa0cg2kbnd6rrdj.apps.googleusercontent.com',
    iosBundleId: 'com.example.iChat',
  );
}
