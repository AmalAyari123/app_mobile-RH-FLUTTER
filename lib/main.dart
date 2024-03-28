import 'package:flutter/material.dart';
import 'package:myapp/admin/Employe.dart';
import 'package:myapp/admin/accueil.dart';
import 'package:myapp/admin/add.dart';
import 'package:myapp/admin/update.dart';
import 'package:myapp/splash.dart';
import 'package:myapp/step1.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: accueil());
  }
}
