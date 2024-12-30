import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';

class PlaybackConfigRepository {
  static const String _autoPlay = 'autoPlay';
  static const String _autoMute = 'autoMute';

  SharedPreferences prefs;

  PlaybackConfigRepository({required this.prefs});

  Future<void> setMuted(bool value) async {
    prefs.setBool(_autoMute, value);
  }

  Future<void> setAutoPlay(bool value) async {
    prefs.setBool(_autoPlay, value);
  }

  bool readMuted() {
    return prefs.getBool(_autoMute) ?? false;
  }

  bool readAutoPlay() {
    return prefs.getBool(_autoPlay) ?? false;
  }
}
