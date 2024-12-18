import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/utils.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late Direction _direction;
  Page _showIngPage = Page.first;
  bool _showButton = false;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // to the right
      setState(() {
        _direction = Direction.right;
      });
    } else {
      // to the left
      _direction = Direction.left;
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showIngPage = Page.second;
        _showButton = true;
      });
    } else {
      setState(() {
        _showIngPage = Page.first;
        _showButton = false;
      });
    }
  }

  void _onEnterTap() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const MainNavigationScreen(initialTab: 0)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: const Page1(),
              secondChild: const Page2(),
              crossFadeState: _showIngPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: isDarkMode(context) ? Colors.black : Colors.white,
          height: 110,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size12,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              opacity: _showButton ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                onPressed: _onEnterTap,
                child: const Text(
                  'Enter the app!',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v72,
        const Text(
          'Watch cool videos!',
          style: TextStyle(
            fontSize: Sizes.size28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v14,
        Text(
          'Videos are personalized for you based on what you watch, like , and share.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v72,
        const Text(
          'Follow the rules',
          style: TextStyle(
            fontSize: Sizes.size28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v14,
        Text(
          'Take care of one another! Pils!',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
