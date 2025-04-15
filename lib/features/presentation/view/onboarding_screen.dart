import 'package:fitdiva/features/presentation/router/approutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; 
import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Your Ultimate Personal Trainer",
      "description":
          "Helps track fitness, wellness, and mental health with workouts, nutrition tips, and well-being support."
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Discover The Right Workout",
      "description":
          "With personalized recommendations, guided videos, and progress tracking, find your ideal start and achieve the best results."
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Elevate Your Practice",
      "description":
          "Helps track fitness, wellness, and mental health with workouts, nutrition tips, and mental well-being support."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_onboardingData[index]["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: screenHeight / 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent, // Transparent at the top
                          AppColors.Primary.withOpacity(0.1), // Gradual transition to primary color
                          AppColors.Primary, // Solid primary color at the bottom
                        ],
                        begin: Alignment.center, // Start from the vertical center
                        end: Alignment.bottomCenter, // End at the bottom of the screen
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight / 2 - 260), // Adjusted to move dots higher
                      SizedBox(height: 20), // Space between dots and title
                      Text(
                        _onboardingData[index]["title"]!,
                        style: AppTextStyles.heading_1_bold.copyWith(color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          _onboardingData[index]["description"]!,
                          style: AppTextStyles.paragraph_18_regular.copyWith(color: AppColors.white.withOpacity(0.7)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: screenHeight / 2 - 40, // Adjust position as needed
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  width: _currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? AppColors.white : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go(AppRoutes.register);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 50), // Increased width
                    ),
                    child: Text(
                      "Start Exercise",
                      style: AppTextStyles.paragraph_18_bold.copyWith(color: AppColors.Primary),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have account? ",
                      style: AppTextStyles.paragraph_14_regular.copyWith(color: AppColors.white.withOpacity(0.7)),
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: AppTextStyles.paragraph_14_regular.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.Primary,
    );
  }
}
