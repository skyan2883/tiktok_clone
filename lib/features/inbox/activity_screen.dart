import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});
  static const routeName = 'activity';
  static const routeURL = '/activity';

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];

  late final AnimationController _animationController;

  late final Animation<double> _arrowAnimation;
  late final Animation<Offset> _panelAnimation;
  late final Animation<Color?> _barrierAnimation;

  bool _showBarrier = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _arrowAnimation = Tween(begin: 0.0, end: 0.5).animate(_animationController);
    _panelAnimation = Tween(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(_animationController);
    _barrierAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.black38,
    ).animate(_animationController);
  }

  void _onDismissed(DismissDirection direction, String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_notifications);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('All Activity'),
              Gaps.h10,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Gaps.v10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
                child: Text(
                  'New',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Gaps.v10,
              for (var notification in _notifications)
                Dismissible(
                  key: Key(notification),
                  onDismissed: (direction) =>
                      _onDismissed(direction, notification),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const Padding(
                      padding: EdgeInsets.only(left: Sizes.size10),
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(right: Sizes.size10),
                      child: FaIcon(
                        FontAwesomeIcons.trash,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode(context)
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: isDarkMode(context)
                            ? Colors.grey.shade800
                            : Colors.white,
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color:
                              isDarkMode(context) ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Account updates',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode(context) ? null : Colors.black,
                              fontSize: Sizes.size16,
                            ),
                            children: [
                              TextSpan(
                                text: ': Upload longer videos',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: isDarkMode(context)
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' $notification',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size16,
                    ),
                  ),
                ),
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: () => _toggleAnimations(),
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size5),
                  bottomRight: Radius.circular(Sizes.size5),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            tab["icon"],
                            size: Sizes.size20,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ],
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
