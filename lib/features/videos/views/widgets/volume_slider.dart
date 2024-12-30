import 'package:flutter/material.dart';

class VolumeSlider extends StatefulWidget {
  final Function(double) onVolumeChanged;
  final double volume;

  const VolumeSlider({
    super.key,
    required this.onVolumeChanged,
    required this.volume,
  });

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 50,
      child: RotatedBox(
        quarterTurns: 3,
        child: SliderTheme(
          data: SliderThemeData(
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 8,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 16,
            ),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white.withOpacity(0.3),
            thumbColor: Colors.white,
            overlayColor: Colors.white.withOpacity(0.3),
          ),
          child: Slider(
            value: widget.volume,
            min: 0.0,
            max: 1.0,
            onChanged: widget.onVolumeChanged,
          ),
        ),
      ),
    );
  }
}
