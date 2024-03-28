import 'package:flutter/material.dart';
import 'package:myapp/Model/dataTache.dart';
import 'package:myapp/admin/Employe.dart';

class TacheGrid extends StatelessWidget {
  const TacheGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: tache.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 25),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(tache[index].backImage),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  tache[index].text,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  tache[index].lessons,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ]),
                          Image.asset(
                            tache[index].imageUrl,
                            height: 110,
                          )
                        ]))),
          );
        });
  }
}
