import 'package:flutter/material.dart';

class Tache {
  final String text;
  final String imageUrl;
  final double percent;
  final String backImage;
  final Function(BuildContext) customFunction;

  Tache({
    required this.text,
    required this.imageUrl,
    required this.percent,
    required this.backImage,
    required this.customFunction,
  });
}
