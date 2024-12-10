import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final Duration duration = const Duration(milliseconds: 300);

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<int> items = [];

  void addItem() {
    if (listKey.currentState != null) {
      listKey.currentState!.insertItem(
        items.length,
        duration: duration,
      );
      items.add(items.length);
    }
  }

  void onChatTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatDetailScreen(),
      ),
    );
  }

  void deleteItem(int index) {
    if (listKey.currentState != null) {
      listKey.currentState!.removeItem(
        index,
        duration: duration,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: makeTile(index),
        ),
      );
      items.removeAt(index);
      items = List.generate(items.length, (index) => index);
    }
  }

  Widget makeTile(int index) {
    return ListTile(
      onLongPress: () => deleteItem(index),
      onTap: onChatTap,
      leading: CircleAvatar(
        radius: Sizes.size24,
        backgroundColor: Colors.grey.shade200,
        foregroundImage: const NetworkImage(
            'https://avatars.githubusercontent.com/u/1542805?v=4'),
        child: const FaIcon(FontAwesomeIcons.user, size: Sizes.size24),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lynn ($index)',
            style: const TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '2:16 PM',
            style: TextStyle(
              fontSize: Sizes.size12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
      subtitle: Text(
        'Hey how are you?',
        style: TextStyle(
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey.shade800,
        scrolledUnderElevation: 0,
        title: const Text('Direct messages'),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const FaIcon(FontAwesomeIcons.plus, size: Sizes.size24),
          ),
        ],
      ),
      body: AnimatedList(
          key: listKey,
          padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              key: UniqueKey(),
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: makeTile(index),
              ),
            );
          }),
    );
  }
}
