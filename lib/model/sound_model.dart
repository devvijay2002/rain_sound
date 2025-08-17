import 'package:flutter/material.dart';

class Sound {
  final String id;
  final String name;
  final String assetPath;
  final IconData icon;
  final double defaultVolume;

  const Sound({
    required this.id,
    required this.name,
    required this.assetPath,
    required this.icon,
    required this.defaultVolume,
  });
}