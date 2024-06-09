import 'package:myapp/Controller/providerUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/Model/autorisation.dart';
import 'package:myapp/Model/autorisation.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/env.dart';

Future<http.Response> getAutorisation(String token) async {
  var url = Uri.parse('http://${ipadress}:3000/Autorisation');

  final client = http.Client();

  var response = await client.get(
    url,
    headers: {
      "Content-type": "application/json",
      'Authorization': 'Bearer $token',
    },
  );
  client.close();
  return response;
}

Future getAutorisationController(
  ProviderUser providerUser,
) async {
  print("get autorisation");

  http.Response response = (await getAutorisation(providerUser.token!));
  List<Autorisation> autorisations = [];

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    autorisations = data.map((json) => Autorisation.fromJson(json)).toList();
    providerUser.setAutorisation(autorisations);
  } else {
    throw Exception('Failed to fetch users');
  }
}

Future<http.Response> updateAutorisationStatus(
    String newStatus, Autorisation autorisation, String token) async {
  var url = Uri.parse(
      'http://${ipadress}:3000/Autorisation/${autorisation.id}/status');

  final client = http.Client();

  var response = await client.patch(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the auth token here
      },
      body: jsonEncode({'status': newStatus}));
  client.close();
  return response;
}

Future updateAutorisationController(
    BuildContext context,
    Autorisation autorisation,
    int index,
    ProviderUser providerUser,
    User user,
    String newStatus) async {
  print("update autorisation");

  http.Response response = (await updateAutorisationStatus(
      newStatus, autorisation, providerUser.token!));
  List<Autorisation>? autorisations = providerUser.autorisations;
  print(response.body);

  if (response.statusCode == 200) {
    print(response.statusCode);
    autorisations![index] = autorisation;
    providerUser.setAutorisation(autorisations);
    print(autorisation.toJson());
  } else {
    print(response.statusCode);
  }
}

Future<http.Response> createAutorisation(
    Autorisation autorisation, String token) async {
  var url = Uri.parse('http://${ipadress}:3000/Autorisation');

  final client = http.Client();
  Map<String, dynamic> requestBody = autorisation.toJson();
  requestBody['heureDebut'] = autorisation.heureDebut!.toIso8601String();
  requestBody['heureFin'] = autorisation.heureFin!.toIso8601String();

  var response = await client.post(
    url,
    body: jsonEncode(requestBody),
    headers: {
      'Authorization': 'Bearer $token',
      "Content-type": "application/json"
    },
  );
  print(autorisation.toJson());
  client.close();
  return response;
}

Future createAutorisationController(BuildContext context,
    Autorisation autorisation, ProviderUser providerUser) async {
  print("create autorisation");

  final response = await createAutorisation(autorisation, providerUser.token!);
  List<Autorisation>? autorisations = providerUser.autorisations ?? [];

  if (response.statusCode == 201) {
    autorisations!.add(autorisation);
    providerUser.setAutorisation(autorisations);

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
