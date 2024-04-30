// ignore_for_file: must_be_immutable, prefer_final_fields, unused_field, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Formulaire extends StatefulWidget {
  int _currentIndex = 0;

  DateTime? startDate;
  DateTime? endDate;
  double count;
  Formulaire(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.count});

  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  TextEditingController commentaire = TextEditingController();
  int _currentIndex = 1;
  late double count;

  @override
  void initState() {
    count = widget.count;
    super.initState();
  }

  String dropdownvalue = '9:00';
  String dropdownvalue2 = '18:00';
  String dropdownvalue3 = 'Congés payés';

  String formatDate(DateTime datee) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.format(datee);
  }

  Future<void> _openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      print('Image path: ${pickedFile.path}');
    }
  }

  Future<void> _openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      print('Image path: ${pickedFile.path}');
    }
    Navigator.pop(context);
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a photo'),
              onTap: () {
                _openCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Choose from gallery'),
              onTap: () {
                _openGallery();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    User? currentUser = providerUser.currentUser;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 10,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              )),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
          centerTitle: true,
          title: Text(
            "Formulaire de congés",
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w500,
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
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromRGBO(8, 65, 142, 1),
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
        body: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height - 184.5,
              margin: const EdgeInsets.only(top: 10),
              child: ListView(
                padding: const EdgeInsets.only(left: 10, right: 10),
                children: [
                  Text(
                    'Période de congés',
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 34, 34, 37),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Du: ",
                                  style: SafeGoogleFont(
                                    'Lato',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 139, 137, 141),
                                  ),
                                ),
                                if (widget.startDate != null)
                                  Text(
                                    " ${formatDate(widget.startDate!)}    ",
                                    style: SafeGoogleFont(
                                      'Lato',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                DropdownButton<String>(
                                    value: dropdownvalue,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 25,
                                    ),
                                    items: const [
                                      DropdownMenuItem<String>(
                                        value: '9:00',
                                        child: Text('9:00'),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: '14:00',
                                        child: Text('14:00'),
                                      ),
                                    ],
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    }),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "Au: ",
                                  style: SafeGoogleFont(
                                    'Lato',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 139, 137, 141),
                                  ),
                                ),
                                if (widget.endDate != null)
                                  Text(
                                    " ${formatDate(widget.endDate!)}   ",
                                    style: SafeGoogleFont(
                                      'Lato',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                DropdownButton<String>(
                                    value: dropdownvalue2,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 25,
                                    ),
                                    items: const [
                                      DropdownMenuItem<String>(
                                        value: '9:00',
                                        child: Text('9:00'),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: '14:00',
                                        child: Text('14:00'),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: '18:00',
                                        child: Text('18:00'),
                                      ),
                                    ],
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue2 = newValue!;
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 10,
                          height: 90,
                          child: LottieBuilder.asset(
                            'assets/page-1/images/calendar.json',
                            height: 90,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Type de congés',
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 34, 34, 37),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 5.5, top: 5, bottom: 5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(9),
                        value: dropdownvalue3,
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 190),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 47, 47, 87),
                            size: 25,
                          ),
                        ),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'Congés payés',
                            child: Text(
                              'Congés payés',
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 17, 17, 18),
                              ),
                            ),
                          ),
                          const DropdownMenuItem<String>(
                            value: 'Congés de maladie',
                            child: Text('Congés de maladie'),
                          ),
                          const DropdownMenuItem<String>(
                            value: 'Télétravail',
                            child: Text('Télétravail'),
                          ),
                          const DropdownMenuItem<String>(
                            value: 'Raison de famille',
                            child: Text('Raison de famille'),
                          ),
                          const DropdownMenuItem<String>(
                            value: 'Congés de Maternité',
                            child: Text('Congés de Maternité'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue3 = newValue!;
                          });
                        }),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: commentaire,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      label: Text(
                        "Commentaire ",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(255, 34, 34, 37),
                        ),
                      ),
                      labelStyle: SafeGoogleFont('Lato',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Justificatif ",
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 34, 34, 37),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 246, 246),
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 201, 198, 198)
                              .withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 0.4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Color.fromARGB(255, 34, 34, 37),
                        size: 35,
                      ),
                      onPressed: _showOptions,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Durée d'absence et solde ",
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 34, 34, 37),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 246, 246),
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 201, 198, 198)
                              .withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 0.4,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            "Durée d'absence : ",
                            style: SafeGoogleFont(
                              'Lato',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 34, 34, 37),
                            ),
                          ),
                          Text(
                            '${((dropdownvalue == '9:00' && dropdownvalue2 == '14:00') || (dropdownvalue == '14:00' && dropdownvalue2 == '18:00')) ? count - 0.5 : (dropdownvalue == '14:00' && dropdownvalue2 == '14:00') ? count - 1 : count} jours',
                            style: SafeGoogleFont(
                              'Lato',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 15),
                        DefaultTextStyle(
                          style: TextStyle(color: Colors.black),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "Votre solde restant après l'approbation:\n",
                                  style: SafeGoogleFont(
                                    'Lato',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 34, 34, 37),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${currentUser!.solde1! + currentUser.soldeConge! - (((dropdownvalue == '9:00' && dropdownvalue2 == '14:00') || (dropdownvalue == '14:00' && dropdownvalue2 == '18:00')) ? count - 0.5 : (dropdownvalue == '14:00' && dropdownvalue2 == '14:00') ? count - 1 : count)} jours",
                                  style: SafeGoogleFont(
                                    'Lato',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 380,
                    child: TextButton(
                        onPressed: () async {
                          int year = widget.startDate!.year;
                          int month = widget.startDate!.month;
                          int day = widget.startDate!.day;

                          int hour = int.parse(dropdownvalue.split(':')[0]);
                          print(hour);
                          int minute = int.parse(dropdownvalue.split(':')[1]);

                          DateTime combinedDateTime =
                              DateTime.utc(year, month, day, hour, minute);

                          int year2 = widget.endDate!.year;
                          int month2 = widget.endDate!.month;
                          int day2 = widget.endDate!.day;

// Extract hour and minute from the selected dropdown value
                          int hour2 = int.parse(dropdownvalue2.split(':')[0]);
                          int minute2 = int.parse(dropdownvalue2.split(':')[1]);
                          print(hour2);

                          DateTime combinedDateTime2 =
                              DateTime.utc(year2, month2, day2, hour2, minute2);
                          Demande newDemande = Demande(
                            dateDebut: combinedDateTime,
                            dateFin: combinedDateTime2,
                            type: dropdownvalue3,
                            commentaire: commentaire.text.toString(),
                            count: (((dropdownvalue == '9:00' &&
                                            dropdownvalue2 == '14:00') ||
                                        (dropdownvalue == '14:00' &&
                                            dropdownvalue2 == '18:00'))
                                    ? count - 0.5
                                    : (dropdownvalue == '14:00' &&
                                            dropdownvalue2 == '14:00')
                                        ? count - 1
                                        : count)
                                .toDouble(),
                          );

                          await createDemandeController(
                              context, newDemande, providerUser);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(8, 65, 142, 1),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        child: const Text(
                          "Envoyer la demande",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            letterSpacing: 0.5,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ],
              )),
        ]));
  }
}
