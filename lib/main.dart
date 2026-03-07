import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase se inicializará cuando volvamos a usar la base de datos
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SieeApp());
}

class SieeApp extends StatelessWidget {
  const SieeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIEE Formulario',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
