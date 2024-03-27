import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/update.dart';
import 'package:myapp/solde.dart';

class CardWidget extends StatefulWidget {
  final User user;
  final int? id;
  final VoidCallback onDeleteUser;
  const CardWidget(
      {super.key,
      required this.user,
      required this.id,
      required this.onDeleteUser});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isDone = true;
  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            const SizedBox(
              width: 2,
            ),
            SlidableAction(
              padding: EdgeInsets.all(10),
              flex: 2,
              borderRadius: BorderRadius.circular(16),
              onPressed: (_) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Update(
                    name: widget.user.name,
                    email: widget.user.email,
                    soldeconge: widget.user.soldeConge,
                    solde1: widget.user.solde1,
                    company: widget.user.companyGroup,
                    numtel: widget.user.numTel,
                    photopath: widget.user.profilePic,
                  );
                }));
              },
              backgroundColor: const Color(0xff2da9ef),
              foregroundColor: Colors.white,
              icon: Icons.update_outlined,
              label: "Modifier",
            ),
            const SizedBox(
              width: 2,
            ),
            SlidableAction(
              padding: EdgeInsets.all(10),
              flex: 2,
              borderRadius: BorderRadius.circular(14),
              onPressed: (_) {
                widget.onDeleteUser();
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
              backgroundImage: NetworkImage(widget.user.profilePic ?? ''),
              radius: 30,
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                widget.user.name ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Text(
              widget.user.companyGroup ?? '',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 16,
              ),
            ),
            trailing: const Text(
              'Employé',
              style: TextStyle(
                fontFamily: 'Lato',
                color: Colors.black45,
                fontSize: 16,
              ),
            ),
          ),
        ));
  }
}
