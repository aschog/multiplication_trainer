part of 'multiplication_execise_bloc.dart';

abstract class MultiplicationExerciseEvent extends Equatable {
  const MultiplicationExerciseEvent();

  @override
  List<Object> get props => [];
}

class ExerciseRequested extends MultiplicationExerciseEvent {}

class ButtonPressed extends MultiplicationExerciseEvent {
  final String buttonText;

  const ButtonPressed(this.buttonText);

  @override
  List<Object> get props => [buttonText];
}
