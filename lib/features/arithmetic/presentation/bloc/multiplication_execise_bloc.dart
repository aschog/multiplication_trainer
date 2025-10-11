import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'multiplication_exercise_event.dart';
part 'multiplication_exercise_state.dart';

class MultiplicationExerciseBloc
    extends Bloc<MultiplicationExerciseEvent, MultiplicationExerciseState> {
  MultiplicationExerciseBloc()
    : super(MultiplicationExerciseState(displayOutput: '0')) {
    on<ButtonPressed>((event, emit) {
      // Handle button presses and update the display output.
      // Example:
      String newDisplayOutput = state.displayOutput == '0'
          ? event.buttonText
          : state.displayOutput + event.buttonText;
      emit(MultiplicationExerciseState(displayOutput: newDisplayOutput));
    });
  }
}
