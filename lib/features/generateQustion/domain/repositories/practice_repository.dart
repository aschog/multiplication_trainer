import 'package:multiply_fast/core/error/faiures.dart';
import 'package:multiply_fast/features/generateQustion/domain/entities/question.dart';
import 'package:dartz/dartz.dart';

abstract class PracticeRepository {
  Either<Failure, Question> getQuestion(int factor1, int factor2);
}
