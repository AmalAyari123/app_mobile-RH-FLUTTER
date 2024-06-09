import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/d%C3%A9tail-Solde.dart';
import 'package:myapp/admin/detail-demande.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/envv.dart';
import 'package:provider/provider.dart';

class Solde extends StatefulWidget {
  const Solde({super.key});

  @override
  State<Solde> createState() => _SoldeState();
}

class _SoldeState extends State<Solde> {
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: YourAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: MediaQuery.of(context).size.height - 190,
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1.5,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 228, 223, 223),
                      ),
                    );
                  },
                  itemCount: users?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 2,
                      ),
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: users != null &&
                                  index >= 0 &&
                                  index < users.length &&
                                  users[index].avatarId != null
                              ? NetworkImage(
                                  "http://$ipadressurl/database-files/${users[index].avatarId!}")
                              : const NetworkImage(
                                  'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg')),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Text(
                              users?[index].name ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined,
                                  color: Color.fromARGB(255, 97, 97, 97)),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return DetailSolde(
                                      user: users![index],
                                      index: index,
                                      providerUser: providerUser);
                                }));
                              },
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    // ignore: prefer_const_constructors
                                    TextSpan(
                                      text: 'Solde Maladie : ',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${users?[index].congeMaladie.toString() ?? '0'}',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    // ignore: prefer_const_constructors
                                    TextSpan(
                                      text: 'Congés payés : ',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${(users?[index].solde1 ?? 0) + (users?[index].soldeConge ?? 0)}',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                // ignore: prefer_const_constructors
                                TextSpan(
                                  text: 'Jours récupérables : ',
                                  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextSpan(
                                  text: '${users?[index].recuperation ?? 0}',
                                  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: ElevatedButton(
                onPressed: () {
                  ResetSolde();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: const Color.fromARGB(255, 210, 208, 208),
                          width: 1),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'réinitialiser les soldes',
                    style: SafeGoogleFont(
                      'Lato',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 70, 105, 140),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20)
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
          : const Text('Les soldes de congés'),
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
