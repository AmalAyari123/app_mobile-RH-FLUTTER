import 'package:flutter/material.dart';
import 'package:myapp/Controller/notifController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/notification.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/historique.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

class Notif extends StatefulWidget {
  const Notif({super.key});

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    User? currentUser = providerUser.currentUser;

    List<AppNotification>? notif = providerUser.notif;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.grey[500],
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
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              )),
          elevation: 6,
          shadowColor: Colors.grey,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
          centerTitle: true,
          title: Text(
            "Notifications",
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.transparent)),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.white,
                    indicator: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 247, 248),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelColor: const Color.fromRGBO(8, 65, 142, 1),
                    indicatorWeight: 2,
                    labelStyle: const TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    tabs: const [
                      Tab(text: 'Tout'),
                      Tab(text: 'Non lu'),
                    ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 260,
              child: TabBarView(children: [
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 4,
                    );
                  },
                  itemCount: notif?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            255, 249, 247, 247), // Set the background color
                        border: Border.all(
                            color: const Color.fromARGB(
                                255, 255, 255, 255)), // Set the border color
                        borderRadius:
                            BorderRadius.circular(5), // Set border radius
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: ListTile(
                        title: Text(
                          notif?[index].title ?? '',
                          style: SafeGoogleFont(
                            'Lato',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            if (notif?[index].body?.contains('accepté') ??
                                false) ...[
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                  width:
                                      8), // Adds some space between the icon and the text
                            ] else if (notif?[index].body?.contains('refusé') ??
                                false) ...[
                              const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                  width:
                                      8), // Adds some space between the icon and the text
                            ],
                            Expanded(
                              child: Text(
                                notif?[index].body ?? '',
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 26, 26, 27),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Text('aa')
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
