import 'package:flutter/material.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/pages/multiplication_trainer_screen.dart';
import 'injection_container.dart' as di;
import 'package:multiplication_trainer/config/theme/app_theme.dart';

void main() async {
  await di.init();
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiplication Trainer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MultiplicationTrainerScreen(),
    );
  }
}
