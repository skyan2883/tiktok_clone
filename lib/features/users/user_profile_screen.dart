import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) {
          return [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
              sliver: SliverAppBar(
                leading: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.angleLeft),
                ),
                title: const Text(
                  'FIFA',
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.bell),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.gear),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gaps.v10,
                  const CircleAvatar(
                    radius: Sizes.size64,
                    foregroundImage: NetworkImage(
                      'https://pbs.twimg.com/media/FkGUNuqXEAMktM-.jpg',
                    ),
                    child: Text('FIFA'),
                  ),
                  Gaps.v10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '@fifaworldcup',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gaps.h5,
                      FaIcon(FontAwesomeIcons.solidCircleCheck,
                          color: Colors.lightBlue.shade300, size: Sizes.size14),
                    ],
                  ),
                  Gaps.v16,
                  SizedBox(
                    height: Sizes.size44,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ProfileCount(count: '37', title: 'Following'),
                        VerticalDivider(
                          indent: Sizes.size10,
                          endIndent: Sizes.size10,
                          color: Colors.grey.shade300,
                          thickness: Sizes.size1,
                          width: Sizes.size32,
                        ),
                        const ProfileCount(count: '10.5M', title: 'Followers'),
                        VerticalDivider(
                          indent: Sizes.size10,
                          endIndent: Sizes.size10,
                          color: Colors.grey.shade300,
                          thickness: Sizes.size1,
                          width: Sizes.size32,
                        ),
                        const ProfileCount(count: '149.3M', title: 'Likes'),
                      ],
                    ),
                  ),
                  Gaps.v10,
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(Sizes.size3),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizes.size10,
                              ),
                              child: Text(
                                'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Gaps.h5,
                        Flexible(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Sizes.size10,
                                ),
                                child: FaIcon(FontAwesomeIcons.youtube,
                                    color: Colors.black, size: Sizes.size14),
                              ),
                            ),
                          ),
                        ),
                        Gaps.h5,
                        Flexible(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Sizes.size10,
                                ),
                                child: FaIcon(FontAwesomeIcons.arrowDown,
                                    color: Colors.black, size: Sizes.size14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v10,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                    child: Text(
                      'FIFA is the official account of the Fédération Internationale de Football Association (FIFA), the world governing body for football. FIFA.com is the official website of FIFA, the governing body of football. FIFA.com is the official website of FIFA, the governing body of football.',
                      style: TextStyle(
                        fontSize: Sizes.size12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const LinkButton(
                    icon: FaIcon(FontAwesomeIcons.link, size: Sizes.size12),
                    text: 'https://www.fifa.com/worldcup',
                  ),
                  Gaps.v20,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: const TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      labelColor: Colors.black,
                      indicatorColor: Colors.black,
                      labelPadding: EdgeInsets.symmetric(
                        vertical: Sizes.size10,
                      ),
                      tabs: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.size16),
                          child: Icon(Icons.grid_4x4_rounded),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.size16),
                          child: FaIcon(FontAwesomeIcons.heart),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(0),
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 16,
                crossAxisCount: 3,
                crossAxisSpacing: Sizes.size2,
                mainAxisSpacing: Sizes.size2,
              ),
              itemBuilder: (context, index) => Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/pictures/pic1.png',
                        image:
                            'https://cdn.pixabay.com/photo/2023/09/22/03/51/beautiful-8267949_960_720.jpg'),
                  ),
                  Positioned(
                    left: Sizes.size8,
                    top: Sizes.size8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(Sizes.size3),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Sizes.size2,
                          horizontal: Sizes.size4,
                        ),
                        child: Text(
                          'Pinned',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: Sizes.size8,
                    bottom: Sizes.size8,
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.play,
                            color: Colors.white, size: Sizes.size14),
                        Gaps.h8,
                        Text(
                          '4.1M',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Center(
              child: Text(
                'Tab 2',
                style: TextStyle(fontSize: Sizes.size28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCount extends StatelessWidget {
  const ProfileCount({
    super.key,
    required this.count,
    required this.title,
  });

  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: Sizes.size12,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

class LinkButton extends StatelessWidget {
  final FaIcon icon;
  final String text;

  const LinkButton({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Gaps.h4,
        Text(
          text,
          style: const TextStyle(
            fontSize: Sizes.size12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
