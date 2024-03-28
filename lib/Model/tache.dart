import 'dart:ui';

import 'package:flutter/material.dart';

class Tache {
  final String text;
  final String lessons;
  final String imageUrl;
  final double percent;
  final String backImage;
  final Function(BuildContext) customFunction;

  Tache({
    required this.text,
    required this.lessons,
    required this.imageUrl,
    required this.percent,
    required this.backImage,
    required this.customFunction,
  });
}
