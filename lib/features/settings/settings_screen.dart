import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/settings/toggle_dark_mode.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: kIsWeb
                ? const BoxConstraints(maxWidth: 500)
                : BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Auto Mute'),
                  trailing: CupertinoSwitch(
                    value: ref.watch(playbackConfigProvider).autoMute,
                    onChanged: (value) {
                      ref.read(playbackConfigProvider.notifier).setMuted(value);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Auto Play'),
                  trailing: CupertinoSwitch(
                    value: ref.watch(playbackConfigProvider).autoPlay,
                    onChanged: (value) {
                      ref
                          .read(playbackConfigProvider.notifier)
                          .setAutoPlay(value);
                    },
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: themeModeFlag,
                  builder: (context, themeMode, child) => ListTile(
                    title: const Text('Toggle Dark Mode'),
                    trailing: CupertinoSwitch(
                      value: themeModeFlag.value,
                      onChanged: (value) {
                        themeModeFlag.value = !themeModeFlag.value;
                      },
                    ),
                  ),
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
                ListTile(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    );

                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    final booking = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                      builder: (context, child) => Theme(
                        data: ThemeData(
                          appBarTheme: const AppBarTheme(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white),
                        ),
                        child: child!,
                      ),
                    );
                  },
                  title: const Text('What is your birthday?'),
                  subtitle: const Text(
                      'We will use this to personalize your experience.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
