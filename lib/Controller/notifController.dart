import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/notification.dart';
import 'package:myapp/admin/env.dart';

Future<void> sendPushNotification(int userId, String title, String body) async {
  try {
    var response = await http.post(
      Uri.parse('http://${ipadress}:3000/notifications/send-push'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      print('Notification sent successfully');
    } else {
      throw Exception('Failed to send notification');
    }
  } catch (e) {
    print('Error sending notification: $e');
  }
}

Future<void> getNotifController(ProviderUser providerUser, int id) async {
  http.Response response = await getNotif(id);
  List<AppNotification> newNotif = [];

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    newNotif = data.map((json) => AppNotification.fromJson(json)).toList();
    // Set notifications and reset unread count
    providerUser.setNotif(newNotif);
  } else {
    throw Exception('Failed to fetch notifications');
  }
}

Future<http.Response> getNotif(int id) async {
  var url = Uri.parse('http://${ipadress}:3000/notifications/$id');

  final client = http.Client();

  var response = await client.get(
    url,
  );
  client.close();
  return response;
}
