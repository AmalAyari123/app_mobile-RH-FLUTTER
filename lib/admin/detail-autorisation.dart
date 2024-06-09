import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:myapp/Controller/AutorisationController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/autorisation.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

class AutorisationDetails extends StatefulWidget {
  final User? user;
  final int? index;
  final Autorisation? autorisation;
  const AutorisationDetails(
      {super.key, this.user, this.index, this.autorisation});

  @override
  State<AutorisationDetails> createState() => _AutorisationDetailsState();
}

class _AutorisationDetailsState extends State<AutorisationDetails> {
  TextEditingController heureDebutController = TextEditingController();

  TextEditingController heureFinController = TextEditingController();
  TextEditingController jourController = TextEditingController();

  @override
  void initState() {
    super.initState();

    DateTime? heureDebut = widget.autorisation!.heureDebut;
    DateTime? heureFin = widget.autorisation!.heureFin;
    DateTime? jour = widget.autorisation!.jour;

    String formattedDateDebut = DateFormat('HH:mm').format(heureDebut!);

    String formattedjour = DateFormat('yyyy-MM-dd').format(jour!);
    String formattedDateFin = DateFormat('HH:mm').format(heureFin!);
    // Initialize controllers with initial values
    heureDebutController = TextEditingController(text: formattedDateDebut);
    heureFinController = TextEditingController(text: formattedDateFin);
    jourController = TextEditingController(text: formattedjour);
  }

  // Add the appointment to the list

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: const Color.fromARGB(255, 193, 191, 191),
        centerTitle: true,
        title: const Text('Gestion de la demande'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                /* FutureBuilder<String?>(
                 future: fetchProfilePicture(widget.user!.avatarId ?? 0),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data!),
                      );
                    } else {
                      return CircleAvatar(
                        child: Icon(Icons.person),
                      );
                    }
                  },
                ),*/
                const SizedBox(width: 20),
                Text(
                  widget.user!.name ?? '',
                  style: SafeGoogleFont(
                    'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 27, 28, 28),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            TextField(
                controller: jourController,
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
                      "Le jour",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 70, 105, 140),
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 8))),
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  width: 172,
                  child: TextField(
                      controller: heureDebutController,
                      readOnly: true,
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
                            "heure de début",
                            style: SafeGoogleFont(
                              'Lato',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 70, 105, 140),
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 8))),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 172,
                  child: TextField(
                      controller: heureFinController,
                      readOnly: true,
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
                            "Heure de fin",
                            style: SafeGoogleFont(
                              'Lato',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 70, 105, 140),
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 8))),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (widget.user!.userrole == "Chef département") {
                      updateAutorisationController(
                          context,
                          widget.autorisation!,
                          widget.index!,
                          providerUser,
                          widget.user!,
                          'Accepté par le chef département'
                          // Set the status accordingly
                          );
                    } else {
                      updateAutorisationController(
                          context,
                          widget.autorisation!,
                          widget.index!,
                          providerUser,
                          widget.user!,
                          'Accepté'
                          // Set the status accordingly
                          );
                      Navigator.of(context).pop();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check,
                            color: Colors.white), // Add your icon here
                        const SizedBox(
                            width:
                                8), // Add some space between the icon and text
                        Text(
                          "Accepter",
                          style: SafeGoogleFont(
                            'Lato',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    updateAutorisationController(context, widget.autorisation!,
                        widget.index!, providerUser, widget.user!, 'Refusé'
                        // Pass the new status as a string
                        );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.close,
                            color: Colors.white), // Add your icon here
                        const SizedBox(
                            width:
                                8), // Add some space between the icon and text
                        Text(
                          "Refuser",
                          style: SafeGoogleFont(
                            'Lato',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
