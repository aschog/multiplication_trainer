import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiply_fast/features/generateQustion/domain/entities/question.dart';
import 'package:multiply_fast/features/generateQustion/domain/repositories/practice_repository.dart';
import 'package:multiply_fast/features/generateQustion/domain/usecases/generate_question.dart';
import 'generate_question_test.mocks.dart';
// class MockPracticeRepository extends Mock implements PracticeRepository {}

@GenerateMocks([PracticeRepository])
void main() {
  late GenerateQuestion usecase;
  late MockPracticeRepository mockPracticeRepository;

  setUp(() {
    mockPracticeRepository = MockPracticeRepository();
    usecase = GenerateQuestion(mockPracticeRepository);
  });

  final tFactor1 = 2;
  final tFactor2 = 3;
  final tQuestion = Question(factor1: tFactor1, factor2: tFactor2, answer: 6);

  test('should calculate correct answer', () {
    when(mockPracticeRepository.getQuestion()).thenAnswer((_) => Right(tQuestion));
    final result = usecase.execute();
    expect(result, Right(tQuestion));
    verify(mockPracticeRepository.getQuestion());
    verifyNoMoreInteractions(mockPracticeRepository);
  });
}
