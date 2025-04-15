import '../entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchExercises();
  Future<void> addExercise(Exercise exercise);
}
