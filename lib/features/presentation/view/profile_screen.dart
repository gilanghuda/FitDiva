import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitdiva/features/presentation/provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final username = authProvider.userDisplayName ?? 'Unknown User';
    final email = authProvider.authService.getCurrentUser()?.email ?? 'Unknown Email';

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
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
                    username,
                    style: AppTextStyles.heading_2_bold.copyWith(
                      color: AppColors.Black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
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
            _buildListTile('Training Days', Icons.calendar_today, context),
            _buildListTile('Trouble Zone', Icons.warning, context),
            _buildListTile('Training Days', Icons.fitness_center, context),
            _buildListTile('Fitness Level', Icons.bar_chart, context),
            const SizedBox(height: 16),

            // Workout Section
            _buildSectionTitle('Workout'),
            _buildListTile('Reminder', Icons.alarm, context),
            _buildListTile('Sound Options', Icons.volume_up, context),
            _buildListTile('Restart Progress', Icons.refresh, context),
            const SizedBox(height: 16),

            // General Settings Section
            _buildSectionTitle('General Settings'),
            _buildListTile('Logout', Icons.logout, context),
            _buildListTile('Metric & Imperial Units', Icons.straighten, context),
            _buildListTile('Language Options', Icons.language, context),
            _buildListTile('Delete All Data', Icons.delete, context),
            const SizedBox(height: 16),

            // Support Us Section
            _buildSectionTitle('Support Us'),
            _buildListTile('Share Us', Icons.share, context),
            _buildListTile('Rate Us', Icons.star, context),
            _buildListTile('Feedback', Icons.feedback, context),
            _buildListTile('Privacy Policy', Icons.privacy_tip, context),
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

  Widget _buildListTile(String title, IconData icon, BuildContext context) {
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
      onTap: () {
        if (title == 'Logout') {
          _showLogoutDialog(context);
        }
      },
    );
  }


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                await authProvider.logout(context); // Call logout from AuthProvider
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
