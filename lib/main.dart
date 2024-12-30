import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/common/widgets/settings/toggle_dark_mode.dart';
import 'package:tiktok_clone/common/widgets/video_configuration/video_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  GoRouter.optionURLReflectsImperativeAPIs = true;

  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(prefs: preferences);

  runApp(ProviderScope(
    overrides: [
      playbackConfigProvider
          .overrideWith(() => PlaybackConfigViewModel(repository: repository)),
    ],
    child: TikTokApp(),
  ));
}

class TikTokApp extends StatelessWidget {
  TikTokApp({super.key});

  final lightTheme = ThemeData(
    indicatorColor: Colors.black,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey.shade500,
    ),
    textTheme: Typography.blackMountainView,
    brightness: Brightness.light,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade50,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Color(0xFFE9435A)),
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: Sizes.size16 + Sizes.size2,
        fontWeight: FontWeight.w600,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xFFE9435A),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
    ),
  );

  final darkTheme = ThemeData(
    indicatorColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey.shade500,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color(0xFFE9435A),
      selectionHandleColor: Color(0xFFE9435A),
      cursorColor: Color(0xFFE9435A),
    ),
    textTheme: Typography.whiteMountainView,
    brightness: Brightness.dark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade900,
    ),
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color(0xFFE9435A),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.grey.shade900,
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.grey.shade900,
      backgroundColor: Colors.grey.shade900,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: Sizes.size16 + Sizes.size2,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return VideoConfig(
      child: ValueListenableBuilder(
        valueListenable: themeModeFlag,
        builder: (context, themeModeFlag, child) => MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: 'TikTok Clone',
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('ko', ''),
          ],
          themeMode: themeModeFlag ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
        ),
      ),
    );
  }
}
