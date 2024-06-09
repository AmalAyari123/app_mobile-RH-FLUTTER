import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import 'package:lottie/lottie.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/chef%20departement/list-demande.dart';
import 'package:myapp/chef%20departement/notification.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/notif.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/drawer.dart';
import 'package:myapp/solde.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class chefHome extends StatefulWidget {
  const chefHome({super.key});

  @override
  State<chefHome> createState() => _chefHomeState();
}

class _chefHomeState extends State<chefHome> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;

    List<Demande>? demandesD = providerUser.demandesD;

    User? currentUser = providerUser.currentUser;

    List<Demande>? todayDemandes = providerUser.todayDemandes;
    double progressValue2 = double.parse(
        ((currentUser!.solde1! + currentUser!.soldeConge!) /
                (21.0 + currentUser!.solde1!))
            .toStringAsFixed(1));

    int enAttenteCount =
        demandesD?.where((demande) => demande.status == "En Attente").length ??
            0;
    int teletravailCount = demandesD
            ?.where((demande) =>
                demande.status == "Accepté" && demande.type == "Télétravail")
            .length ??
        0;
    DateTime now = DateTime.now();

    // Format current date as "DD/MM/YYYY"
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 244, 244),
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.grey,
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 236, 233, 233),
            size: 30 // Set your desired color for the drawer icon
            ),
        backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 25,
              width: 22,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/page-1/images/brand.png',
                      ),
                      fit: BoxFit.contain)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8, right: 10),
              child: Text(
                'LeaveFlow',
                style: SafeGoogleFont(
                  'Rubik',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 244, 244, 245),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    // Reset the unread count
                    Future.microtask(() {
                      Provider.of<ProviderUser>(context, listen: false)
                          .resetUnreadCount();
                    });
                    return const ChefNotification();
                  }));
                },
              ),
              if (Provider.of<ProviderUser>(context).unreadCount > 0)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${Provider.of<ProviderUser>(context).unreadCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      key: _scaffoldKey,
      body: Container(
          height: MediaQuery.of(context).size.height - 170,
          margin: const EdgeInsets.only(top: 10),
          child: ListView(
            padding: const EdgeInsets.all(14),
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Bonjour',
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 8, 58, 108),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${currentUser!.name!}!',
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 135, 137, 140),
                    ),
                  ),
                ]),
                const Spacer(),
              ]),
              const SizedBox(height: 30),
              Card(
                color: Colors.white,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(children: [
                        // ignore: prefer_const_constructors
                        Text(
                          'Demandes de congés à traiter',
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 41, 41, 41),
                          ),
                        ),
                        const Spacer(),
                        const Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: Color.fromARGB(
                                  255, 41, 41, 41), // First checkmark color
                              size: 25,
                            ),
                            Positioned(
                              right: 6,
                              child: Icon(
                                Icons.check,
                                color: Color.fromARGB(
                                    255, 41, 41, 41), // Second checkmark color
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ]),
                      const SizedBox(height: 15),
                      Text(
                        '${enAttenteCount}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 64, 64, 64), // Text color
                          fontSize: 20, // Adjust font size as needed
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const ListDemande();
                          }));
                        },
                        child: Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey), // Grey border
                            borderRadius: BorderRadius.circular(
                                5), // Circular border radius
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Afficher le détail',
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 135, 137, 140),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(children: [
                        Text(
                          'En télétravail',
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 41, 41, 41),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Ionicons.home,
                          size: 25,
                          color: const Color.fromARGB(255, 41, 41,
                              41), // You can adjust the color as needed
                        ),
                      ]),
                      const SizedBox(height: 15),
                      Text(
                        '${teletravailCount}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 64, 64, 64), // Text color
                          fontSize: 20, // Adjust font size as needed
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Grey border
                          borderRadius: BorderRadius.circular(
                              5), // Circular border radius
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Afficher le détail',
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 135, 137, 140),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                  color: Colors.white,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Absent(s)',
                                style: SafeGoogleFont(
                                  'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(255, 41, 41, 41),
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "$formattedDate",
                                    style: SafeGoogleFont(
                                      'Roboto',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          const Color.fromARGB(255, 41, 41, 41),
                                    ),
                                  ),
                                  Icon(
                                    Icons.person,
                                    size: 25,
                                    color: Color.fromARGB(255, 41, 41, 41),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (todayDemandes != null && todayDemandes!.isEmpty)
                            Text(
                              "Aucune absence prévue.",
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 135, 137, 140),
                              ),
                            )
                          else if (todayDemandes != null &&
                              todayDemandes!.isNotEmpty)
                            SizedBox(
                              height: 100,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 12,
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: todayDemandes!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // Find the user whose ID matches demande.userId
                                  User? associatedUser = users?.firstWhere(
                                    (user) =>
                                        user.id == todayDemandes[index].userId,
                                    orElse: () => User(id: -1, name: 'Unknown'),
                                  );
                                  if (associatedUser != null &&
                                      associatedUser.id == currentUser?.id) {
                                    // If associatedUser is the currentUser, return an empty Container
                                    return Container();
                                  }

                                  // Display the user's name
                                  return Column(
                                    children: [
                                      Text(
                                        associatedUser?.name ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: DecorationImage(
                                                image: NetworkImage(associatedUser!
                                                            .avatarId !=
                                                        null
                                                    ? "http://192.168.1.13:3000/database-files/${associatedUser!.avatarId!}"
                                                    : 'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg'),
                                                fit: BoxFit.cover,
                                              ))),
                                    ],
                                  );
                                },
                              ),
                            ),
                        ]),
                  )),
              const SizedBox(height: 15),
              Card(
                color: Colors.white,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/page-1/images/count.png',
                                width: 30, height: 40),
                            const SizedBox(width: 12),
                            Text(
                              "Mon solde de congés payés ",
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 19, 20, 20),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            CircularPercentIndicator(
                              percent: progressValue2,
                              radius: 40,
                              lineWidth: 4,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor:
                                  const Color.fromARGB(255, 8, 58, 108),
                              backgroundColor: Colors.deepPurple.shade100,
                              center: Text(
                                " ${(progressValue2 * 100).toStringAsFixed(1)} %",
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 19, 20, 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 27),
                            Text(
                              "${currentUser!.solde1! + currentUser!.soldeConge!} jours à solder\n avant 31-12-2024",
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 135, 137, 140),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(children: [
                  Image.asset('assets/page-1/images/all.png',
                      width: 30, height: 40),
                  const SizedBox(width: 9),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const solde();
                      }));
                    },
                    child: Text(
                      " Voir mon solde total de congés  ",
                      style: SafeGoogleFont(
                        'Lato',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 19, 20, 20),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 30,
                    color: Color.fromARGB(255, 8, 58, 108),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
            ],
          )),
      drawer: const CustomDrawer(),
    );
  }
}
