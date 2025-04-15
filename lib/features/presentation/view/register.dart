import 'package:flutter/material.dart';
import '../style/color.dart';
import '../style/typography.dart';

class RegisterScreen extends StatelessWidget {
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
              const SizedBox(height: 40),
              Text(
                'FitDiva',
                style: AppTextStyles.LOGO.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 40),
              Text(
                'Create an account',
                style: AppTextStyles.heading_2_bold.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email to sign up for this app',
                style: AppTextStyles.paragraph_14_regular.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Your Password',
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Primary_dark,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: AppTextStyles.paragraph_18_bold.copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/google_icon.png', height: 24),
                label: Text(
                  'Sign in with Google',
                  style: AppTextStyles.paragraph_14_bold.copyWith(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Primary_dark,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/apple_icon.png', height: 24),
                label: Text(
                  'Sign in with Apple',
                  style: AppTextStyles.paragraph_14_bold.copyWith(color: AppColors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Black,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'By clicking continue, you agree to our Terms of Service\nand Privacy Policy',
                style: AppTextStyles.paragraph_10_regular.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
