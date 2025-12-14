import 'package:dartz/dartz.dart';
import 'package:tap_and_learn/core/error/faiures.dart';
import 'package:tap_and_learn/features/arithmetic/data/datasources/arithmetic_local_data_source.dart';
import 'package:tap_and_learn/features/arithmetic/domain/entities/multiplication_exercise.dart';
import 'package:tap_and_learn/features/arithmetic/domain/repositories/arithmetic_repository.dart';

class ArithmeticRepositoryImpl implements ArithmeticRepository {
  final ArithmeticLocalDataSource localDataSource;

  ArithmeticRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, MultiplicationExercise>>
      generateMultiplicationExercise(List<int> multiplicands) async {
    final exerciseModel =
        await localDataSource.generateMultiplicationExercise(multiplicands);
    return Right(exerciseModel);
  }

  @override
  Future<Either<Failure, List<int>>> getSelectedMultiplicands() async {
    try {
      final result = await localDataSource.getSelectedMultiplicands();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveSelectedMultiplicands(
      List<int> multiplicands) async {
    try {
      await localDataSource.saveSelectedMultiplicands(multiplicands);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
