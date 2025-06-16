import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitdiva/features/presentation/style/color.dart';
import 'package:fitdiva/features/presentation/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitdiva/features/presentation/provider/auth_provider.dart';
// Tambahkan import halaman baru
import 'edit_profile_screen.dart';
import 'notification_screen.dart';
import 'security_screen.dart';
import 'help_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? email;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.authService.getCurrentUser();
    email = user?.email ?? 'Unknown Email';
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        username = doc.data()?['username'] ?? 'Unknown User';
        loading = false;
      });
    } else {
      setState(() {
        username = 'Unknown User';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile',
            style:
                AppTextStyles.heading_2_bold.copyWith(color: AppColors.Black)),
        iconTheme: IconThemeData(color: AppColors.Black),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.Black),
            onPressed: () {},
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: AppColors.Primary))
          : Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.grey,
                        child: Icon(Icons.person,
                            size: 48, color: AppColors.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.Primary,
                          child: Icon(Icons.edit,
                              color: AppColors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  username ?? '',
                  style: AppTextStyles.heading_2_bold
                      .copyWith(color: AppColors.Black),
                ),
                const SizedBox(height: 4),
                Text(
                  email ?? '',
                  style: AppTextStyles.paragraph_14_regular
                      .copyWith(color: AppColors.grey),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading:
                            Icon(Icons.person_outline, color: AppColors.Black),
                        title: Text('Edit Profile'),
                        onTap: () async {
                          // Edit Profile
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditProfileScreen()));
                          // Fetch ulang data setelah kembali
                          _fetchUserData();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications_none,
                            color: AppColors.Black),
                        title: Text('Notifications'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => NotificationScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.security_outlined,
                            color: AppColors.Black),
                        title: Text('Security'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SecurityScreen()));
                        },
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.help_outline, color: AppColors.Black),
                        title: Text('Help'),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HelpScreen()));
                        },
                      ),
                      _DarkThemeSwitch(),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title:
                            Text('Logout', style: TextStyle(color: Colors.red)),
                        onTap: () {
                          _showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.Primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                Divider(),
                const SizedBox(height: 16),
                Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(
                    color: AppColors.Black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      await authProvider.logout(context);
                    },
                    child: Text(
                      'Yes, Logout',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grey.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: AppColors.Primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DarkThemeSwitch extends StatefulWidget {
  @override
  State<_DarkThemeSwitch> createState() => _DarkThemeSwitchState();
}

class _DarkThemeSwitchState extends State<_DarkThemeSwitch> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(Icons.dark_mode_outlined, color: AppColors.Black),
      title: Text('Dark Theme'),
      value: isDark,
      onChanged: (val) {
        setState(() => isDark = val);
        // Implementasi dark mode jika ada
      },
      activeColor: AppColors.Primary,
    );
  }
}
