import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lottie/lottie.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/notifController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/notification.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/notif.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/drawer.dart';
import 'package:myapp/solde.dart';
import 'package:myapp/widgets/envv.dart';
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
    List<User>? users = providerUser.employes;

    List<Demande>? demandesD = providerUser.demandesD;

    User? currentUser = providerUser.currentUser;

    List<AppNotification>? notif = providerUser.notif;

    DateTime now = DateTime.now();

    // Filter demandesD to find demandes with dateDebut or dateFin equal to today's date
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
// Filter demandes based on formattedDate
    List<Demande> todayDemandes = demandesD != null
        ? demandesD!.where((demande) {
            // Check if formattedDate is within the interval defined by dateDebut and dateFin
            return (demande.dateDebut != null &&
                    demande.dateFin != null &&
                    demande.dateDebut!
                        .isBefore(DateTime.parse(formattedDate)) &&
                    demande.dateFin!.isAfter(DateTime.parse(formattedDate))) ||
                // Include cases where formattedDate is equal to dateDebut or dateFin
                (DateFormat('yyyy-MM-dd').format(demande.dateDebut!) ==
                        formattedDate ||
                    DateFormat('yyyy-MM-dd').format(demande.dateFin!) ==
                        formattedDate);
          }).toList()
        : [];
    print(todayDemandes.length);
    double progressValue2 =
        ((currentUser?.solde1 ?? 0) + (currentUser?.soldeConge ?? 0)) /
            (21.0 + (currentUser?.solde1 ?? 0));

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
                    return const Notif();
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
                    currentUser != null && currentUser.name != null
                        ? '${currentUser.name}!'
                        : '',
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
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
                          const SizedBox(height: 12),
                          if (todayDemandes.length == 0)
                            Text(
                              "Aucune absence prévue.",
                              style: SafeGoogleFont(
                                'Lato',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 135, 137, 140),
                              ),
                            )
                          else
                            SizedBox(
                              height: 93,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: todayDemandes.length,
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
                                      const SizedBox(height: 10),
                                      Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: DecorationImage(
                                                image: NetworkImage(associatedUser!
                                                            .avatarId !=
                                                        null
                                                    ? "http://$ipadressurl/database-files/${associatedUser.avatarId!}"
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
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
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
                                "${(progressValue2 * 100).toStringAsFixed(1)} %",
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
