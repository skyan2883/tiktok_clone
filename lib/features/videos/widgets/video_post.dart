import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:tiktok_clone/features/videos/widgets/volume_slider.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  bool _savedPlaybackState = false;
  bool _isPaused = false;
  bool _isMore = false;
  bool _isMuted = false;
  double _volume = 0.5;
  double _savedVolume = 0.5;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {}
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;

    _isPaused = _savedPlaybackState;

    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
      _savedPlaybackState = false;
    }
    if (info.visibleFraction == 0 && _videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _savedPlaybackState = true;
      if (mounted) {
        setState(() {
          _isPaused = true;
        });
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/video${widget.index + 1}.mp4');
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      _onVolumeTap();
      _isMuted = true;
    }
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();

    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0, // 기본으로 시작
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onMoreTap() {
    _isMore = !_isMore;
    setState(() {});
  }

  void _onCommentsTap() async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const VideoComments(),
      backgroundColor: Colors.transparent,
    );
    _onTogglePause();
  }

  void _onVolumeTap() {
    _isMuted = !_isMuted;
    if (_isMuted) {
      _savedVolume = _volume;
      _volume = 0;
      _videoPlayerController.setVolume(0);
    } else {
      _volume = _savedVolume;
      _videoPlayerController.setVolume(_savedVolume);
    }
    setState(() {});
  }

  void _onVolumeChanged(double value) {
    setState(() {
      _isMuted = false;
      _volume = value;
      _videoPlayerController.setVolume(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 15,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _onVolumeTap,
                  child: AnimatedContainer(
                    duration: _animationDuration,
                    child: FaIcon(
                      _isMuted
                          ? FontAwesomeIcons.volumeXmark
                          : FontAwesomeIcons.volumeHigh,
                      color: Colors.white,
                      size: Sizes.size36,
                    ),
                  ),
                ),
                Gaps.v16,
                VolumeSlider(
                    volume: _volume, onVolumeChanged: _onVolumeChanged),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v10,
                const Text(
                  'This is my first Video!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w400),
                ),
                Gaps.v3,
                Row(children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      overflow: _isMore
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      '#QWER #아이돌 1111111111112222222222333333333344444444444\na\ns\nd\n dddd',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Gaps.h3,
                  GestureDetector(
                    onTap: _onMoreTap,
                    child: SizedBox(
                      child: _isMore
                          ? null
                          : const Text(
                              'See more',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size14,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ]),
                Gaps.v8,
                const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.music,
                      color: Colors.white,
                      size: Sizes.size16,
                    ),
                    Gaps.h8,
                    Text(
                      '내일은 맑음 - QWER',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_isMore)
            Positioned(
              right: 100,
              bottom: 10,
              child: GestureDetector(
                onTap: _onMoreTap,
                child: const SizedBox(
                  child: Text(
                    'hide',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 10,
            right: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _onVolumeTap,
                  child: SizedBox(
                    child: FaIcon(
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                      size: Sizes.size36,
                    ),
                  ),
                ),
                Gaps.v16,
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/pictures/pic1.png'),
                ),
                Gaps.v16,
                VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    text: S.of(context).likeCount(2900000)),
                Gaps.v16,
                GestureDetector(
                    onTap: _onCommentsTap,
                    child: VideoButton(
                        icon: FontAwesomeIcons.solidComment,
                        text: S.of(context).commentCount(33000))),
                Gaps.v16,
                const VideoButton(icon: FontAwesomeIcons.share, text: 'Share'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
