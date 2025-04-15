import 'package:fitdiva/features/domain/entities/exercise.dart';
import 'package:fitdiva/features/domain/repositories/exercise_repository.dart';

class GetExercises {
  final ExerciseRepository repository;

  GetExercises(this.repository);

  Future<List<Exercise>> call() async {
    return await repository.fetchExercises();
  }
}
