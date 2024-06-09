// ignore_for_file: must_be_immutable, prefer_final_fields, unused_field, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/notifController.dart';
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

  File? _image;

  Future _openGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      File? img = File(image.path);
      setState(() {
        _image = img;
      });
    } on PlatformException {}
  }

  Future<void> _openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      File? img = File(image.path);
      setState(() {
        _image = img;
      });
    } on PlatformException {}
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
    List<User>? users = providerUser.employes;

    String getRemainingSolde() {
      double solde1 = currentUser!.solde1 ?? 0;
      double soldeConge = currentUser!.soldeConge ?? 0;
      double congeMaladie = currentUser!.congeMaladie ?? 0;
      double recuperation = currentUser!.recuperation ?? 0;

      if (dropdownvalue3 == 'Congés de maladie') {
        return '${congeMaladie - (((dropdownvalue == '9:00' && dropdownvalue2 == '14:00') || (dropdownvalue == '14:00' && dropdownvalue2 == '18:00')) ? count - 0.5 : (dropdownvalue == '14:00' && dropdownvalue2 == '14:00') ? count - 1 : count)} jours';
      } else if (dropdownvalue3 == 'Congés payés') {
        return '${solde1 + soldeConge - (((dropdownvalue == '9:00' && dropdownvalue2 == '14:00') || (dropdownvalue == '14:00' && dropdownvalue2 == '18:00')) ? count - 0.5 : (dropdownvalue == '14:00' && dropdownvalue2 == '14:00') ? count - 1 : count)} jours';
      } else if (dropdownvalue3 == 'Récupération') {
        return '${recuperation - (((dropdownvalue == '9:00' && dropdownvalue2 == '14:00') || (dropdownvalue == '14:00' && dropdownvalue2 == '18:00')) ? count - 0.5 : (dropdownvalue == '14:00' && dropdownvalue2 == '14:00') ? count - 1 : count)} jours';
      } else {
        return '';
      }
    }

    User? chefDepartement;
    if (currentUser != null && users != null) {
      chefDepartement = users.firstWhere(
        (user) => user.userrole!.trim() == "Chef département",
        /* && // Trim whitespace
            user.DepartmentId == currentUser.DepartmentId,*/
        orElse: () => User(
            id: -1,
            name: 'Unknown',
            userrole: '',
            DepartmentId: -1), // Provide all required fields
      );
    }

    print(chefDepartement!.id);

    User? Admin;
    if (currentUser != null && users != null) {
      Admin = users.firstWhere(
        (user) => user.userrole!.trim() == "Admin",
        /* && // Trim whitespace
            user.DepartmentId == currentUser.DepartmentId,*/
        orElse: () => User(
            id: -1,
            name: 'Unknown',
            userrole: '',
            DepartmentId: -1), // Provide all required fields
      );
    }

    print(Admin!.id);

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
              height: MediaQuery.of(context).size.height - 194.5,
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
                          DropdownMenuItem<String>(
                            value: 'Congés de maladie',
                            child: Text('Congés de maladie',
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 17, 17, 18),
                                )),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Télétravail',
                            child: Text(
                              'Télétravail',
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 17, 17, 18),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Raison de famille',
                            child: Text(
                              'Raison de famille',
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 17, 17, 18),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Congés de Maternité',
                            child: Text(
                              'Congés de Maternité',
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 17, 17, 18),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Récupération',
                            child: Text(
                              'Récupération',
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 17, 17, 18),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Décès',
                            child: Text(
                              'Décès',
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 17, 17, 18),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Autres',
                            child: Text(
                              'Autres',
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 17, 17, 18),
                              ),
                            ),
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
                      child: _image == null
                          ? IconButton(
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Color.fromARGB(255, 34, 34, 37),
                                size: 35,
                              ),
                              onPressed: _showOptions,
                            )
                          : Container(
                              height: 120,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.contain)),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.black),
                                onPressed: _showOptions,
                              ),
                            )),
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
                                  text: dropdownvalue3 == 'Congés de maladie'
                                      ? "Votre solde de congés de maladie après l'approbation:\n"
                                      : dropdownvalue3 == 'Récupération'
                                          ? "Votre solde de jours récupérables après l'approbation:\n"
                                          : dropdownvalue3 == 'Congés payés'
                                              ? "Votre solde restant après l'approbation:\n"
                                              : "", // Return empty text if none of the conditions are met
                                  style: SafeGoogleFont(
                                    'Lato',
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 34, 34, 37),
                                  ),
                                ),
                                TextSpan(
                                  text: getRemainingSolde(),
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
                          double newCount =
                              count; // Default to the current count

                          if (dropdownvalue3 != 'Congés de maladie' &&
                              dropdownvalue3 != 'Congés payés' &&
                              dropdownvalue3 != 'Récupération') {
                            newCount = 0.0;
                          } else {
                            newCount = (((dropdownvalue == '9:00' &&
                                        dropdownvalue2 == '14:00') ||
                                    (dropdownvalue == '14:00' &&
                                        dropdownvalue2 == '18:00'))
                                ? count - 0.5
                                : (dropdownvalue == '14:00' &&
                                        dropdownvalue2 == '14:00')
                                    ? count - 1
                                    : count);
                          }

                          DateTime combinedDateTime2 =
                              DateTime.utc(year2, month2, day2, hour2, minute2);
                          Demande newDemande = Demande(
                            dateDebut: combinedDateTime,
                            dateFin: combinedDateTime2,
                            type: dropdownvalue3,
                            commentaire: commentaire.text.toString(),
                            count: newCount,
                          );
                          if (dropdownvalue3 == 'Congés de maladie' &&
                              (currentUser!.congeMaladie == null ||
                                  count > currentUser.congeMaladie!)) {
                            Get.snackbar(
                              '', // Title
                              "Votre solde de congés de maladie est insuffisant!", // Message
                              backgroundColor: const Color.fromRGBO(
                                  8, 65, 142, 1), // Background color
                              colorText: Colors.white, // Text color
                              snackPosition: SnackPosition.BOTTOM, // Position
                              borderRadius: 10, // Border radius
                              margin: const EdgeInsets.all(10), // Margin
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10), // Padding
                              duration: const Duration(seconds: 3), // Duration
                              animationDuration: const Duration(
                                  milliseconds: 300), // Animation duration
                            );
                          } else if (dropdownvalue3 == 'Congés payés' &&
                              (currentUser!.soldeConge == null ||
                                  count > currentUser!.soldeConge!)) {
                            Get.snackbar(
                              '', // Title
                              "Votre solde congés payés est insuffisant!", // Message
                              backgroundColor: const Color.fromRGBO(
                                  8, 65, 142, 1), // Background color
                              colorText: Colors.white, // Text color
                              snackPosition: SnackPosition.BOTTOM, // Position
                              borderRadius: 10, // Border radius
                              margin: const EdgeInsets.all(10), // Margin
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10), // Padding
                              duration: const Duration(seconds: 3), // Duration
                              animationDuration: const Duration(
                                  milliseconds: 300), // Animation duration
                            );
                          } else if (dropdownvalue3 == 'Récupération' &&
                              (currentUser!.recuperation == null ||
                                  count > currentUser!.recuperation!)) {
                            Get.snackbar(
                              '', // Title
                              "Votre solde des jours récupérables est insuffisant!", // Message
                              backgroundColor: const Color.fromRGBO(
                                  8, 65, 142, 1), // Background color
                              colorText: Colors.white, // Text color
                              snackPosition: SnackPosition.BOTTOM, // Position
                              borderRadius: 10, // Border radius
                              margin: const EdgeInsets.all(10), // Margin
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10), // Padding
                              duration: const Duration(seconds: 3), // Duration
                              animationDuration: const Duration(
                                  milliseconds: 300), // Animation duration
                            );
                          } else {
                            await createDemandeController(
                                context, newDemande, providerUser);
                            sendPushNotification(
                                Admin!.id!,
                                "Nouvelle demande!",
                                "Vous avez une demande en attente d'approbation de la part de ${currentUser!.name!}");
                            sendPushNotification(
                                chefDepartement!.id!,
                                "Nouvelle demande!",
                                "Vous avez une demande en attente d'approbation de la part de ${currentUser!.name!}");
                          }
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
