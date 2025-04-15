import 'package:fitdiva/features/data/datasource/exercise_service.dart';
import 'package:fitdiva/features/data/models/exercise_model.dart';
import 'package:fitdiva/features/domain/entities/exercise.dart';
import 'package:fitdiva/features/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseService exerciseService;

  ExerciseRepositoryImpl(this.exerciseService);

  @override
  Future<List<Exercise>> fetchExercises() async {
    final exercises = await exerciseService.fetchExercises();
    return exercises
        .map((exercise) => Exercise(
              name: exercise.name,
              count: exercise.count,
              exercises: exercise.exercises,
              duration: exercise.duration,
              image: exercise.image,
              category: exercise.category, 
            ))
        .toList();
  }

  @override
  Future<void> addExercise(Exercise exercise) async {
    final exerciseModel = ExerciseModel(
      name: exercise.name,
      count: exercise.count,
      exercises: exercise.exercises,
      duration: exercise.duration,
      image: exercise.image,
      category: exercise.category, 
    );
    await exerciseService.addExercise(exerciseModel);
  }
}
