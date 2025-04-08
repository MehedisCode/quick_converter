// main.dart
import 'package:flutter/material.dart';
import '/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(QuickConvertApp());
}

class QuickConvertApp extends StatelessWidget {
  const QuickConvertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickConvert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingScreen(),
    );
  }
}
