import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart' as image_saver;
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  const VideoPreviewScreen(
      {super.key, required this.video, required this.isPicked});
  final bool isPicked;
  final XFile video;

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  late final hasAccess;
  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));
    await _videoPlayerController.initialize();

    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  Future convertTempFileToVideo(String tempFilePath) async {
    final tempFile = File(tempFilePath);
    final fileContent = await tempFile.readAsBytes();

// 기존 파일 경로의 확장자 교체
    final newFilePath = tempFilePath.replaceFirst('.temp', '.mp4');

    final newFile = File(newFilePath);
    await newFile.writeAsBytes(fileContent);
    return newFilePath;
  }

  @override
  void initState() {
    super.initState();

    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;

    String newFilePath;

    if (widget.video.path.endsWith(".temp")) {
      newFilePath = await convertTempFileToVideo(widget.video.path);
      print("newFilePath : $newFilePath");
    } else {
      newFilePath = widget.video.path;
    }
    final result = await image_saver.ImageGallerySaver.saveFile(newFilePath,
        name: "TicTok Clone");
    print("saving video to gallery");
    _savedVideo = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Video Preview'),
          actions: [
            if (!widget.isPicked)
              IconButton(
                onPressed: _saveToGallery,
                icon: Icon(_savedVideo ? Icons.check : Icons.save),
              ),
          ],
        ),
        body: _videoPlayerController.value.isInitialized
            ? Stack(
                children: [
                  Positioned.fill(
                    child: VideoPlayer(_videoPlayerController),
                  ),
                ],
              )
            : const Center(
                child: Text('Loading...'),
              ),
      ),
    );
  }
}
