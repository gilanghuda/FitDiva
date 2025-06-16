import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:fitdiva/features/presentation/view/Homepage_Widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Tambahkan ini
import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan ini

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

  bool _showNoteOverlay = false;
  TextEditingController _noteController = TextEditingController();
  bool _loadingNote = false;

  String getCurrentTimeString() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 7));
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return "Today, $hour:$minute";
  }

  String _dateToDocId(DateTime date) {
    // yyyy-MM-dd
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String? get _currentUserId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> _openNoteOverlay(DateTime selectedDay) async {
    setState(() {
      _selectedDay = selectedDay;
      _showNoteOverlay = true;
      _loadingNote = true;
      _noteController.text = "";
    });
    final docId = _dateToDocId(selectedDay);
    if (_currentUserId == null) {
      setState(() {
        _loadingNote = false;
      });
      return;
    }
    final doc = await FirebaseFirestore.instance
        .collection('notes')
        .doc('${_currentUserId}_$docId')
        .get();
    if (doc.exists && doc.data() != null && doc.data()!['note'] != null) {
      _noteController.text = doc.data()!['note'];
    } else {
      _noteController.text = "";
    }
    setState(() {
      _loadingNote = false;
    });
  }

  void _closeNoteOverlay() {
    setState(() {
      _showNoteOverlay = false;
    });
  }

  Future<void> _saveNote() async {
    if (_selectedDay == null || _currentUserId == null) return;
    final docId = _dateToDocId(_selectedDay!);
    final noteText = _noteController.text.trim();
    if (noteText.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('notes')
          .doc('${_currentUserId}_$docId')
          .set({
        'note': noteText,
        'date': docId,
        'userId': _currentUserId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    _closeNoteOverlay();
  }

  Future<void> _deleteNote() async {
    if (_selectedDay == null || _currentUserId == null) return;
    final docId = _dateToDocId(_selectedDay!);
    await FirebaseFirestore.instance
        .collection('notes')
        .doc('${_currentUserId}_$docId')
        .delete();
    _noteController.clear();
    _closeNoteOverlay();
  }

  @override
  Widget build(BuildContext context) {
    final homepageWidget = HomepageWidget();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar', style: AppTextStyles.heading_2_bold),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
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
                    _openNoteOverlay(selectedDay);
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
                        imagePath: 'https://drive.google.com/uc?export=view&id=1TuOqsZdbBwMQ7VKhA9KzUm6gQ_Dheut1',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      homepageWidget.WorkoutListCard(
                        title: 'Strength Exercise',
                        subtitle: '12 Exercises',
                        duration: '14 Min',
                        imagePath: 'https://drive.google.com/uc?export=view&id=1lYQ6DrzjpAyqrS6pVOdD402rW-3T-vCQ',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      homepageWidget.WorkoutListCard(
                        title: 'Both Side Plank',
                        subtitle: '15 Exercises',
                        duration: '18 Min',
                        imagePath: 'https://drive.google.com/uc?export=view&id=1gOSj3qsfrZ1ne-T0myuCvdmcgs9OaoMO',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_showNoteOverlay)
            GestureDetector(
              onTap: _closeNoteOverlay,
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // Prevent tap propagation
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                      decoration: BoxDecoration(
                        color: const Color(0xFF232226),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: _loadingNote
                          ? const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.Primary),
                              ),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "< Notes",
                                  style: AppTextStyles.heading_4_bold.copyWith(
                                    color: AppColors.Primary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  getCurrentTimeString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _noteController,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                  maxLines: 6,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Tulis catatan di sini...",
                                    hintStyle: TextStyle(color: Colors.white54),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.check_circle_outline, color: AppColors.Primary, size: 32),
                                      onPressed: _saveNote,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline, color: AppColors.Primary, size: 28),
                                      onPressed: _deleteNote,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
