/// File: /lib/main.dart
/// Project: Evento
///
/// Main file of the project.
///
/// 17.12.2023

import 'package:flutter/material.dart';
import 'package:itu/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evento',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              background: Colors.black,
            ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
