part of 'multiplication_execise_bloc.dart';

enum AnswerStatus { initial, entering, correct, incorrect, error }

class MultiplicationExerciseState extends Equatable {
  final MultiplicationExercise? exercise;
  final String displayOutput;
  final AnswerStatus status;
  @override
  List<Object?> get props => [exercise, displayOutput, status];

  const MultiplicationExerciseState(
      {this.exercise,
      required this.displayOutput,
      this.status = AnswerStatus.initial});

  MultiplicationExerciseState copyWith({
    MultiplicationExercise? exercise,
    String? displayOutput,
    AnswerStatus? status,
  }) {
    return MultiplicationExerciseState(
      exercise: exercise ?? this.exercise,
      displayOutput: displayOutput ?? this.displayOutput,
      status: status ?? this.status,
    );
  }
}
