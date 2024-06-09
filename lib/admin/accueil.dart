import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/adminNotif.dart';
import 'package:myapp/admin/gestionSolse.dart';
import 'package:myapp/chef%20departement/notification.dart';
import 'package:myapp/widgets/grid.dart';
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;

    User? currentUser = providerUser.currentUser;

    ProviderDepartement providerDepartement =
        context.watch<ProviderDepartement>();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Ionicons.log_out_outline,
              color: Colors.grey,
              size: 35,
            ),
            onPressed: () {
              logout(context, providerUser, currentUser!.id!);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.grey, size: 28),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AdminNotification();
                }));
              },
              icon: const Icon(
                Icons.notifications,
                size: 35,
                color: Colors.grey,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: "Bienvenue au ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 70, 105, 140),
                            fontSize: 23),
                        children: [
                          TextSpan(
                            text: "Visto Group!",
                            style: TextStyle(
                                color: Color.fromARGB(255, 70, 105, 140),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height - 20,
                        margin: const EdgeInsets.only(top: 10),
                        child: ListView(children: [
                          const TacheGrid(),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const Solde();
                              }));
                            },
                            child: Container(
                                height: 145,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/page-1/images/box1.png"),
                                      fit: BoxFit.fill),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Gestion des soldes",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontFamily: 'Lato'),
                                                ),
                                              ]),
                                          const SizedBox(width: 40),
                                          Image.asset(
                                            'assets/page-1/images/cc.png',
                                            height: 230,
                                            width: 90,
                                          )
                                        ]))),
                          ),
                          const SizedBox(
                            height: 200,
                          )
                        ]))
                  ],
                ))));
  }
}
