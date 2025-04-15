import 'package:flutter/material.dart';
import 'package:fitdiva/features/domain/entities/exercise.dart';
import 'package:fitdiva/features/domain/usecases/get_exercises.dart';
import 'package:fitdiva/features/domain/usecases/add_exercise.dart';

class ExerciseProvider with ChangeNotifier {
  final GetExercises getExercises;
  final AddExercise addExercise; // Add AddExercise use case

  ExerciseProvider({
    required this.getExercises,
    required this.addExercise,
  });

  List<Exercise>? _exerciseList;
  List<Exercise>? _filteredExerciseList;

  List<Exercise>? get exerciseList => _exerciseList;
  List<Exercise>? get filteredExerciseList => _filteredExerciseList;

  Future<void> fetchAllExercises() async {
    try {
      _exerciseList = await getExercises();
      _filteredExerciseList = _exerciseList;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch exercises: $e');
    }
  }

  Future<void> addNewExercise(Exercise exercise) async {
    try {
      print('Adding exercise: ${exercise.name}'); // Debug log
      await addExercise(exercise);
      _exerciseList?.add(exercise);
      _filteredExerciseList = _exerciseList;
      notifyListeners();
      print('Exercise added successfully: ${exercise.name}'); // Debug log
    } catch (e) {
      print('Failed to add exercise: $e'); // Debug log
      throw Exception('Failed to add exercise: $e');
    }
  }

  set filteredExerciseList(List<Exercise>? exercises) {
    _filteredExerciseList = exercises;
    notifyListeners();
  }
}
