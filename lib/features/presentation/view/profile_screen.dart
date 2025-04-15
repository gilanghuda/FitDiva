import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.Black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Info
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.grey,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Maritza Sa',
                    style: AppTextStyles.heading_2_bold.copyWith(
                      color: AppColors.Black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'maritza@gmail.com',
                    style: AppTextStyles.paragraph_14_regular.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About Section
            _buildSectionTitle('About'),
            _buildListTile('Training Days', Icons.calendar_today),
            _buildListTile('Trouble Zone', Icons.warning),
            _buildListTile('Training Days', Icons.fitness_center),
            _buildListTile('Fitness Level', Icons.bar_chart),
            const SizedBox(height: 16),

            // Workout Section
            _buildSectionTitle('Workout'),
            _buildListTile('Reminder', Icons.alarm),
            _buildListTile('Sound Options', Icons.volume_up),
            _buildListTile('Restart Progress', Icons.refresh),
            const SizedBox(height: 16),

            // General Settings Section
            _buildSectionTitle('General Settings'),
            _buildSwitchTile('Apple Health', true),
            _buildSwitchTile('Dark Mode', false),
            _buildListTile('Metric & Imperial Units', Icons.straighten),
            _buildListTile('Language Options', Icons.language),
            _buildListTile('Delete All Data', Icons.delete),
            const SizedBox(height: 16),

            // Support Us Section
            _buildSectionTitle('Support Us'),
            _buildListTile('Share Us', Icons.share),
            _buildListTile('Rate Us', Icons.star),
            _buildListTile('Feedback', Icons.feedback),
            _buildListTile('Privacy Policy', Icons.privacy_tip),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: AppTextStyles.heading_3_bold.copyWith(
          color: AppColors.Black,
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.Primary.withOpacity(0.2),
        child: Icon(icon, color: AppColors.Primary),
      ),
      title: Text(
        title,
        style: AppTextStyles.paragraph_14_medium.copyWith(
          color: AppColors.Black,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.grey),
      onTap: () {},
    );
  }

  Widget _buildSwitchTile(String title, bool value) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppTextStyles.paragraph_14_medium.copyWith(
          color: AppColors.Black,
        ),
      ),
      value: value,
      activeColor: AppColors.Primary,
      onChanged: (bool newValue) {},
    );
  }
}
