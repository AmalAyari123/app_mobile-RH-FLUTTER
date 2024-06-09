// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/departement.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/envv.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class Update extends StatefulWidget {
  final User? user;
  final int? index;
  final ProviderUser? providerUser;

  const Update(
      {super.key,
      required this.user,
      required this.index,
      required this.providerUser});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController soldeCongeController = TextEditingController();
  TextEditingController soldeCongePreviousController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController numtelController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  Departement? selectedDepartement;
  String? selectedRole;

  final List<String> roleItems = [
    'Employé',
    'Chef département',
    'Team Leader',
    'Responsable RH'
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial values
    nameController = TextEditingController(text: widget.user!.name);
    emailController = TextEditingController(text: widget.user!.email);
    soldeCongeController =
        TextEditingController(text: widget.user!.soldeConge.toString());
    soldeCongePreviousController =
        TextEditingController(text: widget.user!.solde1.toString());
    departmentController = TextEditingController();
    numtelController =
        TextEditingController(text: widget.user!.numTel.toString());
    companyController = TextEditingController(text: widget.user!.companyGroup);
    roleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;

    ProviderDepartement providerDepartement =
        context.watch<ProviderDepartement>();

    getDepartementsController(providerDepartement);

    List<Departement>? departements = providerDepartement.departements;
    DateTime now = DateTime.now();
    User? currentUser = providerUser.currentUser;

    int currentYear = now.year;
    User? user = widget.user;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 120.0, right: 120),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white),
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
                        image: NetworkImage(widget.user!.avatarId != null
                            ? "http://$ipadressurl/database-files/${widget.user!.avatarId!}"
                            : 'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
                controller: nameController,
                style: SafeGoogleFont(
                  'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
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
                  contentPadding:
                      const EdgeInsets.only(top: 10, bottom: 10, left: 8),
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
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
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
                    contentPadding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 8))),
            const SizedBox(height: 20),
            TextField(
                controller: soldeCongeController,
                style: SafeGoogleFont(
                  'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
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
                    contentPadding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 8))),
            const SizedBox(height: 20),
            TextField(
                controller: soldeCongePreviousController,
                style: SafeGoogleFont(
                  'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
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
                    contentPadding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 8))),
            const SizedBox(height: 20),
            DropdownButtonFormField2<String>(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 192, 187, 187)),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              value: departements?.isNotEmpty ?? false
                  ? departements!.first.name
                  : null, // Set default value
              items: departements != null
                  ? departements!
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
                      .toList()
                  : [],

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
            const SizedBox(height: 20),
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              value: roleItems.isNotEmpty
                  ? roleItems.first
                  : null, // Set default value
              items: roleItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
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
                selectedRole = value; // Update the selectedRole variable

                print(selectedRole); // Print selected role for debugging
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
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
                controller: numtelController,
                style: SafeGoogleFont(
                  'Rubik',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
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
                  contentPadding:
                      const EdgeInsets.only(top: 10, bottom: 10, left: 8),
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
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
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
                  contentPadding:
                      const EdgeInsets.only(top: 10, bottom: 10, left: 8),
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: const Color(0xff2da9ef),
                ),
                onPressed: () async {
                  user!.name = nameController.text.toString();
                  user.email = emailController.text.toString();

                  user.userrole =
                      selectedRole != null ? selectedRole : roleItems.first;
                  if (soldeCongeController.text.isNotEmpty) {
                    user.soldeConge = soldeCongeController.text.toDouble();
                  } else {
                    user.soldeConge = 0;
                  }
                  if (soldeCongePreviousController.text.isNotEmpty) {
                    user.solde1 = soldeCongePreviousController.text.toDouble();
                  } else {
                    user.solde1 = 0;
                  }
                  try {
                    user.numTel = numtelController.text.isNotEmpty
                        ? int.parse(numtelController.text)
                        : null;
                  } catch (e) {
                    print('Invalid input for numTel: ${numtelController.text}');
                    user.numTel = null;
                  }
                  user.companyGroup = companyController.text.toString();
                  user.DepartmentId = selectedDepartement != null
                      ? selectedDepartement!.id
                      : departements!.first.id;
                  // ignore: prefer_if_null_operators
                  user.departement = selectedDepartement != null
                      ? selectedDepartement
                      : departements!.first;

                  updateUserController(
                      context, user, widget.index!, widget.providerUser!);
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
        ));
  }
}
