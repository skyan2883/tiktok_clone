import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

var tabIdx = {
  'home': 0,
  'discover': 1,
  'inbox': 3,
  'profile': 4,
};

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 4;

  void _onNavTap(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Record Video'),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
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
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.symmetric(
            vertical: Sizes.size7, horizontal: Sizes.size2),
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavTab(
              bgColor: _selectedIndex == 0 ? Colors.black : Colors.white,
              icon: FontAwesomeIcons.house,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
              text: 'Home',
              isSelected: _selectedIndex == tabIdx['home'],
              selectedIcon: FontAwesomeIcons.house,
              onTap: () => _onNavTap(tabIdx['home']!),
            ),
            NavTab(
              bgColor: _selectedIndex == 0 ? Colors.black : Colors.white,
              icon: FontAwesomeIcons.compass,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
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
              bgColor: _selectedIndex == 0 ? Colors.black : Colors.white,
              icon: FontAwesomeIcons.message,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
              text: 'Inbox',
              isSelected: _selectedIndex == tabIdx['inbox'],
              selectedIcon: FontAwesomeIcons.solidMessage,
              onTap: () => _onNavTap(tabIdx['inbox']!),
            ),
            NavTab(
              bgColor: _selectedIndex == 0 ? Colors.black : Colors.white,
              icon: FontAwesomeIcons.user,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
              text: 'Profile',
              isSelected: _selectedIndex == tabIdx['profile'],
              selectedIcon: FontAwesomeIcons.solidUser,
              onTap: () => _onNavTap(tabIdx['profile']!),
            ),
          ],
        ),
      ),
    );
  }
}
