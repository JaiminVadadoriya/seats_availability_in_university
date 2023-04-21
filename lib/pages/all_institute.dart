// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:seats_availability_in_university/pages/details_page.dart';

import '../utils/routes.dart';
import 'home.dart';

class AllInstitute extends StatefulWidget {
  Future<void> Function() refreshProblems;
  AllInstitute({
    Key? key,
    required this.refreshProblems,
  }) : super(key: key);

  @override
  State<AllInstitute> createState() => _AllInstituteState();
}

class _AllInstituteState extends State<AllInstitute> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.refreshProblems,
      child: ListView.builder(
        itemCount: branchesInstitutes.length,
        // prototypeItem: Container(
        //   height: 90,
        //   width: double.infinity,
        // ),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${branchesInstitutes[index].name} "),
              subtitle: Text("${branchesInstitutes[index].address} "),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsPage(
                            institute: branchesInstitutes[index],
                          )),
                );
              },
              trailing: IconButton(
                icon: Icon(
                  // institutes[index].isFav
                  //     ? Icons.favorite
                  //     :
                  Icons.favorite_border_outlined,
                  color:
                      // institutes[index].isFav ? Colors.pink :
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
