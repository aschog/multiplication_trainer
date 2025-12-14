import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tap_and_learn/core/usecases/usecase.dart';
import 'package:tap_and_learn/features/arithmetic/domain/repositories/arithmetic_repository.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/get_selected_multiplicands.dart';

import 'get_selected_multiplicands_test.mocks.dart';

@GenerateMocks([ArithmeticRepository])
void main() {
  late GetSelectedMultiplicands usecase;
  late MockArithmeticRepository mockRepository;

  setUp(() {
    mockRepository = MockArithmeticRepository();
    usecase = GetSelectedMultiplicands(mockRepository);
  });

  final tMultiplicands = [1, 2, 3];

  test('should get list of multiplicands from the repository', () async {
    // arrange
    when(mockRepository.getSelectedMultiplicands())
        .thenAnswer((_) async => Right(tMultiplicands));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tMultiplicands));
    verify(mockRepository.getSelectedMultiplicands());
    verifyNoMoreInteractions(mockRepository);
  });
}
