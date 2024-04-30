// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/accueil.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/service/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthentificationUser {
  Future authentification(
    String email,
    String password,
    BuildContext context,
    ProviderUser providerUser,
  ) async {
    http.Response response = (await authUser(email, password));
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String accessToken = responseData['accessToken'];

      providerUser.settoken(accessToken);
      final String userRole = responseData[
          'userrole']; // Assuming the role is returned from the server

      if (userRole == 'Admin') {
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

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Homee(),
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
