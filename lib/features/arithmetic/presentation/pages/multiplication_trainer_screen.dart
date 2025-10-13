import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/bloc/multiplication_execise_bloc.dart';
import 'package:multiplication_trainer/features/arithmetic/presentation/widgets/multiplication_trainer_button.dart';
import 'package:multiplication_trainer/injection_container.dart';

class MultiplicationTrainerScreen extends StatelessWidget {
  const MultiplicationTrainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MultiplicationExerciseBloc>(),
      child: const _MultiplicationTrainerView(),
    );
  }
}

class _MultiplicationTrainerView extends StatelessWidget {
  const _MultiplicationTrainerView();
  static const Color numPadColor = Color(0xFF333333);
  static const Color utilityColor = Color(0xFFA6A6A6);
  static const Color operatorColor = Color(0xFFFF9500);
  static const Color specialZeroColor = Color(0xFF333333);

  static const double maxWidth = 450.0;
  @override
  Widget build(BuildContext context) {
    final List<List<String>> buttons = [
      ['AC', '+/-', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      [' ', '0', '.', '='],
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: maxWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white24, width: 1.0),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        child: BlocBuilder<MultiplicationExerciseBloc,
                            MultiplicationExerciseState>(
                          builder: (context, state) {
                            Color displayColor = Colors.white;
                            if (state.status == AnswerStatus.incorrect) {
                              displayColor = Colors.red;
                            } else if (state.status == AnswerStatus.correct) {
                              displayColor = Colors.green;
                            }

                            return Text(
                              state.displayOutput,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontSize: state.status ==
                                                AnswerStatus.incorrect ||
                                            state.status == AnswerStatus.correct
                                        ? 60
                                        : 90,
                                    color: displayColor,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        ),
                      ),
                    ),
                    // Button Grid
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                          right: 10,
                          left: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: buttons.map((row) {
                            return Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: row.map((button) {
                                  // Determine button color
                                  Color color = numPadColor;
                                  Color textColor = Colors.white;
                                  int flex = 1;

                                  if (['AC', '+/-', '%'].contains(button)) {
                                    color = utilityColor;
                                    textColor = Colors.black;
                                  } else if ([
                                    '÷',
                                    '×',
                                    '-',
                                    '+',
                                    '=',
                                  ].contains(button)) {
                                    color = operatorColor;
                                  }

                                  if (button == '.') {
                                    color = specialZeroColor;
                                  } else if (button == '=') {
                                    color = operatorColor;
                                  }
                                  return Expanded(
                                    flex: flex,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: MultiplicationTrainerButton(
                                        key: ValueKey(button),
                                        buttonText: button,
                                        color: color,
                                        textColor: textColor,
                                        onTap: () {
                                          BlocProvider.of<
                                                      MultiplicationExerciseBloc>(
                                                  context)
                                              .add(ButtonPressed(button));
                                        },
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
