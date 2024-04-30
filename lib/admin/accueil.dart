import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
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
    getUsersController(providerUser);

    ProviderDepartement providerDepartement =
        context.watch<ProviderDepartement>();
    getDepartementsController(providerDepartement);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Ionicons.log_out_outline,
              color: Colors.grey,
              size: 28,
            ),
            onPressed: () {
              logout(context, providerUser);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.grey, size: 28),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                size: 30,
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
                        text: "Bienvenue ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 70, 105, 140),
                            fontSize: 23),
                        children: [
                          TextSpan(
                            text: "au Visto Group!",
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
                    const TacheGrid(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))));
  }
}
