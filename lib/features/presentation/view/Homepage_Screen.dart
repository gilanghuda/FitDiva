import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:fitdiva/features/presentation/view/Homepage_Widget.dart';
import 'package:flutter/material.dart';
import 'package:fitdiva/features/domain/entities/exercise.dart';
import 'package:fitdiva/features/domain/usecases/get_exercises.dart';
import 'package:provider/provider.dart';
import 'package:fitdiva/features/presentation/provider/exercise_provider.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final Map<String, bool> _selectedFilters = {
    'All': true,
    'Warm Up': false,
    'Yoga': false,
    'Biceps': false,
    'Chest': false,
    'Legs': false,
  };

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  Future<void> _fetchExercises() async {
    try {
      print('Fetching all exercises...');
      await Provider.of<ExerciseProvider>(
        context,
        listen: false,
      ).fetchAllExercises();
      print('Fetched all exercises successfully.');
      _applyFilters();
    } catch (e) {
      print('Error fetching exercises: $e');
    }
  }

  void _applyFilters() {
    final exerciseProvider =
        Provider.of<ExerciseProvider>(context, listen: false);
    List<Exercise> filteredExercises = exerciseProvider.exerciseList ?? [];

    if (_selectedFilters['All'] == true) {
      setState(() {
        exerciseProvider.filteredExerciseList = filteredExercises;
      });
      return;
    }

    List<Exercise> categoryFilteredExercises = [];
    for (var category in _selectedFilters.keys) {
      if (_selectedFilters[category] == true) {
        print('Filtering by category: $category');
        categoryFilteredExercises.addAll(
          filteredExercises.where((exercise) => exercise.category == category),
        );
      }
    }

    if (categoryFilteredExercises.isNotEmpty) {
      print(
        'Category filtered exercises count: ${categoryFilteredExercises.length}',
      );
      filteredExercises = categoryFilteredExercises;
    }

    setState(() {
      exerciseProvider.filteredExerciseList = filteredExercises;
    });
  }

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);
    final filteredExercises = exerciseProvider.filteredExerciseList ?? [];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'FitDiva',
          style: AppTextStyles.heading_1_bold.copyWith(color: AppColors.Black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: AppColors.Black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            Card(
              color: AppColors.Primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Now!\nSet Your Fitness Goals',
                      style: AppTextStyles.heading_2_bold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.Primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Start Exercise',
                        style: AppTextStyles.paragraph_14_bold.copyWith(
                          color: AppColors.Primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _selectedFilters.keys.map((category) {
                  return _buildFilterChip(category);
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Workout List Section
            ...filteredExercises.map((exercise) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: HomepageWidget().WorkoutListCard(
                  title: exercise.name,
                  subtitle: '${exercise.count} Exercises',
                  duration: '${exercise.duration} Min',
                  imagePath: exercise.image,
                  onTap: () => _showExerciseDetails(context, exercise),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String category) {
    final isSelected = _selectedFilters[category] ?? false;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(
          category,
          style: AppTextStyles.paragraph_14_bold.copyWith(
            color: isSelected ? AppColors.Primary : AppColors.grey,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilters.forEach((key, value) {
              _selectedFilters[key] = false;
            });
            _selectedFilters[category] = true;
          });
          _applyFilters();
        },
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(
            color: isSelected ? AppColors.Primary : AppColors.grey,
          ),
        ),
        selectedColor: Colors.transparent,
      ),
    );
  }

  void _showExerciseDetails(BuildContext context, Exercise exercise) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Image.network(exercise.image, width: 60, height: 60),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: AppTextStyles.heading_3_bold,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${exercise.count} Exercises • ${exercise.duration} Min',
                        style: AppTextStyles.paragraph_14_regular,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Exercises',
                style: AppTextStyles.heading_3_bold,
              ),
              const SizedBox(height: 8),
              ...exercise.exercises.map((e) => Text(
                    '- $e',
                    style: AppTextStyles.paragraph_14_regular,
                  )),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Start Exercise',
                    style: AppTextStyles.paragraph_14_bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
