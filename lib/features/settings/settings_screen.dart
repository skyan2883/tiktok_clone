import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void onChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Enable notifications'),
            trailing: CupertinoSwitch(
              value: _notifications,
              onChanged: onChanged,
            ),
          ),
          CheckboxListTile(
            activeColor: Colors.black,
            title: const Text('Marketing emails'),
            value: _notifications,
            onChanged: onChanged,
          ),
          ListTile(
            title: const Text('About',
                style: TextStyle(
                    fontSize: Sizes.size16, fontWeight: FontWeight.w600)),
            subtitle: const Text('Version 1.0.0'),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: 'TikTok Clone',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2024 Ti kTok Clone',
            ),
          ),
          ListTile(
            title: const Text('Log out (IOS)'),
            trailing: const Icon(Icons.logout),
            textColor: Colors.red,
            onTap: () => showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Log out'),
                content: const Text('Are you sure you want to log out?'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Log out',
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Log out (IOS / Bottom )'),
            trailing: const Icon(Icons.logout),
            textColor: Colors.red,
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text('Log out'),
                actions: [
                  CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  ),
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Log out',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
