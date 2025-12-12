import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplication_trainer/config/theme/app_colors.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/bloc/multiplication_execise_bloc.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/widgets/multiplicand_selector/cubit/multiplicand_config_cubit.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/widgets/keypad.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/widgets/multiplicand_selector/multiplicand_selector.dart';
import 'package:multiplication_trainer/injection_container.dart';
import 'package:flutter/foundation.dart';

class MultiplicationTrainerScreen extends StatelessWidget {
  const MultiplicationTrainerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MultiplicandConfigCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<MultiplicationExerciseBloc>(),
        ),
      ],
      child: const _MultiplicationTrainerView(),
    );
  }
}

class _MultiplicationTrainerView extends StatefulWidget {
  const _MultiplicationTrainerView({
    super.key,
  });

  @override
  State<_MultiplicationTrainerView> createState() =>
      _MultiplicationTrainerViewState();
}

class _MultiplicationTrainerViewState
    extends State<_MultiplicationTrainerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: BlocBuilder<MultiplicationExerciseBloc,
              MultiplicationExerciseState>(builder: (context, state) {
            return _buildScreen(context, state);
          }),
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, MultiplicationExerciseState state) {
    final gameColors = Theme.of(context).extension<GameThemeColors>()!;
    Color displayColor = gameColors.textMainColor!;
    if (state.status == AnswerStatus.incorrect) {
      displayColor = Colors.red;
    } else if (state.status == AnswerStatus.correct) {
      displayColor = Colors.green;
    }

    return Container(
      decoration: kIsWeb
          ? BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Column(
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerRight,
                child: MultiplicandSelector(),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                state.displayOutput,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: displayColor),
              ),
            ),
            const Spacer(),
            Keypad(
              onNumberTap: (number) => context
                  .read<MultiplicationExerciseBloc>()
                  .add(ButtonPressed(number)),
              onBackspaceTap: () => context
                  .read<MultiplicationExerciseBloc>()
                  .add(BackspacePressed()),
              onRefreshTap: () => context
                  .read<MultiplicationExerciseBloc>()
                  .add(ExerciseRequested()),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
