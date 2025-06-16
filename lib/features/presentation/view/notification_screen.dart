import 'package:flutter/material.dart';
import '../style/color.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool general = true;
  bool sound = false;
  bool vibrate = false;
  bool appUpdates = true;
  bool newService = false;
  bool newTips = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification',
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
            title: Text('General Notification'),
            value: general,
            onChanged: (val) => setState(() => general = val),
            activeColor: AppColors.Primary,
          ),
          SwitchListTile(
            title: Text('Sound'),
            value: sound,
            onChanged: (val) => setState(() => sound = val),
            activeColor: AppColors.Primary,
          ),
          SwitchListTile(
            title: Text('Vibrate'),
            value: vibrate,
            onChanged: (val) => setState(() => vibrate = val),
            activeColor: AppColors.Primary,
          ),
          SwitchListTile(
            title: Text('App Updates'),
            value: appUpdates,
            onChanged: (val) => setState(() => appUpdates = val),
            activeColor: AppColors.Primary,
          ),
          SwitchListTile(
            title: Text('New Service Available'),
            value: newService,
            onChanged: (val) => setState(() => newService = val),
            activeColor: AppColors.Primary,
          ),
          SwitchListTile(
            title: Text('New tips available'),
            value: newTips,
            onChanged: (val) => setState(() => newTips = val),
            activeColor: AppColors.Primary,
          ),
        ],
      ),
    );
  }
}
