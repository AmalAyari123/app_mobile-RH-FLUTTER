// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/departement.dart';
import 'package:myapp/Model/user.dart';

import 'package:myapp/admin/addUser.dart';
import 'package:myapp/admin/update.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;

    getUsersController(providerUser);
    ProviderDepartement providerDepartement =
        context.watch<ProviderDepartement>();
    getDepartementsController(providerDepartement);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: size.width,
                height: size.height / 3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff8d70fe),
                      Color(0xff2da9ef),
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                child: const Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      BackButton(
                        color: Color.fromARGB(255, 125, 123, 123),
                      ),
                      SizedBox(width: 23),
                      Text(
                        'Gestion des employés',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height / 5,
              left: 16,
              child: Container(
                width: size.width - 32,
                height: size.height / 1.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        // Set background color with opacity
                        hintText: 'Chercher par département ou par nom',
                        hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 107, 100, 100),
                            fontWeight: FontWeight.w300),
                        prefixIcon: const Icon(
                          Icons.search,
                          color:
                              Color.fromARGB(255, 69, 67, 67), // Set icon color
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none, // Remove border
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors.white), // Set text color
                    ),

                    // Set background color of the body

                    SizedBox(
                      height: MediaQuery.of(context).size.height - 275,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: ListView.separated(
                          padding: const EdgeInsets.only(
                            top: 0,
                          ),
                          itemCount: users?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    const SizedBox(width: 2),
                                    SlidableAction(
                                      padding: const EdgeInsets.all(10),
                                      flex: 2,
                                      borderRadius: BorderRadius.circular(16),
                                      onPressed: (_) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Update(
                                              user: users![index],
                                              index: index,
                                              providerUser: providerUser);
                                        }));
                                      },
                                      backgroundColor: const Color(0xff2da9ef),
                                      foregroundColor: Colors.white,
                                      icon: Icons.update_outlined,
                                      label: "Modifier",
                                    ),
                                    const SizedBox(width: 2),
                                    SlidableAction(
                                      padding: const EdgeInsets.all(10),
                                      flex: 2,
                                      borderRadius: BorderRadius.circular(14),
                                      onPressed: (_) {
                                        print('deleteeeeeeee');
                                        deleteUserController(
                                            context,
                                            users![index].id!,
                                            index,
                                            providerUser);
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: "Supprimer",
                                    ),
                                  ],
                                ),
                                child: Card(
                                  elevation: 8,
                                  shadowColor: const Color(0xff2da9ef),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 14,
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          users![index].profilePic ?? ''),
                                      radius: 30,
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        users![index].name ?? '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      users![index].departement?.name ?? '',
                                      style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontSize: 15,
                                      ),
                                    ),
                                    trailing: Text(
                                      users![index].userrole ?? '',
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        color: Colors.black45,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 4,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const Add();
          }));
        },
        backgroundColor: const Color(0xff2da9ef),
        foregroundColor: const Color(0xffffffff),
        child: const Icon(
          Icons.add,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
