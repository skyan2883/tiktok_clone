import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController =
      TextEditingController(text: 'Initial Text');
  final int _itemCount = 20;
  late final TabController _tabController;

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print(value);
  }

  void _isTop() {
    if (!_tabController.indexIsChanging) {
      FocusScope.of(context).unfocus();
    }
  }

  void _onBodyTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(_isTop);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

// 코드 챌린지
// CupertinoSearchTextField(
//             controller: _textEditingController,
//             onChanged: _onSearchChanged,
//             onSubmitted: _onSearchSubmitted,
//           )

  @override
  Widget build(BuildContext context) {
    void onXmarkTap() {
      _textEditingController.clear();
    }

    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: _itemCount,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(top: Sizes.size16, left: Sizes.size20),
            child: Opacity(
              opacity: 0.7,
              child: FaIcon(FontAwesomeIcons.angleLeft),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: width * 0.6,
                ),
                height: Sizes.size40,
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Write',
                    hintStyle: TextStyle(
                      color: isDarkMode(context) ? Colors.white : Colors.grey,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 1, vertical: Sizes.size4),
                    filled: true,
                    fillColor: isDarkMode(context)
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: onXmarkTap,
                            child: const Opacity(
                              opacity: 0.7,
                              child: FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                size: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.size10,
                        right: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Opacity(
                            opacity: 0.7,
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: Sizes.size16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.size6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Gaps.h1,
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(
                  bottom: Sizes.size3, left: Sizes.size2, right: Sizes.size20),
              child: Opacity(
                opacity: 0.7,
                child: FaIcon(FontAwesomeIcons.sliders),
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).indicatorColor,
            labelStyle: const TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GestureDetector(
              onTap: _onBodyTap,
              child: GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(
                  Sizes.size6,
                ),
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 9 / 20,
                  crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                ),
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: 'assets/pictures/pic1.png',
                              image:
                                  'https://cdn.pixabay.com/photo/2023/09/22/03/51/beautiful-8267949_960_720.jpg'),
                        ),
                      ),
                      Gaps.v6,
                      const Text(
                        'hello worldhello worldhello worldhello worldhello worldhello worldhello worldhello world',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Sizes.size16 + Sizes.size2,
                            fontWeight: FontWeight.w700,
                            height: 0.9),
                      ),
                      Gaps.v8,
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: Sizes.size12,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.grey.shade600,
                        ),
                        child: const Row(
                          children: [
                            CircleAvatar(
                              radius: Sizes.size12,
                              backgroundImage:
                                  AssetImage('assets/pictures/pic1.png'),
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                'My avatar is going to be very long My avatar is going to be very long',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size14,
                              color: Colors.grey,
                            ),
                            Gaps.h3,
                            Text(
                              '2.5M',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(fontSize: Sizes.size28),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
