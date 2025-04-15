import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:fitdiva/features/presentation/view/Homepage_Widget.dart';
import 'package:flutter/material.dart';

class HomepageScreen extends StatelessWidget {
  final HomepageWidget _homepageWidget = HomepageWidget();

  @override
  Widget build(BuildContext context) {
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

            // Progress Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress',
                  style: AppTextStyles.heading_3_bold.copyWith(
                    color: AppColors.Black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: AppTextStyles.paragraph_14_bold.copyWith(
                      color: AppColors.Primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _homepageWidget.WorkoutProgressCard(
                    title: 'Chest Workout',
                    progress: '5/12',
                    timeRemaining: '15 min remaining',
                  ),
                  const SizedBox(width: 16),
                  _homepageWidget.WorkoutProgressCard(
                    title: 'Legs Workout',
                    progress: '3/20',
                    timeRemaining: '23 min remaining',
                  ),
                  const SizedBox(width: 16),
                  // Add more cards as needed
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Categories Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: AppTextStyles.heading_3_bold.copyWith(
                    color: AppColors.Black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: AppTextStyles.paragraph_14_bold.copyWith(
                      color: AppColors.Primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Chip(
                    label: Text('All'),
                    backgroundColor: AppColors.Primary,
                    labelStyle: AppTextStyles.paragraph_14_bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text('Warm Up'),
                    backgroundColor: AppColors.grey,
                    labelStyle: AppTextStyles.paragraph_14_regular.copyWith(
                      color: AppColors.Black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text('Yoga'),
                    backgroundColor: AppColors.grey,
                    labelStyle: AppTextStyles.paragraph_14_regular.copyWith(
                      color: AppColors.Black,
                    ),
                  ),
                  // Add more chips as needed
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Workout List Section
            _homepageWidget.WorkoutListCard(
              title: 'Full Body Warm Up',
              subtitle: '20 Exercises',
              duration: '22 Min',
              imagePath:
                  'https://th.bing.com/th/id/OIP.TQd73ag_0yxBBczYB7RFwgHaE8?w=292&h=195&c=7&r=0&o=5&dpr=1.3&pid=1.7',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _homepageWidget.WorkoutListCard(
              title: 'Strength Exercise',
              subtitle: '12 Exercises',
              duration: '14 Min',
              imagePath:
                  'https://th.bing.com/th/id/OIP.TQd73ag_0yxBBczYB7RFwgHaE8?w=292&h=195&c=7&r=0&o=5&dpr=1.3&pid=1.7',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _homepageWidget.WorkoutListCard(
              title: 'Both Side Plank',
              subtitle: '15 Exercises',
              duration: '18 Min',
              imagePath:
                  'https://th.bing.com/th/id/OIP.TQd73ag_0yxBBczYB7RFwgHaE8?w=292&h=195&c=7&r=0&o=5&dpr=1.3&pid=1.7',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}