import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        dense: true,
        leading: Icon(sound.icon, size: 32, color: Colors.white),

        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Text(
                sound.name,
                style: TextStyle(fontSize:16,color: Colors.white, fontWeight: FontWeight.bold,fontFamily: GoogleFonts.cinzelDecorative(
                    fontWeight: FontWeight.w700
                ).fontFamily),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Colors.white.withOpacity(0.5))
                ),
                child: Row(
                  children: [
                    Text("rain1",style: TextStyle(fontSize: 12,color: Colors.white),),
                    Icon(Icons.arrow_drop_down_outlined, color: Colors.white,),
                  ],
                ),
              )
            ],
          ),
        ),
        subtitle: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: Color(0xffb87767),
            inactiveTrackColor: Colors.white,
            thumbColor: Colors.white,
            overlayColor: Colors.white.withOpacity(0.8),
            valueIndicatorColor: Colors.white,
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 10,
            ),
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: Colors.white,
          ),
          child: Slider(
            value: value,
            onChanged: enabled ? onChanged : null,
            min: 0.0,
            max: 1.0,
            // divisions: 20,
            label: "${(value * 100).round()}%",
          ),
        )

    );
  }
}
