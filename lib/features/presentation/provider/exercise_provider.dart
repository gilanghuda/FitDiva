import 'package:flutter/material.dart';
import 'package:fitdiva/features/domain/entities/exercise.dart';
import 'package:fitdiva/features/domain/usecases/get_exercises.dart';

class ExerciseProvider with ChangeNotifier {
  final GetExercises getExercises;

  ExerciseProvider({required this.getExercises});

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

  set filteredExerciseList(List<Exercise>? exercises) {
    _filteredExerciseList = exercises;
    notifyListeners();
  }
}
