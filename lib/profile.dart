import 'package:flutter/material.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController cin = TextEditingController();
  int _currentIndex = 0;

  TextEditingController tel = TextEditingController();
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
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
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height - 190,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 40),
        child: ListView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            children: [
              Stack(alignment: AlignmentDirectional.center, children: [
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
                        image: const DecorationImage(
                            image:
                                AssetImage('assets/page-1/images/amal.jpg')))),
                Positioned(
                    bottom: 0,
                    right: 120,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 47, 47, 87),
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.white)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_photo_alternate,
                            size: 17,
                            color: Colors.white,
                          )),
                    )),
              ]),
              const SizedBox(height: 50),
              SizedBox(
                height: 80,
                child: IntlPhoneField(
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
                    labelText: "Numero CIN",
                    labelStyle: SafeGoogleFont(
                      'Lato',
                      fontSize: 19,
                      fontWeight: FontWeight.w300,
                      color: const Color.fromARGB(255, 34, 34, 37),
                    ),
                    floatingLabelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  initialCountryCode: 'TN',
                  onChanged: (phone) {
                    // Handle phone number changes
                  },
                  onCountryChanged: (phone) {
                    // Handle country changes
                  },
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: cin,
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
                        "Numero tel",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(255, 34, 34, 37),
                        ),
                      ),
                      labelStyle: SafeGoogleFont('Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    )),
              ),
              const SizedBox(height: 27),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: cin,
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
                        'Société',
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(255, 34, 34, 37),
                        ),
                      ),
                      labelStyle: SafeGoogleFont('Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    )),
              ),
              const SizedBox(height: 27),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: cin,
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
                        'Département',
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(255, 34, 34, 37),
                        ),
                      ),
                      labelStyle: SafeGoogleFont('Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    )),
              ),
              const SizedBox(height: 27),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: cin,
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
                        "Equipe",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 19,
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(255, 34, 34, 37),
                        ),
                      ),
                      labelStyle: SafeGoogleFont('Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    )),
              ),
              const SizedBox(height: 27),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: cin,
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
                        "Adresse e-mail",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 21,
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(255, 34, 34, 37),
                        ),
                      ),
                      labelStyle: SafeGoogleFont('Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    )),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 380,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Homee()),
                      );
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 12.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    child: const Text(
                      "Enregistrer",
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
    );
  }
}
