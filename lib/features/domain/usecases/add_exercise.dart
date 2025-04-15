import 'package:fitdiva/features/domain/entities/exercise.dart';
import 'package:fitdiva/features/domain/repositories/exercise_repository.dart';

class AddExercise {
  final ExerciseRepository repository;

  AddExercise(this.repository);

  Future<void> call(Exercise exercise) async {
    await repository.addExercise(exercise);
  }
}
