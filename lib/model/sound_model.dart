import 'dart:convert';

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

  factory Sound.fromJson(Map<String, dynamic> json) {
    return Sound(
      id: json['id'],
      name: json['name'],
      assetPath: json['assetPath'],
      icon: IconData(int.parse(json['iconCode']), fontFamily: json['iconFont']),
      defaultVolume: double.parse(json['defaultVolume']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'assetPath': assetPath,
      'iconCode': icon.codePoint.toString(),
      'iconFont': icon.fontFamily,
      'defaultVolume': defaultVolume.toString(),
    };
  }

  static List<Sound> listFromJson(String jsonString) {
    final json = jsonDecode(jsonString);
    return List<Sound>.from(json.map((x) => Sound.fromJson(x)));
  }

  static String listToJson(List<Sound> list) {
    return jsonEncode(list.map((x) => x.toJson()).toList());
  }
}
