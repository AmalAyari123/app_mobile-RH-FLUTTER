// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';

class solde extends StatefulWidget {
  const solde({super.key});

  @override
  State<solde> createState() => _soldeState();
}

class _soldeState extends State<solde> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 9,
            shadowColor: Colors.grey,
            backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
            toolbarHeight: MediaQuery.of(context).size.height / 1.8,
            leading: Container(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(50, 40.0),
              ),
            ),
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: kToolbarHeight),
                Text(
                  "Solde de congés total",
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Lato',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 60, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Solde 2023',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Color.fromARGB(255, 249, 249, 249)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '3 jours',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color.fromARGB(255, 205, 203, 203)),
                          ),
                        ],
                      ),
                      SizedBox(width: 25),
                      Column(
                        children: [
                          Text(
                            'Solde 2024',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Color.fromARGB(255, 249, 249, 249)),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '18 jours',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color.fromARGB(255, 205, 203, 203)),
                          ),
                        ],
                      ),
                      SizedBox(width: 25),
                      Column(
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '21 jours',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Color.fromARGB(255, 205, 203, 203)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 244, 240, 240),
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
        body: const Padding(
          padding: EdgeInsets.only(top: 30, left: 20),
          child: Text(
            "Le solde de l'année précédente est valable jusqu'à la fin de l'année 2024 ( 31-12-2024 ).",
            style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Color.fromARGB(255, 100, 99, 99)),
          ),
        )

        /*Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Center(
              child: Text(
                'Mon Solde De Congés',
                style: SafeGoogleFont(
                  'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 280,
            margin: const EdgeInsets.only(top: 150),
            child: ListView(
              padding: const EdgeInsets.only(left: 30, right: 30),
              children: const [
                Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Color.fromARGB(166, 205, 30, 7)),
                    ),
                    Spacer(),
                    Text(
                      '24 jours',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(166, 205, 30, 7)),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      Text(
                        'Congés Payés 2023',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        '4 jours',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(166, 14, 10, 10)),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Solde valable à fin de période (31/12/2024)',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromARGB(166, 14, 10, 10)),
                  ),
                ]),
                SizedBox(height: 50),
                Row(
                  children: [
                    Text(
                      'Congés Payés 2024',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Spacer(),
                    Text(
                      '20 jours',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(166, 14, 10, 10)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),*/
        );
  }
}
