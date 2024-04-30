// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/departement.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/logiin.dart';
import 'dart:async';

import 'package:myapp/service/userService.dart';

Future getUsersController(ProviderUser providerUser) async {
  http.Response response = (await getUsers());
  List<User> employes = [];

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    employes = data.map((json) => User.fromJson(json)).toList();
    providerUser.setEmployes(employes);
  } else {
    throw Exception('Failed to fetch users');
  }
}

Future getDepartementsController(
    ProviderDepartement providerDepartement) async {
  http.Response response = (await getDepartement());
  List<Departement> departements = [];

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    departements = data.map((json) => Departement.fromJson(json)).toList();
    providerDepartement.setDepartements(departements);
  } else {
    throw Exception('Failed to fetch departements');
  }
}

Future deleteUserController(
    BuildContext context, int id, int index, ProviderUser providerUser) async {
  http.Response response = (await deleteUser(id, providerUser.token!));
  List<User>? employes = providerUser.employes;

  if (response.statusCode == 200) {
    employes!.removeAt(index);
    providerUser.setEmployes(employes);
    Get.snackbar(
      'Utilisateur  est supprimé avec succès!',
      '', // Message
      backgroundColor: Colors.blue.shade700, // Background color
      colorText: Colors.white, // Text color
      snackPosition: SnackPosition.BOTTOM, // Position
      borderRadius: 10, // Border radius
      margin: const EdgeInsets.all(10), // Margin
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
      duration: const Duration(seconds: 5), // Duration
      animationDuration:
          const Duration(milliseconds: 400), // Animation duration
    );
  }
}

Future updateUserController(BuildContext context, User user, int index,
    ProviderUser providerUser) async {
  http.Response response = (await update(user, providerUser.token!));
  List<User>? employes = providerUser.employes;
  print(response.body);

  if (response.statusCode == 200) {
    print(response.statusCode);
    employes![index] = user;
    providerUser.setEmployes(employes);
    print(user.toJson());
    Get.snackbar(
      'Utilisateur  est modifié avec succès!',
      '', // Message
      backgroundColor: Colors.blue.shade700, // Background color
      colorText: Colors.white, // Text color
      snackPosition: SnackPosition.BOTTOM, // Position
      borderRadius: 10, // Border radius
      margin: const EdgeInsets.all(10), // Margin
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
      duration: const Duration(seconds: 5), // Duration
      animationDuration:
          const Duration(milliseconds: 400), // Animation duration
    );

    Navigator.of(context).pop();
  } else {
    print(response.statusCode);
  }
}

Future updateCurrentUserController(
    BuildContext context, User user, ProviderUser providerUser) async {
  http.Response response = (await update(user, providerUser.token!));
  List<User>? employes = providerUser.employes;
  print(response.body);

  if (response.statusCode == 200) {
    print(response.statusCode);

    // Update currentUser in ProviderUser
    providerUser.setCurrentUser(user);

    // Update the corresponding user in the employes list
    int index = employes!.indexWhere((emp) => emp.id == user.id);
    if (index != -1) {
      employes[index] = user;
    }

    // Notify listeners and show a snackbar
    providerUser.setEmployes(employes);
    Get.snackbar(
      'Utilisateur est modifié avec succès!',
      '', // Message
      backgroundColor: Colors.blue.shade700, // Background color
      colorText: Colors.white, // Text color
      snackPosition: SnackPosition.BOTTOM, // Position
      borderRadius: 10, // Border radius
      margin: const EdgeInsets.all(10), // Margin
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
      duration: const Duration(seconds: 5), // Duration
      animationDuration:
          const Duration(milliseconds: 400), // Animation duration
    );

    Navigator.of(context).pop();
  } else {
    print(response.statusCode);
  }
}

Future createUser(
    BuildContext context, User user, ProviderUser providerUser) async {
  final response =
      await create(user); // Assuming create method returns a response
  List<User>? employes = providerUser.employes;

  if (response.statusCode == 201) {
    // Successfully created user
    // Add the new user to the list
    employes!.add(user);
    providerUser.setEmployes(employes);

    Get.snackbar(
      '', // Title
      'Utilisateur créé avec succès!', // Message
      backgroundColor: const Color.fromRGBO(8, 65, 142, 1), // Background color
      colorText: Colors.white, // Text color
      snackPosition: SnackPosition.BOTTOM, // Position
      borderRadius: 10, // Border radius
      margin: const EdgeInsets.all(10), // Margin
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
      duration: const Duration(seconds: 3), // Duration
      animationDuration:
          const Duration(milliseconds: 300), // Animation duration
    );
  } else {
    // Failed to create user
    Get.snackbar(
      '', // Title
      "La création de l'utilisateur est échouée", // Message
      backgroundColor: const Color.fromRGBO(8, 65, 142, 1), // Background color
      colorText: Colors.white, // Text color
      snackPosition: SnackPosition.BOTTOM, // Position
      borderRadius: 10, // Border radius
      margin: const EdgeInsets.all(10), // Margin
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
      duration: const Duration(seconds: 3), // Duration
      animationDuration:
          const Duration(milliseconds: 300), // Animation duration
    );
  }
}

Future<void> logout(BuildContext context, ProviderUser providerUser) async {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) =>
            LoginScreen()), // Replace HomeScreen with your login screen
  );
  // Clear the token from the provider
  providerUser.settoken(null);

  // Navigate to the login screen
}
