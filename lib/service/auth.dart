// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:myapp/admin/env.dart';

Future<http.Response> authUser(String email, String password) async {
  var url = Uri.parse("http://${ipadress}:3000/auth/login");
  Map<String, String> requestBody = {
    'email': email,
    'password': password,
  };
  String requestBodyJson = jsonEncode(requestBody);
  final client = http.Client();
  var response = await client.post(
    url,
    body: requestBodyJson,
    headers: {"Content-type": "application/json"},
  );
  client.close();
  return response;
}
