import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tap_and_learn/features/arithmetic/domain/repositories/arithmetic_repository.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/save_selected_multiplicands.dart';

import 'save_selected_multiplicands_test.mocks.dart';

@GenerateMocks([ArithmeticRepository])
void main() {
  late SaveSelectedMultiplicands usecase;
  late MockArithmeticRepository mockRepository;

  setUp(() {
    mockRepository = MockArithmeticRepository();
    usecase = SaveSelectedMultiplicands(mockRepository);
  });

  final tMultiplicands = [1, 2, 3];

  test('should save list of multiplicands to the repository', () async {
    // arrange
    when(mockRepository.saveSelectedMultiplicands(any))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(Params(multiplicands: tMultiplicands));
    // assert
    expect(result, const Right(null));
    verify(mockRepository.saveSelectedMultiplicands(tMultiplicands));
    verifyNoMoreInteractions(mockRepository);
  });
}
