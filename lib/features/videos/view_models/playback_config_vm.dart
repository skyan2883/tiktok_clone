import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository repository;

  PlaybackConfigViewModel({required this.repository});

  void setMuted(bool value) {
    repository.setMuted(value);
    state = PlaybackConfigModel(
      autoMute: value,
      autoPlay: state.autoPlay,
    );
  }

  void setAutoPlay(bool value) {
    repository.setAutoPlay(value);
    state = PlaybackConfigModel(
      autoMute: state.autoMute,
      autoPlay: value,
    );
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      autoMute: repository.readMuted(),
      autoPlay: repository.readAutoPlay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
