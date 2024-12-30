import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/views/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool hasPermission = false;
  late CameraController _cameraController;
  bool cameraDenide = true;
  bool micDenide = true;
  bool isSelfieMode = false;
  bool isRecording = false;

  late FlashMode _flashMode;

  late Animation<double> _sizeAnimation;
  late Animation<double> _borderRadiusAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _opacityExpectAnimation;
  late AnimationController buttonAnimationController;
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0,
    upperBound: 1,
  );

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();

    cameraDenide =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    micDenide = microphonePermission.isDenied ||
        microphonePermission.isPermanentlyDenied;

    if (cameraDenide || micDenide) {
      /// 엑세스 권한 거부 당함
    } else {
      hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[isSelfieMode ? 1 : 0],
      ResolutionPreset.veryHigh,
    );

    await _cameraController.initialize();
    _flashMode = _cameraController.value.flashMode;
  }

  void toggleSelfieMode() async {
    isSelfieMode = !isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPermissions();
    buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // 크기 애니메이션: 원형에서 사각형으로 변할 때의 크기
    _sizeAnimation =
        Tween<double>(begin: 60, end: 100).animate(buttonAnimationController);
    // 모서리 둥글기 애니메이션: 원형에서 둥근 모서리로 변할 때의 반지름
    _borderRadiusAnimation =
        Tween<double>(begin: 30, end: 10).animate(buttonAnimationController);

    _opacityAnimation =
        Tween<double>(begin: 1, end: 0).animate(buttonAnimationController);

    _opacityExpectAnimation =
        Tween<double>(begin: 0, end: 1).animate(buttonAnimationController);

    _progressAnimationController.addListener(() {
      setState(() {});
    });

    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('the end');
        onRecordingTap();
      }
    });
  }

  Widget _takeButtons({
    required FlashMode flashMode,
    required IconData icon,
  }) {
    return IconButton(
      onPressed: () {
        setFlashMode(flashMode);
      },
      icon: Icon(icon,
          color: _flashMode == flashMode ? Colors.amber.shade300 : Colors.white,
          size: 30),
    );
  }

  Future<void> onRecordingTap() async {
    isRecording = !isRecording;
    if (isRecording) {
      if (_cameraController.value.isRecordingVideo) return;

      await _cameraController.startVideoRecording();

      buttonAnimationController.forward();
      _progressAnimationController.forward();
    } else {
      if (!_cameraController.value.isRecordingVideo) return;

      buttonAnimationController.reverse();
      _progressAnimationController.reset();

      final video = await _cameraController.stopVideoRecording();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPreviewScreen(
            video: video,
            isPicked: false,
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    _cameraController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video == null) return;
    print("video : $video, ${video.path}");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: hasPermission
            ? _cameraController.value.isInitialized
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: CameraPreview(_cameraController),
                      ),
                      Positioned(
                        top: 30,
                        right: 30,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: toggleSelfieMode,
                              icon: const Icon(Icons.flip_camera_ios,
                                  color: Colors.white, size: 30),
                            ),
                            Gaps.v10,
                            _takeButtons(
                                flashMode: FlashMode.off,
                                icon: Icons.flash_off_rounded),
                            Gaps.v10,
                            _takeButtons(
                                flashMode: FlashMode.always,
                                icon: Icons.flash_on_rounded),
                            Gaps.v10,
                            _takeButtons(
                                flashMode: FlashMode.auto,
                                icon: Icons.flash_auto_rounded),
                            Gaps.v10,
                            _takeButtons(
                                flashMode: FlashMode.torch,
                                icon: Icons.flashlight_on_rounded),
                          ],
                        ),
                      ),
                      if (_sizeAnimation.value > 70)
                        Positioned(
                          bottom: 100,
                          child: FadeTransition(
                            opacity: isRecording
                                ? _opacityExpectAnimation
                                : const AlwaysStoppedAnimation(0),
                            child: SizedBox(
                              height: 5,
                              width: 100,
                              child: LinearProgressIndicator(
                                value: _progressAnimationController.value,
                                backgroundColor: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: 40,
                        child: Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTap: onRecordingTap,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedBuilder(
                                    animation: buttonAnimationController,
                                    builder: (context, child) {
                                      return Container(
                                        width: _sizeAnimation.value,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                _borderRadiusAnimation.value),
                                            bottomRight: Radius.circular(
                                                _borderRadiusAnimation.value),
                                            topLeft: Radius.circular(Tween<
                                                    double>(begin: 30, end: 0)
                                                .animate(
                                                    buttonAnimationController)
                                                .value),
                                            topRight: Radius.circular(Tween<
                                                    double>(begin: 30, end: 0)
                                                .animate(
                                                    buttonAnimationController)
                                                .value),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  FadeTransition(
                                    opacity: _opacityAnimation,
                                    child: Container(
                                      width: Sizes.size24,
                                      height: Sizes.size24,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  FadeTransition(
                                    opacity: _opacityExpectAnimation,
                                    child: FaIcon(
                                      FontAwesomeIcons.pause,
                                      color: Colors.red.shade400,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                    onPressed: _onPickVideoPressed,
                                    icon: const FaIcon(FontAwesomeIcons.image,
                                        color: Colors.white, size: 24)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Initializing Camera...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Gaps.v40,
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
            : const Center(
                child: Text('No Permission'),
              ),
      ),
    );
  }
}
