import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/absence.dart';
import 'package:myapp/chef%20departement/accueill.dart';
import 'package:myapp/chef%20departement/chefAbsence.dart';
import 'package:myapp/chef%20departement/chefHistorique.dart';
import 'package:myapp/historique.dart';
import 'package:provider/provider.dart';

class MenuChefDepart extends StatefulWidget {
  int index;
  MenuChefDepart({super.key, required this.index});

  @override
  State<MenuChefDepart> createState() => _MenuChefDepartState();
}

class _MenuChefDepartState extends State<MenuChefDepart> {
  GlobalKey globalKeyHome = GlobalKey(debugLabel: 'btm_app_bar_home');
  late int _selectedTab;

  @override
  void initState() {
    _selectedTab = widget.index;

    super.initState();
  }

  Widget startTimer() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: SpinKitFadingFour(
        duration: Duration(seconds: 15),
        color: Color.fromRGBO(8, 65, 142, 1),
        size: 60.0, // Customize spinner size
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();

    return WillPopScope(
      onWillPop: () async {
        return false; // Bloquer le retour à la page précédente
      },
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 75,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            )),
            child: BottomNavigationBar(
              key: globalKeyHome,
              currentIndex: _selectedTab,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color.fromRGBO(8, 65, 142, 1),
              unselectedItemColor: Colors.grey[500],
              onTap: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined, size: 30),
                    label: 'Accueil'),
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
            ),
          ),
        ),
        body: Stack(
          children: [
            renderView(0, const chefHome()),
            renderView(1, const chefAbsence()),
            renderView(2, const chefHistorique()),
          ],
        ),
      ),
    );
  }

  Widget renderView(int tabIndex, Widget view) {
    return IgnorePointer(
      ignoring: _selectedTab != tabIndex,
      child: Opacity(
        opacity: _selectedTab == tabIndex ? 1 : 0,
        child: view,
      ),
    );
  }
}
