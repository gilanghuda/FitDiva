import 'package:fitdiva/features/presentation/view/register.dart';
import 'package:flutter/material.dart';
import '../style/color.dart';
import '../style/typography.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'FitDiva',
                style: AppTextStyles.LOGO.copyWith(color: AppColors.white),
              ),
              SizedBox(height: 40),
              Text(
                'Create an account',
                style: AppTextStyles.heading_2_bold.copyWith(color: AppColors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Enter your email to sign up for this app',
                style: AppTextStyles.paragraph_14_regular.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  hintText: 'Your Email',
                  hintStyle: AppTextStyles.paragraph_14_regular.copyWith(color: AppColors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  hintText: 'Your Password',
                  hintStyle: AppTextStyles.paragraph_14_regular.copyWith(color: AppColors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Primary_dark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Continue',
                  style: AppTextStyles.paragraph_14_bold.copyWith(color: AppColors.white),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  "Don't have an account?",
                  style: AppTextStyles.paragraph_14_regular.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.white)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'or',
                      style: AppTextStyles.paragraph_14_regular.copyWith(color: AppColors.white),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.white)),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/google_icon.png', height: 20),
                label: Text(
                  'Sign in with Google',
                  style: AppTextStyles.paragraph_14_bold.copyWith(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/apple_icon.png', height: 20),
                label: Text(
                  'Sign in with Apple',
                  style: AppTextStyles.paragraph_14_bold.copyWith(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              Spacer(),
              Text(
                'By clicking continue, you agree to our Terms of Service\nand Privacy Policy',
                style: AppTextStyles.paragraph_10_regular.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
