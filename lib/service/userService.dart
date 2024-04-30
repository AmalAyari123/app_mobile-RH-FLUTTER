// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/env.dart';

Future<http.Response> getUsers() async {
  var url = Uri.parse('http://${ipadress}:3000/users');

  final client = http.Client();

  var response = await client.get(
    url,
  );
  client.close();
  return response;
}

Future<http.Response> getDepartement() async {
  var url = Uri.parse('http://${ipadress}:3000/departement');

  final client = http.Client();

  var response = await client.get(
    url,
  );
  client.close();
  return response;
}

Future<http.Response> deleteUser(int id, String token) async {
  var url = Uri.parse('http://${ipadress}:3000/users/$id');

  final client = http.Client();

  var response = await client.delete(
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the auth token here
    },
    url,
  );
  client.close();
  return response;
}

Future<http.Response> update(User user, String token) async {
  var url = Uri.parse('http://${ipadress}:3000/users/${user.id}');

  final client = http.Client();

  var response = await client.patch(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the auth token here
      },
      body: jsonEncode(user.toJson()));

  client.close();
  return response;
}

Future<http.Response> create(User user) async {
  var url = Uri.parse('http://${ipadress}:3000/users');

  final client = http.Client();
  // Convert the user object to a JSON Map
  Map<String, dynamic> requestBody = user.toJson();
  // Add the departementId to the request body
  /*requestBody['DepartmentId'] = user.DepartmentId;*/

  var response = await client.post(
    url,
    body: jsonEncode(requestBody),
    headers: {"Content-type": "application/json"},
  );
  print(user.toJson());
  client.close();
  return response;
}
