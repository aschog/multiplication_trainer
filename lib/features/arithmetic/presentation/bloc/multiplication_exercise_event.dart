part of 'multiplication_execise_bloc.dart';

abstract class MultiplicationExerciseEvent extends Equatable {
  const MultiplicationExerciseEvent();

  @override
  List<Object> get props => [];
}

class ButtonPressed extends MultiplicationExerciseEvent {
  final String buttonText;

  ButtonPressed(this.buttonText);
}
