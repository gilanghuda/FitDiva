import 'package:fitdiva/features/domain/entities/exercise.dart';

class ExerciseModel extends Exercise {
  ExerciseModel({
    required super.name,
    required super.count,
    required super.exercises,
    required super.duration,
    required super.image,
    required super.category,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      name: json['name'],
      count: json['count'],
      exercises: List<String>.from(json['exercises']),
      duration: json['duration'],
      image: json['image'],
      category: json['category'], // New attribute
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'count': count,
      'exercises': exercises,
      'duration': duration,
      'image': image,
      'category': category, // New attribute
    };
  }
}
