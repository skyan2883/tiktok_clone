import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screens/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class LoginScreen extends StatelessWidget {
  static const routeURL = '/login';
  static const routeName = 'login';
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                S.of(context).loginTitle('TikTok'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.v20,
              Opacity(
                opacity: 0.7,
                child: Text(
                  S.of(context).loginSubTitle,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: Sizes.size12,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              GestureDetector(
                child: AuthButton(
                  icon: const FaIcon(FontAwesomeIcons.user),
                  text: S.of(context).loginWithEmail,
                  onTapFunction: _onEmailLoginTap,
                ),
              ),
              Gaps.v14,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.apple),
                text: S.of(context).loginWithApple,
                onTapFunction: (context) {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 2,
          color: isDarkMode(context) ? null : Colors.grey.shade50,
          height: Sizes.size96,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                S.of(context).dontHavaAccount,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gaps.h4,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  S.of(context).signUp('TikTok'),
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
  }
}
