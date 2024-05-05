import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/departement.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  final User currentuser;
  const UpdateProfile({super.key, required this.currentuser});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController cin = TextEditingController();
  int _currentIndex = 0;

  TextEditingController tel = TextEditingController();
  String phoneNumber = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController cinController = TextEditingController();
  TextEditingController numtelController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  Departement? selectedDepartement;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial values
    nameController = TextEditingController(text: widget.currentuser!.name);
    emailController = TextEditingController(text: widget.currentuser!.email);
    numtelController =
        TextEditingController(text: widget.currentuser!.numTel.toString());
    cinController =
        TextEditingController(text: widget.currentuser!.numCIN.toString());

    companyController =
        TextEditingController(text: widget.currentuser!.companyGroup);
  }

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();

    List<User>? users = providerUser.employes;
    ProviderDepartement providerDepartement =
        context.watch<ProviderDepartement>();

    List<Departement>? departements = providerDepartement.departements;
    getDepartementsController(providerDepartement);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          "Modifier votre profile",
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Lato',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
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
                  controller: numtelController,
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
                    labelText: "Numero tel",
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
                    controller: cinController,
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
                        "Numero CIN",
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
                    controller: nameController,
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
                        'Prénom et nom',
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
                    controller: emailController,
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
                        'Adresse e-mail',
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
                child: DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 13),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 192, 187, 187)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  value: departements != null && departements!.isNotEmpty
                      ? departements!.first.name
                      : null, // Set default value
                  items: departements!
                      .map((item) => DropdownMenuItem<String>(
                            value: item.name,
                            child: Text(
                              item.name ?? '',
                              style: SafeGoogleFont(
                                'Rubik',
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ))
                      .toList(),

                  onChanged: (value) {
                    selectedDepartement = departements!.firstWhere(
                      (department) => department.name == value,
                    );
                    print(selectedDepartement);
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                  ),
                ),
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
                        "Nom du groupe",
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
                      widget.currentuser!.name = nameController.text.toString();
                      widget.currentuser.email =
                          emailController.text.toString();

                      try {
                        widget.currentuser.numTel =
                            numtelController.text.isNotEmpty
                                ? int.parse(numtelController.text)
                                : null;
                      } catch (e) {
                        print(
                            'Invalid input for numTel: ${numtelController.text}');
                        widget.currentuser.numTel = null;
                      }
                      widget.currentuser.companyGroup =
                          companyController.text.toString();
                      widget.currentuser.DepartmentId =
                          selectedDepartement != null
                              ? selectedDepartement!.id
                              : departements!.first.id;
                      // ignore: prefer_if_null_operators
                      widget.currentuser.departement =
                          selectedDepartement != null
                              ? selectedDepartement
                              : departements.first;

                      updateCurrentUserController(
                          context, widget.currentuser, providerUser!);
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
