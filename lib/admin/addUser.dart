// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/departement.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  Departement? selectedDepartement;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController soldeCongeController = TextEditingController();
  TextEditingController soldeCongePreviousController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController numtelController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  String? selectedRole;

  final List<String> roleItems = [
    'Employé',
    'Chef département',
    'Team Leader',
    'Responsable RH'
  ];
  @override
  void initState() {
    super.initState();
  }

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    ProviderDepartement providerDepartement =
        context.watch<ProviderDepartement>();

    List<Departement>? departements = providerDepartement.departements;
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;

    DateTime now = DateTime.now();

    int currentYear = now.year;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          children: [
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
            const SizedBox(
              height: 20,
            ),
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
                selectedRole = value;
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
            SizedBox(height: 20),
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
                  User newUser = User(
                    name: nameController.text.toString(),
                    companyGroup: companyController.text.toString(),
                    email: emailController.text.toString(),
                    DepartmentId: selectedDepartement != null
                        ? selectedDepartement!.id
                        : departements!.first.id,
                    solde1: soldeCongePreviousController.text.toDouble(),
                    soldeConge: soldeCongeController.text.toDouble(),
                    userrole:
                        selectedRole != null ? selectedRole : roleItems.first,
                  );

                  await createUser(context, newUser, providerUser);

                  // Handle the case where widget.providerUser is null
                  // For example, you could show an error message or provide a default value
                },
                child: const Text(
                  'Ajouter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
