// Opciones de Firebase (datos tomados de google-services.json)

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXcThW2Oplisk8o82YNNLC2F4RighyGAY',
    appId: '1:386004772357:android:6d852991e1ee34abc65e6c',
    messagingSenderId: '386004772357',
    projectId: 'siee-abf20',
    databaseURL: 'https://siee-abf20-default-rtdb.firebaseio.com',
    storageBucket: 'siee-abf20.firebasestorage.app',
  );
}
