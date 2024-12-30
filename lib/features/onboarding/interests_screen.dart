import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/interest_button.dart';
import 'package:tiktok_clone/utils.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});
  static const routeName = 'interests';
  static const routeURL = '/tutorial';
  static const interests = [
    "Daily Life",
    "Comedy",
    "Entertainment",
    "Animals",
    "Food",
    "Beauty & Style",
    "Drama",
    "Learning",
    "Talent",
    "Sports",
    "Auto",
    "Family",
    "Fitness & Health",
    "DIY & Life Hacks",
    "Arts & Crafts",
    "Dance",
    "Outdoors",
    "Oddly Satisfying",
    "Home & Garden",
    "Daily Life",
    "Comedy",
    "Entertainment",
    "Animals",
    "Food",
    "Beauty & Style",
    "Drama",
    "Learning",
    "Talent",
    "Sports",
    "Auto",
    "Family",
    "Fitness & Health",
    "DIY & Life Hacks",
    "Arts & Crafts",
    "Dance",
    "Outdoors",
    "Oddly Satisfying",
    "Home & Garden",
  ];

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showTitle = false;

  void _onScroll() {
    if (_scrollController.offset > 44) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: AnimatedOpacity(
            opacity: _showTitle ? 1 : 0,
            duration: const Duration(
              milliseconds: 300,
            ),
            child: Container(
              height: 1.0,
            ),
          ),
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(
            milliseconds: 300,
          ),
          child: const Text(
            'Choose your interests',
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                Text(
                  'Choose your interests',
                  style: TextStyle(
                    color: isDarkMode(context) ? Colors.white : Colors.black,
                    fontSize: Sizes.size36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Gaps.v12,
                const Opacity(
                  opacity: 0.7,
                  child: Text(
                    'Get better video recommendations',
                    style: TextStyle(
                      fontSize: Sizes.size16 + Sizes.size2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Gaps.v64,
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    for (var interest in InterestsScreen.interests)
                      InterestButton(interest: interest),
                  ],
                ),
                Gaps.v10,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size32,
            top: Sizes.size4,
            left: Sizes.size20,
            right: Sizes.size20,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isDarkMode(context)
                        ? Colors.grey.shade800
                        : Colors.white,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode(context) ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Gaps.h10,
              Flexible(
                flex: 5,
                child: GestureDetector(
                  onTap: _onNextTap,
                  child: Container(
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
