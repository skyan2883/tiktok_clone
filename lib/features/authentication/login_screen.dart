import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screens/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.of(context).push(
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
              const Text(
                'Log in to TikTok',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.size24,
                ),
              ),
              Gaps.v20,
              const Text(
                'Manage your account, check notifications, comment on videos, and more.',
                style: TextStyle(
                  fontSize: Sizes.size12,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              GestureDetector(
                child: AuthButton(
                  icon: const FaIcon(FontAwesomeIcons.user),
                  text: 'Use email / username',
                  onTapFunction: _onEmailLoginTap,
                ),
              ),
              Gaps.v14,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.apple),
                text: 'Continue with Apple',
                onTapFunction: (context) {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 2,
          color: Colors.grey.shade50,
          height: Sizes.size96,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gaps.h4,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  'Sign up',
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
