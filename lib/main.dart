import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MindraApp());

class MindraApp extends StatelessWidget {
  const MindraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F3FF),
      ),
      home: const HomeScreen(),
    );
  }
}
