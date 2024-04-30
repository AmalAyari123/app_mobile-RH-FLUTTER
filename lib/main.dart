import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/admin/accueil.dart';
import 'package:myapp/admin/calendar.dart';
import 'package:myapp/logiin.dart';
import 'package:myapp/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProviderDepartement()),
    ChangeNotifierProvider(create: (context) => ProviderUser()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: Splash());
  }
}
