// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:myapp/Model/tache.dart';
import 'package:myapp/admin/Employe.dart';
import 'package:myapp/admin/calendar.dart';
import 'package:myapp/admin/dash.dart';
import 'package:myapp/homee.dart';

final List<Tache> tache = [
  Tache(
    text: "Gestion des employés",
    imageUrl: "assets/page-1/images/img2.png",
    percent: 75,
    backImage: "assets/page-1/images/box1.png",
    customFunction: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    },
  ),
  Tache(
    text: "Gestion des demandes",
    imageUrl: "assets/page-1/images/demande.png",
    percent: 50,
    backImage: "assets/page-1/images/box1.png",
    customFunction: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Calendar()),
      );
    },
  ),
  Tache(
    text: "Rapports et analyses",
    imageUrl: "assets/page-1/images/chart.png",
    percent: 25,
    backImage: "assets/page-1/images/box1.png",
    customFunction: (BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboardd()),
      );
    },
  ),
];
