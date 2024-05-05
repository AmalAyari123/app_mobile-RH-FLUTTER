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

    // Initialize controllers with initial values

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
    DateTime? dateDebut = widget.demande!.dateDebut;
    DateTime? dateFin = widget.demande!.dateFin;
    String formattedDateDebut =
        DateFormat('yyyy-MM-dd  HH:mm').format(dateDebut!);
    String formattedDateFin = DateFormat('yyyy-MM-dd  HH:mm').format(dateFin!);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 250, 250),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Demande de congé',
          style: SafeGoogleFont(
            'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 27, 28, 28),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
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
                    'Lato',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 27, 28, 28),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            Text('DÉTAILS DU CONGÉ',
                style: SafeGoogleFont(
                  'Roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: const Color.fromARGB(255, 150, 149, 149),
                )),
            Container(
                height: MediaQuery.of(context).size.height - 220,
                margin: const EdgeInsets.only(top: 10),
                child: ListView(
                  padding: const EdgeInsets.all(7),
                  children: [
                    Container(
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Période :",
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 70, 105, 140),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    formattedDateDebut,
                                    style: SafeGoogleFont(
                                      'Rubik',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    'au',
                                    style: SafeGoogleFont(
                                      'Rubik',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    formattedDateFin,
                                    style: SafeGoogleFont(
                                      'Rubik',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ])),
                    SizedBox(height: 20),
                    Container(
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type :",
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 70, 105, 140),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.demande!.type ?? '',
                                style: SafeGoogleFont(
                                  'Rubik',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ])),
                    SizedBox(height: 20),
                    Container(
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Durée :",
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 70, 105, 140),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${widget.demande!.count.toString()} jours",
                                style: SafeGoogleFont(
                                  'Rubik',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ])),
                    SizedBox(height: 20),
                    Container(
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Commentaire :",
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 70, 105, 140),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.demande!.commentaire ?? '',
                                style: SafeGoogleFont(
                                  'Rubik',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ])),
                    SizedBox(height: 20),
                    Container(
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "justificatif:",
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 70, 105, 140),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${widget.demande!.justificatif ?? ''} ",
                                style: SafeGoogleFont(
                                  'Rubik',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ])),
                    const SizedBox(height: 20),
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
                              " Laiseer un commentaire :",
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 70, 105, 140),
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 8))),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.user!.userrole == "Chef département") {
                          Demande? demande = widget.demande;
                          demande!.repCommentaire =
                              LaissercommentaireController.text;
                          demande.status = 'Accepté par le chef département';
                          updateDemandeController(context, demande,
                              widget.index!, providerUser, widget.user!
                              // Set the status accordingly
                              );
                        } else {
                          Demande? demande = widget.demande;
                          demande!.repCommentaire =
                              LaissercommentaireController.text;
                          demande.status = 'Accepté';
                          updateDemandeController(context, demande,
                              widget.index!, providerUser, widget.user!
                              // Set the status accordingly
                              );
                          updateSolde(context, widget.index!, providerUser,
                              widget.user!);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 72, 211, 76)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check,
                                color: Colors.white), // Add your icon here
                            const SizedBox(
                                width:
                                    8), // Add some space between the icon and text
                            Text(
                              "Soummettre le congé",
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
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Demande? demande = widget.demande;
                        demande!.repCommentaire =
                            LaissercommentaireController.text;
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
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.close,
                                color: Colors.white), // Add your icon here
                            const SizedBox(
                                width:
                                    8), // Add some space between the icon and text
                            Text(
                              "Refuser le congé",
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
                )),
          ],
        ),
      ),
    );
  }
}


         
           /* Row(
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
}*/
