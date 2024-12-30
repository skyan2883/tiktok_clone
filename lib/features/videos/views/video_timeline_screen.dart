import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;
  final PageController _pageController = PageController();

  void _onPageChanged(int page) {
    _pageController.animateToPage(page,
        duration: _scrollDuration, curve: _scrollCurve);
    if (page == _itemCount - 1) {
      _itemCount += 4;
    }
    setState(() {});
  }

  List<Color> colors = [Colors.blue, Colors.red, Colors.teal, Colors.yellow];

  void _onVideoFinished() {
    return;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      edgeOffset: 20,
      onRefresh: _onRefresh,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        itemBuilder: (context, index) =>
            VideoPost(onVideoFinished: _onVideoFinished, index: index),
      ),
    );
  }
}
