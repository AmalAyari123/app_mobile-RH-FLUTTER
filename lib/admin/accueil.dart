import 'package:flutter/material.dart';
import 'package:myapp/Model/dataTache.dart';
import 'package:myapp/widgets/grid.dart';

class accueil extends StatefulWidget {
  const accueil({super.key});

  @override
  State<accueil> createState() => _accueilState();
}

class _accueilState extends State<accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.grey, size: 28),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.grey,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: "Bienvenue ",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                        children: [
                          TextSpan(
                            text: "au Visto Group!",
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TacheGrid(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))));
  }
}
