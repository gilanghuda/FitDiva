import 'package:fitdiva/features/presentation/router/approutes.dart';
import 'package:flutter/material.dart';
import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';

class ExerciseScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final int duration; // Duration in minutes

  const ExerciseScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.duration,
  }) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late int _remainingSeconds;
  Timer? _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _timer?.cancel();
            _showCompletionBottomSheet();
          }
        });
      }
    });
  }

  void _restartTimer() {
    setState(() {
      _remainingSeconds = widget.duration * 60;
      _isPaused = false;
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _showCompletionBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.Black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.thumb_up, size: 70, color: AppColors.Primary),
              const SizedBox(height: 66),
              Text(
                'Great job! Workout completed',
                style: AppTextStyles.heading_3_bold.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '${widget.duration}',
                        style: AppTextStyles.heading_3_bold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Total Exercises',
                        style: AppTextStyles.paragraph_14_regular.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '233',
                        style: AppTextStyles.heading_3_bold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Calories Burnt',
                        style: AppTextStyles.paragraph_14_regular.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.Primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 102.0, // Increase button size
                  ),
                ),
                onPressed: () {
                  GoRouter.of(context).go(AppRoutes.navbar);
                },
                child: Text(
                  'Next Challenge',
                  style: AppTextStyles.paragraph_14_bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: AppTextStyles.heading_3_bold.copyWith(color: AppColors.Black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: AppColors.grey,
            backgroundImage: NetworkImage(widget.imageUrl),
          ),
          const SizedBox(height: 24),
          Text(
            '$minutes:$seconds',
            style:
                AppTextStyles.heading_1_bold.copyWith(color: AppColors.Black),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  side: BorderSide(color: AppColors.Primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  _restartTimer();
                },
                child: Text(
                  'Restart',
                  style: AppTextStyles.paragraph_14_bold.copyWith(
                    color: AppColors.Primary,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isPaused ? AppColors.Primary : AppColors.white,
                  side: BorderSide(color: AppColors.Primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  _togglePause();
                },
                child: Text(
                  _isPaused ? 'Resume' : 'Pause',
                  style: AppTextStyles.paragraph_14_bold.copyWith(
                    color: _isPaused ? AppColors.white : AppColors.Primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _timer?.cancel();
              _showCompletionBottomSheet();
            },
            child: Text(
              'Skip',
              style: AppTextStyles.paragraph_14_bold.copyWith(
                color: AppColors.Primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
