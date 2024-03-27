// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:myapp/step1.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Image.asset(
              'assets/page-1/images/Visto Group .png',
              width: 400,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: LottieBuilder.asset(
                fit: BoxFit.fill,
                'assets/page-1/images/loadingg.json',
              ),
            ),
          ),
        ],
      ),
      nextScreen: const StepOne(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      splashIconSize: 400,
      duration: 4000,
    );
  }
}
