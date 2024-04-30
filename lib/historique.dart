import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();

    List<Demande>? demandes = providerUser.demandes;
    getDemandeController(providerUser);
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              )),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
          centerTitle: true,
          title: Text(
            "Historique des demandes",
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
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
                  size: 35,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: MediaQuery.of(context).size.height - 177,
              margin: const EdgeInsets.only(top: 5),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 4,
                    );
                  },
                  itemCount: demandes?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 237, 235, 235), // Set the background color
                        border: Border.all(
                            color: const Color.fromARGB(
                                255, 255, 255, 255)), // Set the border color
                        borderRadius:
                            BorderRadius.circular(5), // Set border radius
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 2,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Du ${DateFormat('yyyy-MM-dd HH:mm', 'en_US').format(demandes?[index].dateDebut ?? DateTime.now())} \nAu ${DateFormat('yyyy-MM-dd HH:mm').format(demandes?[index].dateFin ?? DateTime.now())}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          demandes?[index].status ?? '',
                          style: SafeGoogleFont(
                            'Lato',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ]),
        ));
  }
}
