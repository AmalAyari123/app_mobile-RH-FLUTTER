// ignore_for_file: constant_identifier_names

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/Controller/authController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/accueil.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

enum FormData {
  Email,
  password,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 255, 255, 255);
  Color enabledtxt = const Color.fromARGB(255, 14, 13, 13);
  Color deaible = Colors.grey;
  bool isLoading = false;

  Color backgroundColor = const Color.fromARGB(255, 255, 254, 255);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User? user;

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/page-1/images/Visto Group .png',
                      width: 200,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bienvenue!\nVeuillez vous connecter pour continuer!",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 21, 21, 21),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 390,
                      height: 60,
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: emailController,
                        onTap: () {
                          setState(() {
                            selected = FormData.Email;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 244, 243, 240),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          label: const Text(
                            "Nom d'utilisateur",
                          ),
                          labelStyle: SafeGoogleFont('Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                          floatingLabelStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 390,
                      height: 60,
                      decoration: BoxDecoration(
                          color: selected == FormData.password
                              ? enabled
                              : backgroundColor),
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: passwordController,
                        onTap: () {
                          setState(() {
                            selected = FormData.password;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 244, 243, 240),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            icon: ispasswordev
                                ? Icon(
                                    Icons.visibility_off,
                                    color: selected == FormData.password
                                        ? const Color.fromRGBO(8, 65, 142, 1)
                                        : const Color.fromRGBO(8, 65, 142, 1),
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: selected == FormData.password
                                        ? const Color.fromRGBO(8, 65, 142, 1)
                                        : const Color.fromRGBO(8, 65, 142, 1),
                                    size: 20,
                                  ),
                            onPressed: () =>
                                setState(() => ispasswordev = !ispasswordev),
                          ),
                          label: const Text(
                            "Mot de passe",
                          ),
                          labelStyle: SafeGoogleFont('Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                          floatingLabelStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        obscureText: ispasswordev,
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 190),
                      child: Text(
                        'Mot de passe oublié ? ',
                        style: SafeGoogleFont('Lato',
                            decoration: TextDecoration.underline,
                            decorationThickness: 0.8,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 113, 111, 111)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 380,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            AuthentificationUser authUser =
                                AuthentificationUser();

                            authUser.authentification(
                              emailController.text,
                              passwordController.text,
                              context,
                              providerUser,
                            );

                            setState(() {
                              isLoading = false;
                            });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(8, 65, 142, 1),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isLoading) // Show spinner if isLoading is true
            const SpinKitFadingFour(
              duration: Duration(seconds: 5),
              color: Color.fromRGBO(8, 65, 142, 1),
              size: 60.0, // Customize spinner size
            ),
        ],
      ),
    );
  }
}
