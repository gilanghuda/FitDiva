import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:flutter/material.dart';

class HomepageWidget {
  Widget WorkoutProgressCard({
    required String title,
    required String progress,
    required String timeRemaining,
  }) {
    return Card(
      color: AppColors.Black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80, // Adjust the width as needed
                  height: 80, // Adjust the height as needed
                  child: CircularProgressIndicator(
                    value: double.parse(progress.split('/')[0]) /
                        double.parse(progress.split('/')[1]),
                    color: AppColors.Primary,
                    backgroundColor: AppColors.grey,
                  ),
                ),
                Text(
                  progress,
                  style: AppTextStyles.heading_3_bold.copyWith(
                    color: AppColors.Primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.heading_3_medium.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeRemaining,
              style: AppTextStyles.paragraph_14_regular.copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget WorkoutListCard({
    required String title,
    required String subtitle,
    required String duration,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Card(
      color: AppColors.Black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(imagePath, width: 40, height: 40),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading_3_medium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$subtitle • $duration',
                      style: AppTextStyles.paragraph_14_regular.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: AppColors.Primary, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}