import 'package:flutter/material.dart';
import 'package:fitdiva/features/presentation/view/Homepage_Screen.dart';
import 'package:fitdiva/features/presentation/view/activity_screen.dart';
import 'package:fitdiva/features/presentation/view/calendar_screen.dart';
import 'package:fitdiva/features/presentation/view/profile_screen.dart';
import 'package:fitdiva/features/presentation/style/color.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  _NavbarScreenState createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomepageScreen(),
          ActivityScreen(),
          CalendarScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.Primary,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.white,
          unselectedItemColor: Colors.blueGrey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Activity'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
