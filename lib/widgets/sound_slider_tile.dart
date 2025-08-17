import 'package:flutter/material.dart';
import 'package:rain_round/model/sound_model.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                sound.icon,
                color: enabled ? Colors.blueGrey : Colors.grey,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  sound.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: enabled ? null : Colors.grey,
                      ),
                ),
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: enabled ? null : Colors.grey,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Slider(
            value: value,
            onChanged: enabled ? onChanged : null,
            min: 0.0,
            max: 1.0,
            divisions: 100,
            label: '${(value * 100).toInt()}%',
          ),
        ],
      ),
    );
  }
}
