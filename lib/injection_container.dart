import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_and_learn/features/arithmetic/data/datasources/arithmetic_local_data_source.dart';
import 'package:tap_and_learn/features/arithmetic/data/repositories/arithmetic_repository_impl.dart';
import 'package:tap_and_learn/features/arithmetic/domain/repositories/arithmetic_repository.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/generate_multiplication_exercise.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/get_selected_multiplicands.dart';
import 'package:tap_and_learn/features/arithmetic/domain/usecases/save_selected_multiplicands.dart';
import 'package:tap_and_learn/features/arithmetic/presentation/bloc/multiplication_execise_bloc.dart';
import 'package:tap_and_learn/features/arithmetic/presentation/widgets/multiplicand_selector/cubit/multiplicand_config_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Arithmetic
  // Cubit
  sl.registerLazySingleton(() => MultiplicandConfigCubit(
        getSelectedMultiplicands: sl(),
        saveSelectedMultiplicands: sl(),
      ));

  // Bloc
  sl.registerFactory(
    () => MultiplicationExerciseBloc(
      generateMultiplicationExercise: sl(),
      multiplicandConfigCubit: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GenerateMultiplicationExercise(sl()));
  sl.registerLazySingleton(() => GetSelectedMultiplicands(sl()));
  sl.registerLazySingleton(() => SaveSelectedMultiplicands(sl()));

  // Repository
  sl.registerLazySingleton<ArithmeticRepository>(
    () => ArithmeticRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ArithmeticLocalDataSource>(
    () => ArithmeticLocalDataSourceImpl(
      random: sl(),
      sharedPreferences: sl(),
    ),
  );

  //! External
  sl.registerLazySingleton(() => Random());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
