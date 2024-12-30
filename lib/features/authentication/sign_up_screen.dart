import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screens/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static const routeURL = '/';
  static const routeName = 'signUp';

  void onLoginTap(BuildContext context) {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUp('TikTok'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.v20,
                  Text(
                    S.of(context).signUpDescription(1),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: Sizes.size11,
                          color: isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.black45,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  AuthButton(
                    icon: const FaIcon(FontAwesomeIcons.user),
                    text: S.of(context).signUpWithEmail,
                    onTapFunction: _onEmailTap,
                  ),
                  Gaps.v14,
                  AuthButton(
                    icon: const FaIcon(FontAwesomeIcons.apple),
                    text: S.of(context).signUpWithApple,
                    onTapFunction: (context) {},
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              elevation: 2,
              height: Sizes.size96,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size20,
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    S.of(context).alreadyHaveAnAccount,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gaps.h8,
                  GestureDetector(
                    onTap: () => onLoginTap(context),
                    child: Text(
                      S.of(context).login,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ]),
              )),
        );
      },
    );
  }
}
