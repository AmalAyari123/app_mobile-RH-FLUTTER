// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controller/autorisationController.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/notifController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/accueil.dart';
import 'package:myapp/admin/env.dart';
import 'package:myapp/chef%20departement/menuChefDepart.dart';
import 'package:myapp/chef%20departement/accueill.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/service/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationUser {
  Future authentification(
    String email,
    String password,
    BuildContext context,
    ProviderUser providerUser,
  ) async {
    http.Response response = (await authUser(email, password));
    if (response.statusCode == 201) {
      print(response.statusCode);
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String accessToken = responseData['accessToken'];
      providerUser.settoken(accessToken);
      final String userRole = responseData[
          'userrole']; // Assuming the role is returned from the server

      String? notificationToken = await FirebaseMessaging.instance.getToken();
      final int id = responseData['id'];

      // Send notification token and user ID to backend route '/save-info'
      await sendUserInfoToBackend(id, notificationToken, 'ACTIVE');

      if (userRole == 'Admin') {
        User currentUser = User.fromJson(responseData);
        providerUser.setCurrentUser(currentUser);
        getDemandebyDepartementController(providerUser);
        getUsersController(providerUser);
        getDemandeController(providerUser);
        getNotifController(providerUser, currentUser!.id!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Accueil(),
          ),
        );
      }
      if (userRole == 'Employé') {
        User currentUser = User.fromJson(responseData);
        providerUser.setCurrentUser(currentUser);
        getDemandebyDepartementController(providerUser);
        getUsersController(providerUser);
        getDemandeController(providerUser);
        getNotifController(providerUser, currentUser!.id!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Homee(),
          ),
        );
      }
      if (userRole == 'Chef département') {
        getUsersController(providerUser);
        getDemandebyDepartementController(providerUser);
        getDemandeController(providerUser);
        getAutorisationController(providerUser);

        User currentUser = User.fromJson(responseData);
        providerUser.setCurrentUser(currentUser);
        getNotifController(providerUser, currentUser!.id!);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuChefDepart(index: 0),
          ),
        );
      }
    } else {
      print('Response status code: ${response.statusCode}');

      Get.snackbar(
        'Se connecter', // Title
        'Veuillez vérifier vos informations', // Message
        backgroundColor:
            const Color.fromRGBO(8, 65, 142, 1), // Background color
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
}

Future<void> sendUserInfoToBackend(
    int? userId, String? notificationToken, String? status) async {
  try {
    final url = Uri.parse('http://${ipadress}:3000/notifications/save-info');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userId': userId,
        'notificationToken': notificationToken,
        'status': status,
      }),
    );

    if (response.statusCode == 201) {
      print('User info sent to backend successfully');
    } else {
      print('Failed to send user info to backend');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error sending user info to backend: $error');
  }
}
