import 'package:flutter/material.dart';
import 'package:myapp/logiin.dart';
import 'package:myapp/step4.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 20, top: 120),
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                    'assets/page-1/images/teletravail.jpg'), // Replace this with your image path
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 147, 147, 147)
                      .withOpacity(0.5), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: Offset(0, 3), // Offset
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Demandez des télétravails',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lato'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Nous Vous simplifions les demandes de Home Office. ',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 129, 125, 125),
                  fontFamily: 'Lato'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StepFour()),
                  );
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 0.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                child: const Text(
                  "Suivant",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 13),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 0.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: const Color.fromRGBO(8, 65, 142, 1),
                    letterSpacing: 0.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
