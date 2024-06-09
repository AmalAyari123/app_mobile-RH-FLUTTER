import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/env.dart';

import 'package:myapp/service/demandeService.dart';
import 'dart:async';

Future getDemandeController(
  ProviderUser providerUser,
) async {
  print("get demande");

  if (providerUser.token == null) {
    print('token is null');
  }
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
  print("get depart departement");

  if (providerUser.token == null) {
    print('token is null');
  }
  http.Response response =
      (await getDemandebyDepartement(providerUser.token ?? ''));
  List<Demande> demandesD = [];
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    demandesD = data.map((json) => Demande.fromJson(json)).toList();
    List<Demande> todayDemandes = demandesD != null
        ? demandesD!.where((demande) {
            // Check if formattedDate is within the interval defined by dateDebut and dateFin
            return (demande.dateDebut != null &&
                    demande.dateFin != null &&
                    demande.dateDebut!
                        .isBefore(DateTime.parse(formattedDate)) &&
                    demande.dateFin!.isAfter(DateTime.parse(formattedDate))) ||
                // Include cases where formattedDate is equal to dateDebut or dateFin
                (DateFormat('yyyy-MM-dd').format(demande.dateDebut!) ==
                        formattedDate ||
                    DateFormat('yyyy-MM-dd').format(demande.dateFin!) ==
                        formattedDate);
          }).toList()
        : [];
    providerUser.setDemandeD(demandesD);
    providerUser.setDemandeToday(todayDemandes);
  } else {
    throw Exception('Failed to fetch users');
  }
}

Future updateDemandeController(BuildContext context, Demande demande, int index,
    ProviderUser providerUser, User user) async {
  print("update demande");

  http.Response response = (await updateDemande(demande, providerUser.token!));
  List<Demande>? demandes = providerUser.demandes;
  print(response.body);

  if (response.statusCode == 200) {
    Navigator.of(context).pop();
    print(response.statusCode);
    demandes![index] = demande;
    providerUser.setDemande(demandes);
    print(demande.toJson());
  } else {
    print(response.statusCode);
  }
}

Future updateDemandeChefController(BuildContext context, Demande demande,
    int index, ProviderUser providerUser, User user) async {
  print("update demande");

  http.Response response = (await updateDemande(demande, providerUser.token!));
  List<Demande>? demandesD = providerUser.demandesD;
  print(response.body);

  if (response.statusCode == 200) {
    Navigator.of(context).pop();
    print(response.statusCode);
    demandesD![index] = demande;
    providerUser.setDemandeD(demandesD);
  } else {
    print(response.statusCode);
  }
}

Future updateSolde(BuildContext context, int index, ProviderUser providerUser,
    User user, Demande demande) async {
  print("update solde");

  http.Response response =
      (await updateSoldee(user, providerUser.token!, demande));
  List<User>? employes = providerUser.employes;
  print(response.body);

  if (response.statusCode == 200) {
    print(response.statusCode);
    employes![index] = user;
    providerUser.setEmployes(employes);
    print(user.toJson());
  } else {
    print(response.statusCode);
  }
}

Future<http.Response> updateSoldee(
    User user, String token, Demande demande) async {
  print("update solde");

  var url = Uri.parse(
      'http://${ipadress}:3000/users/${user.id}/calculate-solde/${demande.id}');

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

Future updateSoldeMaladieController(BuildContext context, int index,
    ProviderUser providerUser, User user, Demande demande) async {
  print("update solde maladie");

  try {
    http.Response response =
        (await updateSoldeMaladie(user, providerUser.token!, demande));
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
  } catch (e) {
    if (e is http.ClientException) {
      // Handle client-side exceptions
      if (e.message.contains('solde maladie insuffisant')) {
        // Display a message indicating insufficiency of solde maladie
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text('votre Solde de  maladie est insuffisant!'),
          ),
        );
      } else if (e.message.contains("vous n'avez plus de solde maladie")) {
        // Display a message indicating absence of solde maladie
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vous n\'avez plus de solde maladie!'),
          ),
        );
      }
    } else {
      // Handle other types of exceptions
      print('An unexpected error occurred: $e');
    }
  }
}

Future<http.Response> updateSoldeMaladie(
    User user, String token, Demande demande) async {
  var url = Uri.parse(
      'http://${ipadress}:3000/users/${user.id}/maladie/${demande.id}');

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

Future updateSoldeRecController(BuildContext context, int index,
    ProviderUser providerUser, User user, Demande demande) async {
  print("update solde rec");

  try {
    http.Response response =
        (await updateSoldeRec(user, providerUser.token!, demande));
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
  } catch (e) {
    if (e is http.ClientException) {
      // Handle client-side exceptions
      if (e.message.contains('solde maladie insuffisant')) {
        // Display a message indicating insufficiency of solde maladie
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text('votre Solde de  maladie est insuffisant!'),
          ),
        );
      } else if (e.message.contains("vous n'avez plus de solde maladie")) {
        // Display a message indicating absence of solde maladie
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vous n\'avez plus de solde maladie!'),
          ),
        );
      }
    } else {
      // Handle other types of exceptions
      print('An unexpected error occurred: $e');
    }
  }
}

Future<http.Response> updateSoldeRec(
    User user, String token, Demande demande) async {
  var url =
      Uri.parse('http://${ipadress}:3000/users/${user.id}/rec/${demande.id}');

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
  print("create demande");

  if (providerUser.token == null) {
    // Handle the case where providerUser.token is null
    print('Token is null. Unable to create demande.');
    return;
  }
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
    print(response.statusCode);
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

Future deleteDemandeController(
    BuildContext context, int id, int index, ProviderUser providerUser) async {
  print("delete demande");

  http.Response response = (await deleteDemande(id));
  List<Demande>? demandes = providerUser.demandes;

  if (response.statusCode == 200) {
    demandes!.removeAt(index);
    providerUser.setDemande(demandes);
    Get.snackbar(
      'Demande est annulée avec succès!',
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
