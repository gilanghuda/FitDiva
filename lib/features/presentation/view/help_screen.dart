import 'package:flutter/material.dart';
import '../style/color.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help',
            style:
                TextStyle(color: AppColors.Black, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.Black),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Frequently Asked Questions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),
            ExpansionTile(
              title: Text('How to edit my profile?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Go to Profile > Edit Profile and update your information.'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('How to change my password?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Go to Security and follow the instructions to change your password.'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('How to contact support?'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'You can contact us via email at support@fitdiva.com.'),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Still need help?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.Primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Contact Support'),
                    content: Text(
                        'Email: support@fitdiva.com\nWe will get back to you soon!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }
}
