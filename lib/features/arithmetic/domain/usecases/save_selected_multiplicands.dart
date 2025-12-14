import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tap_and_learn/core/error/faiures.dart';
import 'package:tap_and_learn/core/usecases/usecase.dart';
import 'package:tap_and_learn/features/arithmetic/domain/repositories/arithmetic_repository.dart';

class SaveSelectedMultiplicands implements UseCase<void, Params> {
  final ArithmeticRepository repository;

  SaveSelectedMultiplicands(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.saveSelectedMultiplicands(params.multiplicands);
  }
}

class Params extends Equatable {
  final List<int> multiplicands;

  const Params({required this.multiplicands});

  @override
  List<Object?> get props => [multiplicands];
}
