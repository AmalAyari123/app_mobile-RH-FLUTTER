import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/notif.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/drawer.dart';
import 'package:myapp/solde.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    getDemandeController(providerUser);

    getDemandebyDepartementController(providerUser);
    User? currentUser = providerUser.currentUser;
    return Scaffold(
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
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const Notif();
              }));
            },
          ),
        ],
      ),
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.3),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromRGBO(8, 65, 142, 1),
          unselectedItemColor: Colors.grey[500],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                size: 40,
                color: Color.fromRGBO(8, 65, 142, 1),
              ),
              label: 'Congés',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                size: 30,
              ),
              label: 'Historique',
            ),
          ],
          onTap: (index) {
            // Handle navigation based on the selected index
            setState(() {
              _currentIndex = index;
            });

            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homee()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Absencee()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Historique()),
              );
            }
          },
        ),
      ),
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
              Container(
                padding: const EdgeInsets.all(10),
                width: 50.0,
                height: 120.0,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 253, 253),
                ),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 37),
                      Text(
                        'Que la planification de\nvos congés commence! ',
                        style: SafeGoogleFont(
                          'Lato',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 19, 20, 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12.8),
                  LottieBuilder.asset(
                    'assets/page-1/images/aa.json',
                    width: 138,
                    fit: BoxFit.cover,
                  ),
                ]),
              ),
              const SizedBox(height: 40),
              Card(
                  color: Colors.white,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/page-1/images/team.png',
                                width: 30, height: 40),
                            const SizedBox(width: 11),
                            Text(
                              "Absence dans mon équipe aujourd'hui ",
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 19, 20, 20),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Aucune absence prévue.",
                          style: SafeGoogleFont(
                            'Lato',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 135, 137, 140),
                          ),
                        ),
                        const SizedBox(height: 26)
                      ])),
              const SizedBox(height: 15),
              Card(
                color: Colors.white,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/page-1/images/count.png',
                              width: 30, height: 40),
                          const SizedBox(width: 12),
                          Text(
                            "Mon solde de congés ",
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
                            radius: 50,
                            lineWidth: 6,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: 0.5,
                            progressColor:
                                const Color.fromARGB(255, 8, 58, 108),
                            backgroundColor: Colors.deepPurple.shade100,
                            center: Text(
                              "50%",
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 19, 20, 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 27),
                          Text(
                            "${currentUser!.solde1! + currentUser!.soldeConge!} jours valables\n jusqu'à 31-12-2024",
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
