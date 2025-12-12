import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class MultiplicandConfigState extends Equatable {
  final List<int> selectedMultiplicands;

  const MultiplicandConfigState({required this.selectedMultiplicands});

  factory MultiplicandConfigState.initial() {
    return const MultiplicandConfigState(
      selectedMultiplicands: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    );
  }

  MultiplicandConfigState copyWith({List<int>? selectedMultiplicands}) {
    return MultiplicandConfigState(
      selectedMultiplicands:
          selectedMultiplicands ?? this.selectedMultiplicands,
    );
  }

  @override
  List<Object> get props => [selectedMultiplicands];
}

class MultiplicandConfigCubit extends Cubit<MultiplicandConfigState> {
  MultiplicandConfigCubit() : super(MultiplicandConfigState.initial());

  void toggleMultiplicand(int multiplicand) {
    final currentSelection = List<int>.from(state.selectedMultiplicands);
    if (currentSelection.contains(multiplicand)) {
      if (currentSelection.length > 1) {
        currentSelection.remove(multiplicand);
      }
    } else {
      currentSelection.add(multiplicand);
    }
    currentSelection.sort();
    emit(state.copyWith(selectedMultiplicands: currentSelection));
  }

  void updateMultiplicands(List<int> newMultiplicands) {
    final sorted = List<int>.from(newMultiplicands)..sort();
    emit(state.copyWith(selectedMultiplicands: sorted));
  }
}
