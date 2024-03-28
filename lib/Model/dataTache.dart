import 'package:flutter/material.dart';
import 'package:myapp/Model/tache.dart';
import 'package:myapp/admin/Employe.dart';
import 'package:myapp/homee.dart';

final List<Tache> tache = [
  Tache(
    text: "Gestion des employés",
    lessons: "35 Employés",
    imageUrl: "assets/page-1/images/img1.jpg",
    percent: 75,
    backImage: "assets/page-1/images/box1.png",
    customFunction: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homee()),
      );
    },
  ),
  Tache(
    text: "Portugese",
    lessons: "30 Lessons",
    imageUrl: "assets/page-1/images/img2.png",
    percent: 50,
    backImage: "assets/page-1/images/box2.png",
    customFunction: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    },
  ),
  Tache(
    text: "Italian",
    lessons: "20 Lessons",
    imageUrl: "assets/page-1/images/img2.png",
    percent: 25,
    backImage: "assets/page-1/images/box3.png",
    customFunction: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Homee()),
      );
    },
  ),
];
