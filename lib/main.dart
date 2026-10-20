import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/firebase_options.dart';
import 'makeup_screen.dart';

Future<void> main() async {
  // Punto de entrada de la aplicacion.
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {
    // La app funciona offline aunque Firebase no inicialice.
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC44569),
          brightness: Brightness.light,
        ),
      ),
      home: const MakeupScreen(),
    );
  }
}
