import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:fitdiva/features/presentation/view/Homepage_Widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final List<DateTime> _markedDates = [
    DateTime(2025, 4, 2),
    DateTime(2025, 4, 14),
    DateTime(2025, 4, 17),
    DateTime(2025, 4, 28),
  ];

  @override
  Widget build(BuildContext context) {
    final homepageWidget = HomepageWidget();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: AppColors.Primary,
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
            // Calendar Section
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColors.Primary.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColors.Primary,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: AppColors.Primary,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 10,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (_markedDates
                      .any((markedDate) => isSameDay(markedDate, date))) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.Primary,
                        shape: BoxShape.circle,
                      ),
                    );
                  }
                  return null;
                },
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: AppTextStyles.heading_3_bold,
              ),
            ),
            const SizedBox(height: 16),

            // Added Activity Section
            Text(
              'Added Activity',
              style: AppTextStyles.heading_3_bold,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  homepageWidget.WorkoutListCard(
                    title: 'Full Body Warm Up',
                    subtitle: '20 Exercises',
                    duration: '22 Min',
                    imagePath: 'https://th.bing.com/th/id/OIP.TQd73ag_0yxBBczYB7RFwgHaE8?w=292&h=195&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  homepageWidget.WorkoutListCard(
                    title: 'Strength Exercise',
                    subtitle: '12 Exercises',
                    duration: '14 Min',
                    imagePath: 'https://th.bing.com/th/id/OIP.TQd73ag_0yxBBczYB7RFwgHaE8?w=292&h=195&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  homepageWidget.WorkoutListCard(
                    title: 'Both Side Plank',
                    subtitle: '15 Exercises',
                    duration: '18 Min',
                    imagePath: 'https://th.bing.com/th/id/OIP.TQd73ag_0yxBBczYB7RFwgHaE8?w=292&h=195&c=7&r=0&o=5&dpr=1.3&pid=1.7',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
