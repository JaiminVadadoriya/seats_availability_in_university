// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'home.dart';

class FavInstitute extends StatefulWidget {
  Future<void> Function() refreshInstitute;

  FavInstitute({
    Key? key,
    required this.refreshInstitute,
  }) : super(key: key);

  @override
  State<FavInstitute> createState() => _FavInstituteState();
}

class _FavInstituteState extends State<FavInstitute> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.refreshInstitute,
      child: ListView.builder(
        itemCount: branchesInstitutes.length,
        // prototypeItem: Container(
        //   height: 90,
        //   width: double.infinity,
        // ),
        itemBuilder: (context, index) {
          return
              // institutes[index].isFav
              //     ?
              Card(
            child: ListTile(
              title: Text("${branchesInstitutes[index].name} "),
              subtitle: Text("${branchesInstitutes[index].address} "),
              trailing: IconButton(
                icon: Icon(
                  // institutes[index].isFav
                  //     ? Icons.favorite
                  //     :
                  Icons.favorite_border_outlined,
                  color:
                      // institutes[index].isFav ?
                      //  Colors.pink :
                      Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    // institutes[index].isFav =
                    //     institutes[index].isFav ? false : true;
                  });
                },
              ),
            ),
          );
          // : Container();
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
