// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class solde extends StatefulWidget {
  const solde({super.key});

  @override
  State<solde> createState() => _soldeState();
}

class _soldeState extends State<solde> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<Demande>? demandes = providerUser.demandes;

    User? currentUser = providerUser!.currentUser!;

    double sumCongesDeMaladie = demandes != null
        ? demandes
            .where((demande) =>
                demande.type == "Congés de maladie" &&
                demande.status == "Accepté")
            .map((demande) => demande.count)
            .fold(0, (previous, current) => previous + current!)
        : 0;
    // Calculate the progress value
    double progressValue = (currentUser!.congeMaladie! / 4.0);

    double sumCongesPayes = demandes != null
        ? demandes
            .where((demande) =>
                demande.type == "Congés payés" &&
                demande.status == "Accepté") // Perform the comparison
            .map((demande) => demande.count!) // Cap the count at solde1
            .fold(0, (previous, current) => previous + current!)
        : 0;
    double progressValue2 = (currentUser!.solde1! + currentUser!.soldeConge!) /
        (currentUser!.solde1! + currentUser!.soldeConge! + sumCongesPayes);
    double sumRecuperation = demandes != null
        ? demandes
            .where((demande) =>
                demande.type == "Récupération" &&
                demande.status == "Accepté") // Perform the comparison
            .map((demande) => demande.count!) // Cap the count at solde1
            .fold(0, (previous, current) => previous + current!)
        : 0;
    double progressValue3;

    if (currentUser != null &&
        currentUser!.recuperation != null &&
        sumRecuperation != 0) {
      progressValue3 = currentUser!.recuperation! /
          (currentUser!.recuperation! + sumRecuperation);
    } else {
      progressValue3 =
          0.0; // Set a default value in case of division by zero or null values
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              )),
          elevation: 6,
          shadowColor: Colors.grey,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
          centerTitle: true,
          title: Text(
            "Solde de congés détaillé",
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            ),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.grey[500], // Set to transparent

            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey[500],
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 30),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  size: 40,
                  color: Color.fromRGBO(8, 65, 142, 1),
                ),
                label: 'Congés',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  size: 30,
                ),
                label: 'Historique',
              ),
            ],
            onTap: (index) {
              // Handle navigation based on the selected index
              setState(() {
                _currentIndex = index;
              });

              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homee()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Absencee()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Historique()),
                );
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/page-1/images/maladie.png",
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Congé maladie ",
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 19, 20, 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "${currentUser!.congeMaladie!} jours restants ",
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 111, 112, 112),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${sumCongesDeMaladie.toStringAsFixed(1)} jours pris  ",
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 111, 112, 112),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              LinearProgressIndicator(
                value:
                    progressValue, // Set the progress value here (between 0.0 and 1.0)
                minHeight: 4, // Set the height of the line
                backgroundColor:
                    Colors.deepPurple.shade100, // Set the background color
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 182, 25, 17), // Set the progress color
                ),
              ),
              const SizedBox(height: 17),
              Container(
                height: 2,
                width: double.infinity, // Takes the full width available
                color: const Color.fromARGB(255, 238, 231, 231),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/page-1/images/calendar.png",
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Congés payés  ",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 19, 20, 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "${currentUser!.solde1! + currentUser!.soldeConge!} jours restants ",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 111, 112, 112),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${sumCongesPayes} jours pris ",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 111, 112, 112),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  LinearProgressIndicator(
                    value:
                        progressValue2, // Set the progress value here (between 0.0 and 1.0)
                    minHeight: 4, // Set the height of the line
                    backgroundColor:
                        Colors.deepPurple.shade100, // Set the background color
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(
                          255, 91, 116, 226), // Set the progress color
                    ),
                  ),
                  const SizedBox(height: 17),
                  Container(
                    height: 2,
                    width: double.infinity, // Takes the full width available
                    color: const Color.fromARGB(255, 238, 231, 231),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/page-1/images/calendarr.png",
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Récupération  ",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 19, 20, 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "${currentUser!.recuperation ?? 0} jours restants ",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 111, 112, 112),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${sumRecuperation.toStringAsFixed(1)} jours pris ",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 111, 112, 112),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  LinearProgressIndicator(
                    value:
                        progressValue3, // Set the progress value here (between 0.0 and 1.0)
                    minHeight: 4, // Set the height of the line
                    backgroundColor:
                        Colors.deepPurple.shade100, // Set the background color
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(
                          255, 23, 153, 47), // Set the progress color
                    ),
                  ),
                  const SizedBox(height: 17),
                  Container(
                    height: 2,
                    width: double.infinity, // Takes the full width available
                    color: const Color.fromARGB(255, 238, 231, 231),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              DefaultTextStyle(
                style: const TextStyle(color: Colors.black),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${currentUser!.solde1 ?? 0} jours  ',
                        // Return empty text if none of the conditions are met
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 34, 34, 37),
                        ),
                      ),
                      TextSpan(
                        text:
                            'est votre transfert , inclu dans votre solde de congés payés ${DateTime.now().year}.',
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 100, 99, 99),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Le solde de l'année précédente est valable jusqu'à la fin de l'année 2024 ( 31-12-2024 ).",
                style: const TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                    color: Color.fromARGB(255, 100, 99, 99)),
              ),
            ],
          ),
        ));
  }
}


              /*  Text(
                "Le solde de l'année précédente est valable jusqu'à la fin de l'année 2024 ( 31-12-2024 ).",
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Color.fromARGB(255, 100, 99, 99)),
              ),*/
