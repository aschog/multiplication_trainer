import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tap_and_learn/core/usecases/usecase.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/get_selected_multiplicands.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/save_selected_multiplicands.dart';

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
  final GetSelectedMultiplicands getSelectedMultiplicands;
  final SaveSelectedMultiplicands saveSelectedMultiplicands;

  MultiplicandConfigCubit({
    required this.getSelectedMultiplicands,
    required this.saveSelectedMultiplicands,
  }) : super(MultiplicandConfigState.initial()) {
    _loadMultiplicands();
  }

  Future<void> _loadMultiplicands() async {
    final result = await getSelectedMultiplicands(NoParams());
    result.fold(
      (failure) => null, // Keep initial state on failure
      (multiplicands) =>
          emit(state.copyWith(selectedMultiplicands: multiplicands)),
    );
  }

  Future<void> toggleMultiplicand(int multiplicand) async {
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
    await saveSelectedMultiplicands(Params(multiplicands: currentSelection));
  }

  Future<void> updateMultiplicands(List<int> newMultiplicands) async {
    final sorted = List<int>.from(newMultiplicands)..sort();
    emit(state.copyWith(selectedMultiplicands: sorted));
    await saveSelectedMultiplicands(Params(multiplicands: sorted));
  }
}
