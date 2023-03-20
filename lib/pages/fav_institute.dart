import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'home.dart';

class FavInstitute extends StatefulWidget {
  const FavInstitute({super.key});

  @override
  State<FavInstitute> createState() => _FavInstituteState();
}

class _FavInstituteState extends State<FavInstitute> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: ListView.builder(
        itemCount: institutes.length,
        // prototypeItem: Container(
        //   height: 90,
        //   width: double.infinity,
        // ),
        itemBuilder: (context, index) {
          return institutes[index].isFav
              ? Card(
                  child: ListTile(
                    title: Text("${institutes[index].name} "),
                    subtitle: Text("${institutes[index].address} "),
                    trailing: IconButton(
                      icon: Icon(
                        institutes[index].isFav
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color:
                            institutes[index].isFav ? Colors.pink : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          institutes[index].isFav =
                              institutes[index].isFav ? false : true;
                        });
                      },
                    ),
                  ),
                )
              : Container();
          // return ListTile(
          //   title: Text(docIds[index]),
          //   trailing: Icon(Icons.edit),
          //   // isThreeLine: true,
          // );
        },
      ),
    );
  }
}
