import 'package:flutter/material.dart';
import 'package:myapp/logiin.dart';

class StepFour extends StatefulWidget {
  const StepFour({super.key});

  @override
  State<StepFour> createState() => _StepFourState();
}

class _StepFourState extends State<StepFour> {
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
              image: const DecorationImage(
                image: AssetImage(
                    'assets/page-1/images/history.jpg'), // Replace this with your image path
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 147, 147, 147)
                      .withOpacity(0.5), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: const Offset(0, 3), // Offset
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'Consulter votre historique et\n      votre solde de congés',
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
              'Suivez regulièrement votre solde restant et votre historique des demandes. ',
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
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
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
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
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
                    color: Color.fromRGBO(8, 65, 142, 1),
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
