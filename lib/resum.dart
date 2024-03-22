import 'package:flutter/material.dart';
import 'package:myapp/Controller/loadImage.dart';
import 'package:myapp/logiin.dart';
import 'package:myapp/provider/accountDetails.dart';
import 'package:provider/provider.dart';

import 'dart:async' show Future;
import 'dart:math';

import 'package:touchable/touchable.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    AccountDetails accountDetails = context.watch<AccountDetails>();
    List<ImageDetails>? steps = accountDetails.steps;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 800,
              child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(
                      top: 120, bottom: 10, left: 20, right: 80),
                  child: CanvasTouchDetector(
                    gesturesToOverride: const [
                      GestureType.onTapUp,
                    ],
                    builder: (context) => CustomPaint(
                      painter: _SinusoidalLinePainter(context, steps),
                      size: Size.infinite,
                    ),
                  )),
            ),
            SizedBox(height: 40),
            SizedBox(
                width: 200,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    child: const Text(
                      "Suivant",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.5,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}

class _SinusoidalLinePainter extends CustomPainter {
  double amplitude = 3;
  double frequency = 25;
  List<String> titles = [
    "Demandez\n des autorisations",
    "Demandez des congés",
    "Consultez l'historique\n et le solde",
    "Demandez des télétravails"
  ];
  List<ImageDetails>? steps;
  final BuildContext context;

  _SinusoidalLinePainter(this.context, this.steps);

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    double divConst = 3 * 19;

    var myCanvas = TouchyCanvas(context, canvas);
    final paint = Paint()
      ..color = Color.fromARGB(255, 110, 112, 114)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();

    final yStep = size.height / divConst;
    for (var i = 0; i <= divConst; i++) {
      final y = i * yStep;
      final x =
          size.width / 2 - sin(i * pi / frequency) * size.width / amplitude;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
    final pointPaint = Paint()..color = const Color.fromRGBO(8, 65, 142, 1);

    for (var i = 0; i <= 3; i++) {
      double z;
      double y;
      double x = size.width / 2 -
          sin(i * 19 * pi / frequency) * size.width / amplitude;

      z = x + 55;
      y = i * 19 * yStep;

      myCanvas.drawCircle(Offset(x, y), 0, pointPaint);

      final imageOffset = Offset(x, y - 60);
      final titlePainter = TextPainter(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: " ${titles[i]}",
            style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Lato')),
        textDirection: TextDirection.ltr,
      )..layout();
      if (i == 2) {
        titlePainter.paint(
            canvas,
            Offset(
              x - 260,
              y - 50,
            ));
      } else if (i == 1) {
        titlePainter.paint(
            canvas,
            Offset(
              x + 70,
              y - 70,
            ));
      } else if (i == 0) {
        titlePainter.paint(
            canvas,
            Offset(
              x + 60,
              y - 80,
            ));
      } else {
        titlePainter.paint(
            canvas,
            Offset(
              x + 60,
              y - 50,
            ));
      }

      paintImage(
          alignment: Alignment.center,
          fit: BoxFit.cover,
          canvas: canvas,
          rect: Rect.fromCircle(center: imageOffset, radius: 60),
          image: steps![i].imageInfo.image);
    }
  }

  @override
  bool shouldRepaint(_SinusoidalLinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_SinusoidalLinePainter oldDelegate) => false;
}

class IconPainter extends CustomPainter {
  final IconData icon;
  final Offset offsetIcon;
  final Color color;

  IconPainter(
      {required this.icon, required this.offsetIcon, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final iconData = icon;
    final textSpan = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
          color: color, fontFamily: iconData.fontFamily, fontSize: 22),
    );
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    textPainter.paint(canvas, offsetIcon);
  }

  @override
  bool shouldRepaint(IconPainter oldDelegate) {
    return oldDelegate.icon != icon ||
        oldDelegate.offsetIcon != offsetIcon ||
        oldDelegate.color != color;
  }
}
