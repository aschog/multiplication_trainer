import 'package:flutter/material.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/pages/multiplication_trainer_screen.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiplication Trainer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFFA6A6A6),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 100,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: const MultiplicationTrainerScreen(),
    );
  }
}
