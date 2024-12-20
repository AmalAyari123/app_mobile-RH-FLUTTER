import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/detail-demande.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/envv.dart';
import 'package:provider/provider.dart';

class Demands extends StatefulWidget {
  const Demands({super.key});

  @override
  State<Demands> createState() => _DemandsState();
}

class _DemandsState extends State<Demands> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;

    getUsersController(providerUser);
    List<Demande>? demandes = providerUser.demandes;
    int enAttenteCount =
        demandes?.where((demande) => demande.status == "En Attente").length ??
            0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: YourAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Demandes",
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
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 158, 197, 228),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.only(
                      left: 18, top: 7), // Adjust padding as needed
                  child: Text(
                    '$enAttenteCount',
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
              height: 2,
              width: double.infinity, // Takes the full width available
              color: const Color.fromARGB(255, 228, 223, 223),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 210,
              margin: const EdgeInsets.only(top: 5),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 2,
                          width:
                              double.infinity, // Takes the full width available
                          color: Color.fromARGB(255, 228, 223, 223),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    );
                  },
                  itemCount: demandes?.length ?? 0,
                  itemBuilder: (context, index) {
                    User? associatedUser = users?.firstWhere(
                      (user) => user.id == demandes![index].userId,
                      orElse: () => User(id: -1, name: 'Unknown'),
                    );
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 2,
                      ),
                      leading: CircleAvatar(
                        radius: 30, // Adjust the radius to your desired size
                        backgroundImage: NetworkImage(associatedUser
                                    ?.avatarId !=
                                null
                            ? "http://$ipadressurl/database-files/${associatedUser?.avatarId!}"
                            : 'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg'),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          associatedUser?.name ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          _buildStatusIndicator(demandes?[index].status),
                          const SizedBox(width: 5),
                          Text(
                            demandes?[index].status ?? '',
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
                          color: Color.fromARGB(255, 59, 58, 58),
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DemandeDetails(
                              user: associatedUser!,
                              index: index,
                              demande: demandes![index],
                            );
                          }));
                        },
                      ),
                    );
                  }),
            ),
          ]),
        ));
  }
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
      automaticallyImplyLeading: _isSearching ? false : true,
      backgroundColor: Colors.white,
      elevation: 3,
      shadowColor: const Color.fromARGB(255, 193, 191, 191),
      centerTitle: true,
      title: _isSearching
          ? Expanded(
              child: Container(
                height: 40,
                width: 1500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: TextField(
                  key: const Key('__searchTextField__'),
                  controller: widget._textEditingController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: 'Cherchez par département ou nom',
                    hintStyle: const TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 131, 130, 130),
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        widget._textEditingController.clear();
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            )
          : const Text('Liste des demandes'),
      actions: [
        IconButton(
          key: const Key('__searchButton__'),
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              /*  if (_textEditingController.text.isNotEmpty) {
              final song = _textEditingController.text;
              await context.read<SongCubit>().fetchSongs(song);
              FocusScope.of(context).requestFocus(FocusNode());*/
            });
          },
        ),
      ],
    );
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
