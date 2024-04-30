import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/env.dart';

import 'package:myapp/service/demandeService.dart';
import 'dart:async';

Future getDemandeController(
  ProviderUser providerUser,
) async {
  http.Response response = (await getDemande(providerUser.token!));
  List<Demande> demandes = [];

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    demandes = data.map((json) => Demande.fromJson(json)).toList();
    providerUser.setDemande(demandes);
  } else {
    throw Exception('Failed to fetch users');
  }
}

Future getDemandebyDepartementController(
  ProviderUser providerUser,
) async {
  if (providerUser.token == null) {
    print('token is null');
  }
  http.Response response =
      (await getDemandebyDepartement(providerUser.token ?? ''));
  List<Demande> demandesD = [];

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    demandesD = data.map((json) => Demande.fromJson(json)).toList();
    providerUser.setDemandeD(demandesD);
  } else {
    throw Exception('Failed to fetch users');
  }
}

Future updateDemandeController(BuildContext context, Demande demande, int index,
    ProviderUser providerUser, User user) async {
  http.Response response = (await updateDemande(demande, providerUser.token!));
  List<Demande>? demandes = providerUser.demandes;
  print(response.body);

  if (response.statusCode == 200) {
    print(response.statusCode);
    demandes![index] = demande;
    providerUser.setDemande(demandes);
    print(demande.toJson());
  } else {
    print(response.statusCode);
  }
}

Future updateSolde(BuildContext context, int index, ProviderUser providerUser,
    User user) async {
  http.Response response = (await updateSoldee(user, providerUser.token!));
  List<User>? employes = providerUser.employes;
  print(response.body);

  if (response.statusCode == 200) {
    print(response.statusCode);
    employes![index] = user;
    providerUser.setEmployes(employes);
    print(user.toJson());

    Navigator.of(context).pop();
  } else {
    print(response.statusCode);
  }
}

Future<http.Response> updateSoldee(User user, String token) async {
  var url = Uri.parse('http://${ipadress}:3000/users/${user.id}/solde');

  final client = http.Client();

  var response = await client.patch(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the auth token here
    },
  );
  client.close();
  return response;
}

Future createDemandeController(
    BuildContext context, Demande demande, ProviderUser providerUser) async {
  final response = await createDemande(demande, providerUser.token!);
  List<Demande>? demandes = providerUser.demandes ?? [];

  if (response.statusCode == 201) {
    demandes!.add(demande);
    providerUser.setDemande(demandes);

    Get.snackbar(
      '',
      'Votre demande est envoyée avec succès!', // Message
      backgroundColor: const Color.fromRGBO(8, 65, 142, 1), // Background color
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
    // Failed to create user
    Get.snackbar(
      '', // Title
      "Vérifier vos informations!", // Message
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
