// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class NavTab extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final Color color;
  final String text;
  final bool isSelected;

  final Function onTap;

  const NavTab({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.color,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: Colors.black,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: color,
                  size: 22,
                ),
                Gaps.v1,
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontSize: Sizes.size12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
