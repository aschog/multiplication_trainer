import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiplication_trainer/core/usecases/usecase.dart';
import 'package:multiplication_trainer/features/arithmetic/domain/entities/multiplication_exercise.dart';
import 'package:multiplication_trainer/features/arithmetic/domain/usecases/generate_multiplication_exercise.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/bloc/multiplication_execise_bloc.dart';

import 'multiplication_exercise_bloc_test.mocks.dart';

@GenerateMocks([GenerateMultiplicationExercise])
void main() {
  late MockGenerateMultiplicationExercise mockGenerateMultiplicationExercise;

  setUp(() {
    mockGenerateMultiplicationExercise = MockGenerateMultiplicationExercise();
  });

  final tExercise =
      MultiplicationExercise(multiplicand: 7, multiplier: 8); // 56
  const tInitialState = MultiplicationExerciseState(
      displayOutput: '0', status: AnswerStatus.initial);
  final tExerciseLoadedState = MultiplicationExerciseState(
      exercise: tExercise,
      displayOutput: '7 × 8',
      status: AnswerStatus.initial);

  blocTest<MultiplicationExerciseBloc, MultiplicationExerciseState>(
    'emits [exercise, initial] when created',
    build: () {
      when(mockGenerateMultiplicationExercise(any))
          .thenAnswer((_) async => Right(tExercise));
      return MultiplicationExerciseBloc(
        generateMultiplicationExercise: mockGenerateMultiplicationExercise,
      );
    },
    expect: () => [tExerciseLoadedState],
  );

  group('ButtonPressed', () {
    blocTest<MultiplicationExerciseBloc, MultiplicationExerciseState>(
      'emits [entering, correct] and requests new exercise for correct answer',
      build: () {
        when(mockGenerateMultiplicationExercise(any))
            .thenAnswer((_) async => Right(tExercise));
        return MultiplicationExerciseBloc(
          generateMultiplicationExercise: mockGenerateMultiplicationExercise,
        );
      },
      seed: () => tExerciseLoadedState,
      act: (bloc) async {
        bloc.add(const ButtonPressed('5'));
        bloc.add(const ButtonPressed('6'));
        // Wait for the delay inside the bloc to complete
        await Future.delayed(const Duration(seconds: 1));
      },
      expect: () => <MultiplicationExerciseState>[
        tExerciseLoadedState.copyWith(
            displayOutput: '5', status: AnswerStatus.entering),
        tExerciseLoadedState.copyWith(
            displayOutput: '56', status: AnswerStatus.entering),
        tExerciseLoadedState.copyWith(
            displayOutput: '56', status: AnswerStatus.correct),
        // This is the state after the new exercise is requested
        tExerciseLoadedState.copyWith(
            displayOutput: '7 × 8', status: AnswerStatus.initial),
      ],
      verify: (_) {
        // The use case should be called twice: once for the initial load,
        // and once after the correct answer.
        verify(mockGenerateMultiplicationExercise(NoParams())).called(2);
      },
    );

    blocTest<MultiplicationExerciseBloc, MultiplicationExerciseState>(
      'emits [entering, incorrect] and resets for incorrect answer',
      build: () {
        when(mockGenerateMultiplicationExercise(any))
            .thenAnswer((_) async => Right(tExercise));
        return MultiplicationExerciseBloc(
          generateMultiplicationExercise: mockGenerateMultiplicationExercise,
        );
      },
      seed: () => tExerciseLoadedState,
      act: (bloc) async {
        bloc.add(const ButtonPressed('1'));
        bloc.add(const ButtonPressed('2'));
        // Wait for the delay inside the bloc to complete
        await Future.delayed(const Duration(seconds: 1));
      },
      expect: () => <MultiplicationExerciseState>[
        tExerciseLoadedState.copyWith(
            displayOutput: '1', status: AnswerStatus.entering),
        tExerciseLoadedState.copyWith(
            displayOutput: '12', status: AnswerStatus.entering),
        tExerciseLoadedState.copyWith(
            displayOutput: '12', status: AnswerStatus.incorrect),
        // This is the state after resetting to the original exercise
        tExerciseLoadedState.copyWith(
            displayOutput: '7 × 8', status: AnswerStatus.initial),
      ],
    );

    blocTest<MultiplicationExerciseBloc, MultiplicationExerciseState>(
      'requests a new exercise when "AC" is pressed',
      build: () {
        when(mockGenerateMultiplicationExercise(any))
            .thenAnswer((_) async => Right(tExercise));
        return MultiplicationExerciseBloc(
          generateMultiplicationExercise: mockGenerateMultiplicationExercise,
        );
      },
      seed: () => tExerciseLoadedState,
      act: (bloc) => bloc.add(const ButtonPressed('AC')),
      expect: () => <MultiplicationExerciseState>[
        tExerciseLoadedState,
      ],
      verify: (_) {
        // Called once for the seed, and once for the 'AC' press.
        verify(mockGenerateMultiplicationExercise(NoParams())).called(2);
      },
    );
  });
}
