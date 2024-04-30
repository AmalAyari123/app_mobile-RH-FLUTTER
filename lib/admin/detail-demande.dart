import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

class DemandeDetails extends StatefulWidget {
  final User? user;
  final int? index;
  final Demande? demande;
  const DemandeDetails({super.key, this.user, this.index, this.demande});

  @override
  State<DemandeDetails> createState() => _DemandeDetailsState();
}

class _DemandeDetailsState extends State<DemandeDetails> {
  TextEditingController dateDebutController = TextEditingController();

  TextEditingController dateFinController = TextEditingController();
  TextEditingController TypeController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();
  TextEditingController LaissercommentaireController = TextEditingController();

  @override
  void initState() {
    super.initState();

    DateTime? dateDebut = widget.demande!.dateDebut;
    DateTime? dateFin = widget.demande!.dateFin;

    String formattedDateDebut =
        DateFormat('yyyy-MM-dd HH:mm').format(dateDebut!);
    String formattedDateFin = DateFormat('yyyy-MM-dd HH:mm').format(dateFin!);
    // Initialize controllers with initial values
    dateDebutController = TextEditingController(text: formattedDateDebut);
    dateFinController = TextEditingController(text: formattedDateFin);
    TypeController = TextEditingController(text: widget.demande!.type);
    commentaireController =
        TextEditingController(text: widget.demande!.commentaire);
    LaissercommentaireController =
        TextEditingController(text: widget.demande!.repCommentaire);
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
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.user!.profilePic ?? ''),
                  radius: 30,
                ),
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
            Row(
              children: [
                SizedBox(
                  width: 172,
                  child: TextField(
                      controller: dateDebutController,
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
                            "Date de début",
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
                      controller: dateFinController,
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
                            "Date de fin",
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
            const SizedBox(height: 22),
            TextField(
                controller: TypeController,
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
                      "Type de congés",
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
            const SizedBox(height: 22),
            TextField(
                controller: commentaireController,
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
                      "Commentaire",
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
            const SizedBox(height: 22),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.image,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                      width: 8), // Add some space between the icon and text
                  Text(
                    "Voir justificatif",
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 70, 105, 140),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            TextField(
                controller: LaissercommentaireController,
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
                      "Laissez un commentaire",
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
            const SizedBox(height: 60),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (widget.user!.userrole == "Chef département") {
                      Demande? demande = widget.demande;
                      demande!.repCommentaire =
                          LaissercommentaireController.text;
                      demande.status = 'Accepté par le chef département';
                      updateDemandeController(context, demande, widget.index!,
                          providerUser, widget.user!
                          // Set the status accordingly
                          );
                    } else {
                      Demande? demande = widget.demande;
                      demande!.repCommentaire =
                          LaissercommentaireController.text;
                      demande.status = 'Accepté';
                      updateDemandeController(context, demande, widget.index!,
                          providerUser, widget.user!
                          // Set the status accordingly
                          );
                      updateSolde(
                          context, widget.index!, providerUser, widget.user!);
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
                    Demande? demande = widget.demande;
                    demande!.repCommentaire = LaissercommentaireController.text;
                    demande.status = 'Refusé';
                    updateDemandeController(context, demande, widget.index!,
                        providerUser, widget.user!
                        // Pass the new status as a string
                        );
                    Navigator.of(context).pop();
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
