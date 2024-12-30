import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/settings/toggle_dark_mode.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_timeline_screen.dart';
import 'package:tiktok_clone/utils.dart';

var tabIdx = {
  'home': 0,
  'discover': 1,
  'camera': 2,
  'inbox': 3,
  'profile': 4,
};

class MainNavigationScreen extends StatefulWidget {
  static const routeName = 'mainNavigation';
  final String profileUserName;
  final String profileTab;
  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
    this.profileUserName = '@FIFA',
    this.profileTab = 'posts',
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = tabIdx[widget.tab]!;
  }

  void _onNavTap(int idx) {
    context.go("/${tabIdx.keys.elementAt(idx)}");
    setState(() {
      _selectedIndex = idx;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeModeFlag,
      builder: (context, themeModeFlag, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: _selectedIndex == 0 || themeModeFlag == true
              ? Colors.black
              : Colors.white,
          body: Stack(
            children: [
              Offstage(
                offstage: _selectedIndex != tabIdx['home'],
                child: const VideoTimelineScreen(),
              ),
              Offstage(
                offstage: _selectedIndex != tabIdx['discover'],
                child: const DiscoverScreen(),
              ),
              Offstage(
                offstage: _selectedIndex != tabIdx['inbox'],
                child: const InboxScreen(),
              ),
              Offstage(
                offstage: _selectedIndex != tabIdx['profile'],
                child: UserProfileScreen(
                    username: widget.profileUserName, tab: widget.profileTab),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            height: 60,
            padding: const EdgeInsets.symmetric(
                vertical: Sizes.size7, horizontal: Sizes.size2),
            color: _selectedIndex == 0 || isDarkMode(context)
                ? Colors.black
                : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavTab(
                  bgColor: _selectedIndex == 0 || isDarkMode(context)
                      ? Colors.black
                      : Colors.white,
                  icon: FontAwesomeIcons.house,
                  color: _selectedIndex == 0 || isDarkMode(context)
                      ? Colors.white
                      : Colors.black,
                  text: 'Home',
                  isSelected: _selectedIndex == tabIdx['home'],
                  selectedIcon: FontAwesomeIcons.house,
                  onTap: () => _onNavTap(tabIdx['home']!),
                ),
                NavTab(
                  bgColor: _selectedIndex == 0 || isDarkMode(context)
                      ? Colors.black
                      : Colors.white,
                  icon: FontAwesomeIcons.compass,
                  color: _selectedIndex == 0 || isDarkMode(context)
                      ? Colors.white
                      : Colors.black,
                  text: 'Discover',
                  isSelected: _selectedIndex == tabIdx['discover'],
                  selectedIcon: FontAwesomeIcons.solidCompass,
                  onTap: () => _onNavTap(tabIdx['discover']!),
                ),
                Gaps.h20,
                GestureDetector(
                  onTap: _onPostVideoButtonTap,
                  child: PostVideoButton(
                    inverted: (_selectedIndex != 0),
                  ),
                ),
                Gaps.h20,
                NavTab(
                  bgColor: _selectedIndex == 0 || isDarkMode(context)
                      ? Colors.black
                      : Colors.white,
                  icon: FontAwesomeIcons.message,
                  color: _selectedIndex == 0 || isDarkMode(context)
                      ? Colors.white
                      : Colors.black,
                  text: 'Inbox',
                  isSelected: _selectedIndex == tabIdx['inbox'],
                  selectedIcon: FontAwesomeIcons.solidMessage,
                  onTap: () => _onNavTap(tabIdx['inbox']!),
                ),
                NavTab(
                  bgColor: _selectedIndex == 0 || isDarkMode(context)
                      ? Colors.black
                      : Colors.white,
                  icon: FontAwesomeIcons.user,
                  color: _selectedIndex == 0 || isDarkMode(context)
                      ? Colors.white
                      : Colors.black,
                  text: 'Profile',
                  isSelected: _selectedIndex == tabIdx['profile'],
                  selectedIcon: FontAwesomeIcons.solidUser,
                  onTap: () => _onNavTap(tabIdx['profile']!),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
