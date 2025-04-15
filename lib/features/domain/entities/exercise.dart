class Exercise {
  final String name;
  final int count;
  final List<String> exercises;
  final int duration;
  final String image;
  final String category; // New attribute

  Exercise({
    required this.name,
    required this.count,
    required this.exercises,
    required this.duration,
    required this.image,
    required this.category,
  });
}
