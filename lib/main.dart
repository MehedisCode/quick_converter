// main.dart
import 'package:flutter/material.dart';
import '/screens/landing_screen.dart';

void main() {
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
