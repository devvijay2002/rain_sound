import 'package:flutter/material.dart';
import '../const/audio.dart';
import '../model/sound_model.dart';

final List<Sound> kSounds = [
  Sound(
    id: "rain",
    name: "Rain",
    assetPath: rainSound1,
    icon: Icons.grain,
    defaultVolume: 0.7,
  ),
  Sound(
    id: "frogs",
    name: "Frogs",
    assetPath:frog1,
    icon: Icons.nature,
    defaultVolume: 0.3,
  ),
  Sound(
    id: "wind",
    name: "Wind",
    assetPath: wind1,
    icon: Icons.air,
    defaultVolume: 0.4,
  ),
  Sound(
    id: "thunder",
    name: "Thunder",
    assetPath: thunder1,
    icon: Icons.flash_on,
    defaultVolume: 0.2,
  ),
  Sound(
    id: "stream",
    name: "Stream",
    assetPath: stream1,
    icon: Icons.waves,
    defaultVolume: 0.35,
  ),
];