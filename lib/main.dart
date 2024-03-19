import 'package:flutter/material.dart';
import 'package:myapp/provider/accountDetails.dart';
import 'package:myapp/resum.dart';
import 'package:myapp/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AccountDetails()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
  }
}
