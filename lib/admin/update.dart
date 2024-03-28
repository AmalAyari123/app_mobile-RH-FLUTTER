import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/utils.dart';
import 'package:http/http.dart' as http;

class Update extends StatefulWidget {
  final int? id;
  final String? name;
  final String? email;
  final int? soldeconge;
  final int? solde1;
  final int? numtel;
  final String? company;
  final String? photopath;

  const Update(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.soldeconge,
      required this.solde1,
      required this.numtel,
      required this.company,
      required this.photopath});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController soldeCongeController;
  late TextEditingController soldeCongePreviousController;
  late TextEditingController departmentController;
  late TextEditingController numtelController;
  late TextEditingController companyController;
  late TextEditingController roleController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial values
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    soldeCongeController =
        TextEditingController(text: widget.soldeconge.toString());
    soldeCongePreviousController =
        TextEditingController(text: (widget.soldeconge! - 1).toString());
    departmentController = TextEditingController();
    numtelController = TextEditingController(text: widget.numtel.toString());
    companyController = TextEditingController(text: widget.company);
    roleController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers when they are no longer needed
    nameController.dispose();
    emailController.dispose();
    soldeCongeController.dispose();
    soldeCongePreviousController.dispose();
    departmentController.dispose();
    numtelController.dispose();
    companyController.dispose();
    roleController.dispose();
    super.dispose();
  }

  Future<void> updateName() async {
    final updatedName = nameController.text;
    // Call API to update name
    try {
      final response = await http.patch(
        Uri.parse('http://192.168.1.200:3000/users/name/${widget.id}'),
        body: jsonEncode({'name': updatedName}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        /*   setState(() {
        widget.name = updatedName; 
      });*/
        print('Name updated successfully');
      } else {
        print('Failed to update name');
      }
    } catch (error) {
      print('Error updating name: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    int currentYear = now.year;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            children: [
              Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 201, 198, 198)
                              .withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      image: DecorationImage(
                          image: NetworkImage(widget.photopath ?? '')))),
              const SizedBox(height: 20),
              TextField(
                  controller: nameController,
                  style: SafeGoogleFont(
                    'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: Text(
                      "Nom et prénom",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: emailController,
                  style: SafeGoogleFont(
                    'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: Text(
                      "Adresse e-mail",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              const SizedBox(height: 20),
              TextField(
                  controller: soldeCongeController,
                  style: SafeGoogleFont(
                    'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: Text(
                      "Solde de congés $currentYear ",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              const SizedBox(height: 20),
              TextField(
                  controller: soldeCongePreviousController,
                  style: SafeGoogleFont(
                    'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: Text(
                      "Solde de congés ${currentYear - 1} ",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  style: SafeGoogleFont(
                    'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: Text(
                      "Département",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              const SizedBox(height: 20),
              TextField(
                  controller: numtelController,
                  style: SafeGoogleFont(
                    'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: Text(
                      "Numero tel",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: companyController,
                  style: SafeGoogleFont(
                    'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: Text(
                      "Company Group",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              const SizedBox(height: 20),
              TextField(
                  style: SafeGoogleFont(
                    'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: Text(
                      "Role",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: const Color(0xff2da9ef),
                  ),
                  onPressed: () async {
                    await updateName();
                    Navigator.of(context).pop(); // Call the updateName method
                  },
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
