// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:myapp/Controller/autorisationController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/autorisation.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Authorisation extends StatefulWidget {
  const Authorisation({super.key});

  @override
  State<Authorisation> createState() => _AuthorisationState();
}

class _AuthorisationState extends State<Authorisation> {
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);
  TimeOfDay _timeOfDay2 = const TimeOfDay(hour: 8, minute: 30);
  late DateTime dateTime = DateTime.now();
  int _currentIndex = 0;

  void ShowTimePicker1() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  void ShowTimePicker2() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay2 = value!;
      });
    });
  }

  String formatDate(DateTime datee) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.format(datee);
  }

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    User? currentUser = providerUser.currentUser;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.grey[500],
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
          "Permission de sortir",
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Lato',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 204,
            margin: const EdgeInsets.only(top: 30),
            child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10),
                children: [
                  Text(
                    'Le Jour',
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 135, 137, 140),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    elevation: 0.7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2030),
                              ).then((value) {
                                setState(() {
                                  dateTime = value!;
                                  print(dateTime);
                                });
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(8, 65, 142, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Choisir la date ",
                                style: SafeGoogleFont(
                                  'Nunito Sans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            'Le jour : ',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff000113),
                            ),
                          ),
                          Text(
                            formatDate(dateTime),
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 182, 5, 5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ]),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Heure de début',
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 135, 137, 140),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    elevation: 0.7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextButton(
                            onPressed: () {
                              ShowTimePicker1();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(8, 65, 142, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Choisir l'heure de début",
                                style: SafeGoogleFont(
                                  'Nunito Sans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            'Heure de début : ',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff000113),
                            ),
                          ),
                          Text(
                            _timeOfDay.format(context).toString(),
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 182, 5, 5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Heure de fin',
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 135, 137, 140),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: Colors.white,
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: TextButton(
                                onPressed: () {
                                  ShowTimePicker2();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(8, 65, 142, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Choisir l'heure de fin",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                )),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Text(
                                'Heure de fin : ',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff000113),
                                ),
                              ),
                              Text(
                                _timeOfDay2.format(context).toString(),
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: const Color.fromARGB(255, 182, 5, 5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ]),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextButton(
                        onPressed: () {
                          DateTime heureDebut = DateTime(
                            dateTime.year, // Use the same year as dateTime
                            dateTime.month, // Use the same month as dateTime
                            dateTime.day, // Use the same day as dateTime
                            _timeOfDay.hour, // Set the hour from TimeOfDay
                            _timeOfDay.minute, // Set the minute from TimeOfDay
                          );

// Convert TimeOfDay to DateTime for heureFin

                          // Create a new Autorisation object with the selected values
                          Autorisation newAut = Autorisation(
                            heureDebut: DateTime(
                              dateTime.year, // Use the same year as dateTime
                              dateTime.month, // Use the same month as dateTime
                              dateTime.day, // Use the same day as dateTime
                              _timeOfDay.hour, // Set the hour from TimeOfDay
                              _timeOfDay
                                  .minute, // Set the minute from TimeOfDay
                            ),
                            heureFin: DateTime(
                              dateTime.year, // Use the same year as dateTime
                              dateTime.month, // Use the same month as dateTime
                              dateTime.day, // Use the same day as dateTime
                              _timeOfDay2.hour, // Set the hour from TimeOfDay
                              _timeOfDay2
                                  .minute, // Set the minute from TimeOfDay
                            ),
                            jour: DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                            ),
                            // Assign the DateTime object directly
                            // Set the status as needed
                          );
                          createAutorisationController(
                              context, newAut, providerUser);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(8, 65, 142, 1),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0))),
                        child: const Text(
                          "Envoyer la demande",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.5,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
