import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screens/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  static const routeURL = 'username';
  static const routeName = 'username';

  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onNextTap(BuildContext context) {
    if (_username.isEmpty) return;
    context.pushNamed(EmailScreen.routeName,
        extra: EmailScreenArgs(username: _username));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign up',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              'Create username',
              style: TextStyle(
                fontSize: Sizes.size20 + Sizes.size2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v12,
            Text(
              'You can always change this later.',
              style: TextStyle(
                fontSize: Sizes.size14 + Sizes.size1,
                color: Colors.grey.shade600,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v24,
            GestureDetector(
              onTap: () => _onNextTap(context),
              child: FormButton(
                disabled: _username.isEmpty,
                text: 'Sign up',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
