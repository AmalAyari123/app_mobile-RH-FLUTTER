import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/Model/demande.dart';
import 'dart:async';

import 'package:myapp/admin/env.dart';

Future<http.Response> getDemande(String token) async {
  var url = Uri.parse('http://${ipadress}:3000/demande');

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

Future<http.Response> getDemandebyDepartement(String token) async {
  var url = Uri.parse('http://${ipadress}:3000/demande/Z');

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

Future<http.Response> updateDemande(Demande demande, String token) async {
  var url = Uri.parse('http://${ipadress}:3000/demande/${demande.id}');

  final client = http.Client();

  var response = await client.patch(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the auth token here
      },
      body: jsonEncode(demande.toJson()));

  client.close();
  return response;
}

Future<http.Response> createDemande(Demande demande, String token) async {
  var url = Uri.parse('http://${ipadress}:3000/demande');

  final client = http.Client();
  Map<String, dynamic> requestBody = demande.toJson();
  requestBody['dateDebut'] = demande.dateDebut!.toIso8601String();
  requestBody['dateFin'] = demande.dateFin!.toIso8601String();

  var response = await client.post(
    url,
    body: jsonEncode(requestBody),
    headers: {
      'Authorization': 'Bearer $token',
      "Content-type": "application/json"
    },
  );
  print(demande.toJson());
  client.close();
  return response;
}
