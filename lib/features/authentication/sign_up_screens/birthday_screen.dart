import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/utils.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    int maxYears = initialDate.year - 12;
    initialDate = DateTime(maxYears, initialDate.month, initialDate.day);

    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap(BuildContext context) {
    context.pushReplacementNamed(InterestsScreen.routeName);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(' ').first;
    _birthdayController.value = TextEditingValue(text: textDate);
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
              'When\'s your birthday?',
              style: TextStyle(
                fontSize: Sizes.size20 + Sizes.size2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v12,
            const Opacity(
              opacity: 0.7,
              child: Text(
                'Your birthday won\'t be shown publicly.',
                style: TextStyle(
                  fontSize: Sizes.size14 + Sizes.size1,
                ),
              ),
            ),
            Gaps.v16,
            TextField(
              style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black,
              ),
              controller: _birthdayController,
              enabled: false,
            ),
            Gaps.v24,
            GestureDetector(
              onTap: () => _onNextTap(context),
              child: const FormButton(
                disabled: false,
                text: 'Sign up',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          maximumDate: initialDate,
          initialDateTime: initialDate,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
