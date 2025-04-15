import 'package:fitdiva/features/data/datasource/auth_service.dart';
import 'package:fitdiva/features/data/datasource/exercise_service.dart';
import 'package:fitdiva/features/data/repositories/auth_repositories_impl.dart';
import 'package:fitdiva/features/data/repositories/exercise_repository_impl.dart';
import 'package:fitdiva/features/domain/repositories/auth_repository.dart';
import 'package:fitdiva/features/domain/repositories/exercise_repository.dart';
import 'package:fitdiva/features/domain/usecases/add_exercise.dart';
import 'package:fitdiva/features/domain/usecases/get_exercises.dart';
import 'package:fitdiva/features/domain/usecases/login_user.dart';
import 'package:fitdiva/features/domain/usecases/register_user.dart';
import 'package:fitdiva/features/presentation/provider/auth_provider.dart';
import 'package:fitdiva/features/presentation/provider/exercise_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final sl = GetIt.instance;

void setupDependencyInjection() {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Data Layer
  sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  sl.registerLazySingleton<ExerciseService>(() => ExerciseService());

  // Repository Layer
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ExerciseRepository>(
      () => ExerciseRepositoryImpl(sl()));
  // Use Cases
  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl()));
  sl.registerLazySingleton<RegisterUser>(() => RegisterUser(sl()));
  sl.registerLazySingleton<GetExercises>(() => GetExercises(sl()));
  sl.registerLazySingleton<AddExercise>(() => AddExercise(sl())); // Add AddExercise use case

  // Providers
  sl.registerLazySingleton<AuthProvider>(() => AuthProvider(
      loginUser: sl(), registerUser: sl(), authService: FirebaseAuthService()));
  sl.registerLazySingleton<ExerciseProvider>(() => ExerciseProvider(
        getExercises: sl(),
        addExercise: sl(), // Add AddExercise use case
      ));
}
