import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/logiin.dart';
import 'package:myapp/profile.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/Authorisation.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    User? currentUser = providerUser.currentUser;
    ProviderDepartement providerDepartement =
        context.watch<ProviderDepartement>();
    getDepartementsController(providerDepartement);

    getUsersController(providerUser);
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(
                234, 228, 228, 1)), // Customize the background color
        child: ListView(children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(234, 228, 228, 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/page-1/images/amal.jpg')) // Change the color as needed
                          )),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Amal Ayari',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 77, 76, 76),
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Ionicons.pencil_outline,
                color: Color.fromARGB(255, 77, 76, 76)),
            title: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return UpdateProfile(currentuser: currentUser!);
                }));
              },
              child: Text(
                'Modifier le profil',
                style: SafeGoogleFont('Lato',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 77, 76, 76)),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Ionicons.add,
                color: Color.fromARGB(255, 77, 76, 76)),
            title: Text(
              'Déclarer des jours sup.',
              style: SafeGoogleFont(
                'Lato',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 77, 76, 76),
              ),
            ),
            onTap: () {
              // Handle home item tap
              Navigator.pop(context); // Close the drawer
            },
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Ionicons.time_sharp,
                color: Color.fromARGB(255, 77, 76, 76)),
            title: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Authorisation();
                }));
              },
              child: Text(
                'Autorisation',
                style: SafeGoogleFont('Lato',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 77, 76, 76)),
              ),
            ),
            onTap: () {
              // Handle home item tap
              Navigator.pop(context); // Close the drawer
            },
          ),
          const SizedBox(height: 40),
          ListTile(
            leading: const Icon(Ionicons.log_out_outline,
                color: Color.fromARGB(255, 77, 76, 76)),
            title: Text(
              'Se deconnecter',
              style: SafeGoogleFont(
                'Lato',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 77, 76, 76),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ); // Close the drawer
            },
          ),
        ]),
      ),
    );
  }
}
