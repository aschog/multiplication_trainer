import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tap_and_learn/core/usecases/usecase.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/get_selected_multiplicands.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/save_selected_multiplicands.dart';
import 'package:tap_and_learn/features/arithmetic/presentation/widgets/multiplicand_selector/cubit/multiplicand_config_cubit.dart';

import 'multiplicand_config_cubit_test.mocks.dart';

@GenerateMocks([GetSelectedMultiplicands, SaveSelectedMultiplicands])
void main() {
  late MultiplicandConfigCubit cubit;
  late MockGetSelectedMultiplicands mockGetSelectedMultiplicands;
  late MockSaveSelectedMultiplicands mockSaveSelectedMultiplicands;

  setUp(() {
    mockGetSelectedMultiplicands = MockGetSelectedMultiplicands();
    mockSaveSelectedMultiplicands = MockSaveSelectedMultiplicands();
    // Default stub for loadMultiplicands
    when(mockGetSelectedMultiplicands(any))
        .thenAnswer((_) async => const Right([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
    when(mockSaveSelectedMultiplicands(any))
        .thenAnswer((_) async => const Right(null));
  });

  group('MultiplicandConfigCubit', () {
    test('initial state is correct', () {
      cubit = MultiplicandConfigCubit(
        getSelectedMultiplicands: mockGetSelectedMultiplicands,
        saveSelectedMultiplicands: mockSaveSelectedMultiplicands,
      );
      expect(
          cubit.state,
          const MultiplicandConfigState(
              selectedMultiplicands: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
    });

    blocTest<MultiplicandConfigCubit, MultiplicandConfigState>(
      'emits loaded multiplicands when initialized',
      build: () {
        when(mockGetSelectedMultiplicands(any))
            .thenAnswer((_) async => const Right([1, 2, 3]));
        return MultiplicandConfigCubit(
          getSelectedMultiplicands: mockGetSelectedMultiplicands,
          saveSelectedMultiplicands: mockSaveSelectedMultiplicands,
        );
      },
      expect: () => [
        const MultiplicandConfigState(selectedMultiplicands: [1, 2, 3]),
      ],
      verify: (_) {
        verify(mockGetSelectedMultiplicands(NoParams())).called(1);
      },
    );

    blocTest<MultiplicandConfigCubit, MultiplicandConfigState>(
      'toggleMultiplicand adds multiplicand if not present and saves',
      build: () => MultiplicandConfigCubit(
        getSelectedMultiplicands: mockGetSelectedMultiplicands,
        saveSelectedMultiplicands: mockSaveSelectedMultiplicands,
      ),
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        await cubit.toggleMultiplicand(10);
      },
      skip: 1,
      expect: () => [
        const MultiplicandConfigState(
            selectedMultiplicands: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
      ],
      verify: (_) {
        verify(mockSaveSelectedMultiplicands(const Params(
                multiplicands: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])))
            .called(1);
      },
    );

    blocTest<MultiplicandConfigCubit, MultiplicandConfigState>(
      'toggleMultiplicand removes multiplicand if present and saves',
      build: () {
        // Initial load will happen, we just want to test toggle after that
        return MultiplicandConfigCubit(
          getSelectedMultiplicands: mockGetSelectedMultiplicands,
          saveSelectedMultiplicands: mockSaveSelectedMultiplicands,
        );
      },
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        await cubit.toggleMultiplicand(0);
      },
      skip: 1,
      expect: () => [
        const MultiplicandConfigState(
            selectedMultiplicands: [1, 2, 3, 4, 5, 6, 7, 8, 9]),
      ],
      verify: (_) {
        verify(mockSaveSelectedMultiplicands(
                const Params(multiplicands: [1, 2, 3, 4, 5, 6, 7, 8, 9])))
            .called(1);
      },
    );

    blocTest<MultiplicandConfigCubit, MultiplicandConfigState>(
      'updateMultiplicands updates list and saves',
      build: () => MultiplicandConfigCubit(
        getSelectedMultiplicands: mockGetSelectedMultiplicands,
        saveSelectedMultiplicands: mockSaveSelectedMultiplicands,
      ),
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        await cubit.updateMultiplicands([1, 2]);
      },
      skip: 1,
      expect: () => [
        const MultiplicandConfigState(selectedMultiplicands: [1, 2]),
      ],
      verify: (_) {
        verify(mockSaveSelectedMultiplicands(
                const Params(multiplicands: [1, 2])))
            .called(1);
      },
    );
  });
}
