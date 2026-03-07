import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {
    // Si falla (ej. emulador sin Google Play), la app igual arranca
  }
  runApp(const SieeApp());
}

class SieeApp extends StatelessWidget {
  const SieeApp({super.key});

  static const Color _primaryBase = Color(0xFF193863);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIEE Formulario',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: _primaryBase,
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFD6E4F5),
          onPrimaryContainer: const Color(0xFF0E2442),
          secondary: const Color(0xFF4A6B8F),
          onSecondary: Colors.white,
          secondaryContainer: const Color(0xFFE2EDF7),
          onSecondaryContainer: const Color(0xFF1E3A57),
          surface: Colors.white,
          onSurface: const Color(0xFF1A1D21),
          surfaceContainerHighest: const Color(0xFFEEF2F7),
          onSurfaceVariant: const Color(0xFF4E5D6E),
          outline: const Color(0xFF7D8FA3),
          error: const Color(0xFFBA1A1A),
          onError: Colors.white,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: _primaryBase,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _primaryBase,
          foregroundColor: Colors.white,
          elevation: 2,
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: _primaryBase,
            foregroundColor: Colors.white,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _primaryBase, width: 1.5),
          ),

          labelStyle: const TextStyle(color: Color(0xFF4E5D6E)),
        ),

        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
        ),

        chipTheme: ChipThemeData(
          selectedColor: _primaryBase.withValues(alpha: 0.2),
          checkmarkColor: _primaryBase,
        ),
      ),
      
      home: const HomeScreen(),
    );
  }
}
