import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_and_learn/features/arithmetic/data/models/multiplication_exercise_model.dart';

abstract class ArithmeticLocalDataSource {
  final Random random;

  ArithmeticLocalDataSource({required this.random});
  Future<MultiplicationExerciseModel> generateMultiplicationExercise(
      List<int> multiplicands);
  Future<List<int>> getSelectedMultiplicands();
  Future<void> saveSelectedMultiplicands(List<int> multiplicands);
}

const cachedMultiplicandsKey = 'CACHED_MULTIPLICANDS';

class ArithmeticLocalDataSourceImpl implements ArithmeticLocalDataSource {
  @override
  final Random random;
  final SharedPreferences sharedPreferences;

  ArithmeticLocalDataSourceImpl({
    required this.random,
    required this.sharedPreferences,
  });
  final int _maxMultiplier = 10;
  @override
  Future<MultiplicationExerciseModel> generateMultiplicationExercise(
      List<int> multiplicands) async {
    final multiplicand = multiplicands.length == 1
        ? multiplicands[0]
        : multiplicands[random.nextInt(multiplicands.length)];
    final multiplier = random.nextInt(_maxMultiplier);
    final product = multiplicand * multiplier;

    return MultiplicationExerciseModel(
        multiplicand: multiplicand, multiplier: multiplier, product: product);
  }

  @override
  Future<List<int>> getSelectedMultiplicands() {
    final jsonString = sharedPreferences.getStringList(cachedMultiplicandsKey);
    if (jsonString != null) {
      return Future.value(jsonString.map((e) => int.parse(e)).toList());
    } else {
      return Future.value([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    }
  }

  @override
  Future<void> saveSelectedMultiplicands(List<int> multiplicands) {
    final List<String> stringList =
        multiplicands.map((e) => e.toString()).toList();
    return sharedPreferences.setStringList(cachedMultiplicandsKey, stringList);
  }
}
