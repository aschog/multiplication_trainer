import 'package:dartz/dartz.dart';
import 'package:multiply_fast/core/error/faiures.dart';
import 'package:multiply_fast/features/generateQustion/domain/entities/question.dart';
import 'package:multiply_fast/features/generateQustion/domain/repositories/practice_repository.dart';

class GenerateQuestion {
  final PracticeRepository repository;

  GenerateQuestion(this.repository);

  Either<Failure, Question> execute() {
    return repository.getQuestion();
  }
}
