import 'package:flutter/material.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Model/autorisation.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/chef%20departement/demandeDetail.dart';
import 'package:myapp/chef%20departement/menuChefDepart.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/envv.dart';
import 'package:provider/provider.dart';

class ListDemande extends StatefulWidget {
  const ListDemande({super.key});

  @override
  State<ListDemande> createState() => _ListDemandeState();
}

class _ListDemandeState extends State<ListDemande> {
  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;

    List<Demande>? demandesD = providerUser.demandesD;
    int enAttenteCount =
        demandesD?.where((demande) => demande.status == "En Attente").length ??
            0;

    User? currentUser = providerUser.currentUser;

    List<Autorisation>? autorisations = providerUser.autorisations;
    int enAttenteCountAuth = autorisations
            ?.where((autorisation) => autorisation.status == "En Attente")
            .length ??
        0;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: YourAppBar(),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(0),
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
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      tabs: const [
                        Tab(text: 'Les congés'),
                        Tab(text: 'Les autorisations'),
                      ]),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 160,
                child: TabBarView(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Demandes à traiter",
                                  style: SafeGoogleFont(
                                    'Lato',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        const Color.fromARGB(255, 31, 31, 31),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 40,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 158, 197, 228),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 18,
                                      top: 7), // Adjust padding as needed
                                  child: Text(
                                    '$enAttenteCount',
                                    style: const TextStyle(
                                      color: Colors.white, // Text color
                                      fontSize:
                                          16, // Adjust font size as needed
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 1.5,
                              width: double
                                  .infinity, // Takes the full width available
                              color: const Color.fromARGB(255, 232, 228, 228),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: MediaQuery.of(context).size.height - 247,
                              margin: const EdgeInsets.only(top: 5),
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 4,
                                    );
                                  },
                                  itemCount: demandesD?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    User? associatedUser = users?.firstWhere(
                                      (user) =>
                                          user.id == demandesD![index].userId &&
                                          user.id != currentUser?.id,
                                      orElse: () =>
                                          User(id: -1, name: 'Unknown'),
                                    );

                                    // If associatedUser is the placeholder 'Unknown', skip this item
                                    if (associatedUser?.id == -1) {
                                      return const SizedBox.shrink();
                                    }
                                    return Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255,
                                              244,
                                              242,
                                              242), // Set the background color
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255,
                                                  255,
                                                  255,
                                                  255)), // Set the border color
                                          borderRadius: BorderRadius.circular(
                                              10), // Set border radius
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 2,
                                            ),
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Text(
                                                associatedUser?.name ?? '',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                              radius:
                                                  30, // Adjust the radius to your desired size
                                              backgroundImage: NetworkImage(
                                                  associatedUser?.avatarId !=
                                                          null
                                                      ? "http://$ipadressurl/database-files/${associatedUser?.avatarId!}"
                                                      : 'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg'),
                                            ),
                                            subtitle: Row(
                                              children: [
                                                _buildStatusIndicator(
                                                    demandesD?[index].status),
                                                const SizedBox(width: 5),
                                                Text(
                                                  demandesD?[index].status ??
                                                      '',
                                                  style: SafeGoogleFont(
                                                    'Lato',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: IconButton(
                                              icon: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color.fromARGB(
                                                    255, 96, 119, 139),
                                                size: 18,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return DemandeChef(
                                                    user: associatedUser!,
                                                    index: index,
                                                    demande: demandesD![index],
                                                  );
                                                }));
                                              },
                                            )));
                                  }),
                            )
                          ])),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Demandes à traiter",
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromARGB(255, 31, 31, 31),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 40,
                                width: 45,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 158, 197, 228),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 18,
                                    top: 7), // Adjust padding as needed
                                child: Text(
                                  '$enAttenteCountAuth',
                                  style: const TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 16, // Adjust font size as needed
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 1.5,
                            width: double
                                .infinity, // Takes the full width available
                            color: const Color.fromARGB(255, 232, 228, 228),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: MediaQuery.of(context).size.height - 247,
                            margin: const EdgeInsets.only(top: 5),
                            child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 4,
                                  );
                                },
                                itemCount: autorisations?.length ?? 0,
                                itemBuilder: (context, index) {
                                  User? associatedUser = users?.firstWhere(
                                    (user) =>
                                        user.id ==
                                            autorisations![index].userId &&
                                        user.id != currentUser?.id,
                                    orElse: () => User(id: -1, name: 'Unknown'),
                                  );

                                  // If associatedUser is the placeholder 'Unknown', skip this item
                                  if (associatedUser?.id == -1) {
                                    return const SizedBox.shrink();
                                  }
                                  return Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255,
                                            244,
                                            242,
                                            242), // Set the background color
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255,
                                                255,
                                                255,
                                                255)), // Set the border color
                                        borderRadius: BorderRadius.circular(
                                            10), // Set border radius
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 2,
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            associatedUser?.name ?? '',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          radius:
                                              30, // Adjust the radius to your desired size
                                          backgroundImage: NetworkImage(associatedUser
                                                      ?.avatarId !=
                                                  null
                                              ? "http://$ipadressurl/database-files/${associatedUser?.avatarId!}"
                                              : 'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg'),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            _buildStatusIndicator(
                                                autorisations?[index].status),
                                            const SizedBox(width: 5),
                                            Text(
                                              autorisations?[index].status ??
                                                  '',
                                              style: SafeGoogleFont(
                                                'Lato',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                }),
                          )
                        ]),
                  ),
                ]),
              ),
            ])));
  }
}

Widget _buildStatusIndicator(String? status) {
  Color color;
  switch (status) {
    case 'Accepté':
      color = const Color.fromARGB(255, 72, 211, 76);
      break;
    case 'Accepté par le chef dép':
      color = Color.fromARGB(255, 238, 255, 0);
      break;
    case 'En Attente':
      color = Colors.blue;
      break;
    case 'Refusé':
      color = Colors.red;
      break;
    default:
      color = Colors.transparent;
      break;
  }

  return Container(
    width: 15,
    height: 15,
    margin: const EdgeInsets.only(right: 8.0), // Adjust margin as needed
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
  );
}

class YourAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  _YourAppBarState createState() => _YourAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _YourAppBarState extends State<YourAppBar> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Disable automatic leading widget
      backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
      elevation: 3,
      shadowColor: const Color.fromARGB(255, 193, 191, 191),
      centerTitle: true,
      leading: !_isSearching
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            )
          : null, // No leading icon when searching
      title: _isSearching
          ? Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: 1,
                ),
              ),
              child: TextField(
                key: const Key('__searchTextField__'),
                controller: widget._textEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintText: 'Cherchez par nom ou prénom',
                  hintStyle: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      widget._textEditingController.clear();
                    },
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            )
          : Text(
              "Les demandes à traiter",
              textAlign: TextAlign.center,
              style: SafeGoogleFont(
                'Lato',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
      actions: [
        IconButton(
          key: const Key('__searchButton__'),
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              // If entering search mode, clear the text field
              if (_isSearching) {
                widget._textEditingController.clear();
              }
            });
          },
        ),
      ],
    );
  }
}
