import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  GlobalKey bottomAppBarKey = GlobalKey();
  double? bottomAppBarHeight = 76;

  void onUnfocus() {
    FocusScope.of(context).unfocus();
  }

  void onSubmitTap() {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final height = bottomAppBarKey.currentContext!.size!.height;
        bottomAppBarHeight = height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 30,
        title: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: Sizes.size1,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: Sizes.size14,
                    backgroundColor: Colors.grey.shade200,
                    foregroundImage: const NetworkImage(
                        'https://avatars.githubusercontent.com/u/1542805?v=4'),
                  ),
                ),
                Positioned(
                  width: Sizes.size20,
                  right: -6,
                  bottom: -6,
                  child: Container(
                    width: Sizes.size16,
                    height: Sizes.size16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: Sizes.size3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.h6,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'xxxxmmm967',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Active now',
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.flag,
              size: Sizes.size20,
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.ellipsis,
              size: Sizes.size20,
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).padding.bottom + bottomAppBarHeight!,
            child: GestureDetector(
              onTap: onUnfocus,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size14,
                  vertical: Sizes.size20,
                ),
                itemBuilder: (context, index) {
                  final isMine = index % 2 == 0;
                  return Row(
                    mainAxisAlignment: isMine
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size14,
                          vertical: Sizes.size14,
                        ),
                        decoration: BoxDecoration(
                          color: isMine
                              ? Colors.blue
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(Sizes.size16),
                            topRight: const Radius.circular(Sizes.size16),
                            bottomLeft: isMine
                                ? const Radius.circular(Sizes.size16)
                                : Radius.zero,
                            bottomRight: isMine
                                ? Radius.zero
                                : const Radius.circular(Sizes.size16),
                          ),
                        ),
                        child: Text(
                          'This is a message! ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 10,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              key: bottomAppBarKey,
              padding: const EdgeInsets.only(
                left: Sizes.size16,
                right: Sizes.size20,
                top: Sizes.size12,
                bottom: Sizes.size28,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: Sizes.size14,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: Sizes.size10,
                          right: Sizes.size10,
                          top: Sizes.size10,
                          bottom: Sizes.size10,
                        ),
                        hintText: 'Send a message',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Sizes.size16),
                            topRight: Radius.circular(Sizes.size16),
                            bottomLeft: Radius.circular(Sizes.size16),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(FontAwesomeIcons.faceSmile),
                            Gaps.h10,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  GestureDetector(
                    onTap: onSubmitTap,
                    child: Container(
                      child: const FaIcon(FontAwesomeIcons.paperPlane),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
