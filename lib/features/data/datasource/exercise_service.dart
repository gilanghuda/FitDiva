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
      print('Sending exercise to Firestore: ${exercise.toJson()}'); // Debug log
      await _firestore.collection('exercises').add(exercise.toJson());
      print('Exercise added to Firestore successfully'); // Debug log
    } catch (e) {
      print('Failed to add exercise to Firestore: $e'); // Debug log
      throw Exception('Failed to add exercise: $e');
    }
  }
}
