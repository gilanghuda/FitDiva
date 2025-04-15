import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  double _workoutsPerWeek = 5;
  double _workoutDuration = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity', style: AppTextStyles.heading_2_bold ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 64),
            // Bar Chart Section
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 90,
                          color: AppColors.Primary,
                          width: 24,
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 85,
                          color: AppColors.secondary,
                          width: 24,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 80,
                          color: AppColors.secondary,
                          width: 24,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 75,
                          color: AppColors.Primary,
                          width: 24,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                          toY: 70,
                          color: AppColors.secondary,
                          width: 24,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(
                          toY: 65,
                          color: AppColors.secondary,
                          width: 24,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(
                          toY: 60,
                          color: AppColors.Primary,
                          width: 24,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 7,
                      barRods: [
                        BarChartRodData(
                          toY: 55,
                          color: AppColors.secondary,
                          width: 24,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 8,
                      barRods: [
                        BarChartRodData(
                          toY: 50,
                          color: AppColors.secondary,
                          width: 24,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 9,
                      barRods: [
                        BarChartRodData(
                          toY: 45,
                          color: AppColors.Primary,
                          width: 24,
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Today');
                            case 1:
                              return const Text('');
                            case 2:
                              return const Text('');
                            case 3:
                              return const Text('Week 3');
                            case 4:
                              return const Text('');
                            case 5:
                              return const Text('');
                            case 6:
                              return const Text('Week 5');
                            case 7:
                              return const Text('');
                            case 8:
                              return const Text('');
                            case 9:
                              return const Text('Week 7');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        if (group.x == 0 || group.x == 9) {
                          return BarTooltipItem(
                            '${rod.toY.toInt()}',
                            AppTextStyles.paragraph_14_bold.copyWith(
                              color: AppColors.white,
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Workouts and Duration Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Workouts',
                          style: AppTextStyles.heading_3_bold,
                        ),
                        Text(
                          '${_workoutsPerWeek.toInt()} / Week',
                          style: AppTextStyles.heading_3_bold.copyWith(
                            color: AppColors.Primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Duration',
                          style: AppTextStyles.heading_3_bold,
                        ),
                        Text(
                          '${_workoutDuration.toInt()} Min',
                          style: AppTextStyles.heading_3_bold.copyWith(
                            color: AppColors.Primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Workouts Per Week Slider
            Text(
              'Workouts per Week',
              style: AppTextStyles.heading_3_bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => Text(
                  '${index + 2}',
                  style: AppTextStyles.paragraph_14_bold.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            Slider(
              value: _workoutsPerWeek,
              min: 2,
              max: 7,
              divisions: 5,
              activeColor: AppColors.Primary,
              inactiveColor: AppColors.grey,
              onChanged: (value) {
                setState(() {
                  _workoutsPerWeek = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Workout Duration Slider
            Text(
              'Workout Duration (Mins)',
              style: AppTextStyles.heading_3_bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => Text(
                  '${10 + index * 5}',
                  style: AppTextStyles.paragraph_14_bold.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            Slider(
              value: _workoutDuration,
              min: 10,
              max: 30,
              divisions: 4,
              activeColor: AppColors.Primary,
              inactiveColor: AppColors.grey,
              onChanged: (value) {
                setState(() {
                  _workoutDuration = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
