import 'package:flutter/material.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class DetailSolde extends StatefulWidget {
  final User? user;
  final int? index;
  final ProviderUser? providerUser;
  const DetailSolde({super.key, this.user, this.index, this.providerUser});

  @override
  State<DetailSolde> createState() => _DetailSoldeState();
}

class _DetailSoldeState extends State<DetailSolde> {
  TextEditingController soldeCongeController = TextEditingController();
  TextEditingController soldeCongePreviousController = TextEditingController();
  TextEditingController soldeCongeMaladieController = TextEditingController();
  TextEditingController RecuperationController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial values
    soldeCongeController =
        TextEditingController(text: (widget.user!.solde1 ?? 0.0).toString());
    soldeCongePreviousController = TextEditingController(
        text: (widget.user!.soldeConge ?? 0.0).toString());
    soldeCongeMaladieController = TextEditingController(
        text: (widget.user!.congeMaladie ?? 0.0).toString());

    RecuperationController = TextEditingController(
        text: (widget.user?.recuperation ?? 0.0).toString());
  }

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;
    DateTime now = DateTime.now();

    int currentYear = now.year;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Column(
            children: [
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
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 232, 229, 229)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 250, 248, 248)),
                      ),
                      label: Text(
                        "Transfert du solde ${currentYear - 1}",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 70, 105, 140),
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
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 232, 229, 229)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 250, 248, 248)),
                      ),
                      label: Text(
                        " Congés payés $currentYear",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 70, 105, 140),
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 8))),
              const SizedBox(height: 20),
              TextField(
                  controller: soldeCongeMaladieController,
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
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 232, 229, 229)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 250, 248, 248)),
                      ),
                      label: Text(
                        "congés de maladie ",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 70, 105, 140),
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 8))),
              const SizedBox(height: 20),
              TextField(
                  controller: RecuperationController,
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
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 232, 229, 229)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 250, 248, 248)),
                      ),
                      label: Text(
                        "jours récupérables",
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 70, 105, 140),
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 8))),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: ElevatedButton(
                  onPressed: () {
                    if (soldeCongeController.text.isNotEmpty) {
                      widget.user!.soldeConge =
                          soldeCongeController.text.toDouble();
                    } else {
                      widget.user!.soldeConge = 0;
                    }
                    if (soldeCongePreviousController.text.isNotEmpty) {
                      widget.user!.solde1 =
                          soldeCongePreviousController.text.toDouble();
                    } else {
                      widget.user!.solde1 = 0;
                    }
                    if (soldeCongeMaladieController.text.isNotEmpty) {
                      widget.user!.congeMaladie =
                          soldeCongeMaladieController.text.toDouble();
                    } else {
                      widget.user!.congeMaladie = 0;
                    }
                    if (RecuperationController.text.isNotEmpty) {
                      widget.user!.recuperation =
                          RecuperationController.text.toDouble();
                    } else {
                      widget.user!.recuperation = 0;
                    }

                    updateUserController(context, widget.user!, widget.index!,
                        widget.providerUser!);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                            color: const Color.fromARGB(255, 210, 208, 208),
                            width: 1),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Enregistrer les modifications',
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 70, 105, 140),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
