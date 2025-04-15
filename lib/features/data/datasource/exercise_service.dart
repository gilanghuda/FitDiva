import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitdiva/features/data/models/exercise_model.dart';

class ExerciseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ExerciseModel>> fetchExercises() async {
    try {
      final snapshot = await _firestore.collection('exercises').get();
      return snapshot.docs
          .map((doc) => ExerciseModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch exercises: $e');
    }
  }

  Future<void> addExercise(ExerciseModel exercise) async {
    try {
      await _firestore.collection('exercises').add(exercise.toJson());
    } catch (e) {
      throw Exception('Failed to add exercise: $e');
    }
  }
}
