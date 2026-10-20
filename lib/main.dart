import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/firebase_options.dart';
import 'package:movies/local/app_database.dart';
import 'package:movies/local/makeup_note_local_data_source.dart';
import 'package:movies/repositories/makeup_note_repository.dart';
import 'makeup_screen.dart';

Future<void> main() async {
  // Punto de entrada de la aplicacion.
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {
    // La app funciona offline aunque Firebase no inicialice.
  }
  final database = AppDatabase();
  final repository = MakeupNoteRepository(MakeupNoteLocalDataSource(database));
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final MakeupNoteRepository repository;

  const MyApp({super.key, required this.repository});

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
      home: MakeupScreen(repository: repository),
    );
  }
}
