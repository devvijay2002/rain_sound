import 'package:flutter/material.dart';

import '../../../model/sound_model.dart';


class SoundSliderTile extends StatelessWidget {
  final Sound sound;
  final double value;
  final bool enabled;
  final ValueChanged<double> onChanged;

  const SoundSliderTile({
    super.key,
    required this.sound,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(sound.icon, size: 32),
      title: Text(sound.name),
      subtitle: Slider(
        value: value,
        onChanged: enabled ? onChanged : null,
        min: 0.0,
        max: 1.0,
        divisions: 20,
        label: "${(value * 100).round()}%",
      ),
    );
  }
}