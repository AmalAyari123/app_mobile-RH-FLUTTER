// ignore_for_file: file_names

import 'dart:convert';

import 'package:myapp/service/auth.dart';
import 'package:http/http.dart' as http;

class AuthentificationUser {
  Future<void> authentification(
    String email,
    String password,
  ) async {
    print("controller");
    http.Response response = (await authUser(email, password));
    var responseBody = json.decode(response.body);
    print(responseBody);
  }
}
