import 'package:flutter/material.dart';
import '../style/color.dart';
import 'forgot_password_screen.dart';

class SecurityScreen extends StatefulWidget {
  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool faceId = false;
  bool rememberMe = false;
  bool biometric = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security',
            style:
                TextStyle(color: AppColors.Black, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.Black),
      ),
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Face ID'),
            value: faceId,
            onChanged: (val) => setState(() => faceId = val),
            activeColor: AppColors.Primary,
          ),
          SwitchListTile(
            title: Text('Remember Me'),
            value: rememberMe,
            onChanged: (val) => setState(() => rememberMe = val),
            activeColor: AppColors.Primary,
          ),
          SwitchListTile(
            title: Text('Biometric ID'),
            value: biometric,
            onChanged: (val) => setState(() => biometric = val),
            activeColor: AppColors.Primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ForgotPasswordScreen()));
                },
                child: Text('Change Password'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
