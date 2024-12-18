import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isDarkMode(context)
                ? Colors.grey.shade900
                : Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).indicatorColor,
        dividerColor: Colors.transparent,
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
            child: Icon(Icons.grid_4x4_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
            child: FaIcon(FontAwesomeIcons.heart),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => Sizes.size44;

  @override
  double get minExtent => Sizes.size44;
}
