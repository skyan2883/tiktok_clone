import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.size14),
            topRight: Radius.circular(Sizes.size14)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: kIsWeb
              ? MediaQuery.of(context).size.width * 0.6
              : MediaQuery.of(context).size.width,
        ),
        child: Scaffold(
          backgroundColor: isDarkMode(context) ? null : Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: isDarkMode(context) ? null : Colors.grey.shade50,
            automaticallyImplyLeading: false,
            title: const Text('22796 comments'),
            actions: [
              IconButton(
                  onPressed: _onClosePressed,
                  icon: const FaIcon(FontAwesomeIcons.xmark))
            ],
          ),
          body: GestureDetector(
            onTap: _stopWriting,
            child: Stack(
              children: [
                Scrollbar(
                  controller: _scrollController,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      left: Sizes.size12,
                      right: Sizes.size12,
                      top: Sizes.size10,
                      bottom: Sizes.size96,
                    ),
                    separatorBuilder: (context, index) => Gaps.v20,
                    itemCount: 10,
                    itemBuilder: (context, index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: isDarkMode(context)
                                ? Colors.grey.shade700
                                : null,
                            child: Text('nico',
                                style: TextStyle(
                                    color: isDarkMode(context)
                                        ? Colors.white
                                        : null,
                                    fontSize: Sizes.size12)),
                          ),
                          Gaps.h6,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Marius Aquinas',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Sizes.size12,
                                      color: Colors.grey.shade500),
                                ),
                                Gaps.v3,
                                const Text(
                                    'I thought that was gtaVI thought that was gtaVI thought that was gtaV'),
                              ],
                            ),
                          ),
                          const Column(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size20,
                                color: Colors.grey,
                              ),
                              Text(
                                '52.2k',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: Sizes.size12),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
                Positioned(
                  width: size.width,
                  bottom: 0,
                  child: BottomAppBar(
                    height: 75,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              AssetImage('assets/pictures/pic1.png'),
                        ),
                        Gaps.h20,
                        Expanded(
                          child: TextField(
                            onTap: _onStartWriting,
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            textInputAction: TextInputAction.newline,
                            cursorHeight: Sizes.size20,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: Sizes.size10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.at,
                                      color: isDarkMode(context)
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade900,
                                      size: Sizes.size24,
                                    ),
                                    Gaps.h9,
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: isDarkMode(context)
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade900,
                                      size: Sizes.size24,
                                    ),
                                    Gaps.h9,
                                    if (_isWriting)
                                      GestureDetector(
                                        onTap: _stopWriting,
                                        child: FaIcon(
                                          FontAwesomeIcons.circleArrowUp,
                                          color: Theme.of(context).primaryColor,
                                          size: Sizes.size24,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              hintText: 'Add comment...',
                              hintStyle: const TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w500,
                              ),
                              contentPadding: const EdgeInsets.only(
                                  bottom: Sizes.size9, left: Sizes.size7),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                              ),
                              filled: true,
                              fillColor: isDarkMode(context)
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                            ),
                          ),
                        ),
                        Gaps.h3,
                      ],
                    ),
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
