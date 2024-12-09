import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
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
  int _selectedIndex = 0;

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
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != tabIdx['home'],
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != tabIdx['discover'],
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != tabIdx['inbox'],
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != tabIdx['profile'],
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.symmetric(
            vertical: Sizes.size7, horizontal: Sizes.size2),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavTab(
              icon: FontAwesomeIcons.house,
              color: Colors.white,
              text: 'Home',
              isSelected: _selectedIndex == tabIdx['home'],
              selectedIcon: FontAwesomeIcons.house,
              onTap: () => _onNavTap(tabIdx['home']!),
            ),
            NavTab(
              icon: FontAwesomeIcons.compass,
              color: Colors.white,
              text: 'Discover',
              isSelected: _selectedIndex == tabIdx['discover'],
              selectedIcon: FontAwesomeIcons.solidCompass,
              onTap: () => _onNavTap(tabIdx['discover']!),
            ),
            Gaps.h20,
            GestureDetector(
              onTap: _onPostVideoButtonTap,
              child: const PostVideoButton(),
            ),
            Gaps.h20,
            NavTab(
              icon: FontAwesomeIcons.message,
              color: Colors.white,
              text: 'Inbox',
              isSelected: _selectedIndex == tabIdx['inbox'],
              selectedIcon: FontAwesomeIcons.solidMessage,
              onTap: () => _onNavTap(tabIdx['inbox']!),
            ),
            NavTab(
              icon: FontAwesomeIcons.user,
              color: Colors.white,
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
