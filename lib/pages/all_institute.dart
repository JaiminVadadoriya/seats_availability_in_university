// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:seats_availability_in_university/pages/details_page.dart';

import '../utils/globals.dart';
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
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // providing filter page
                ElevatedButton(
                    onPressed: () {
                      // Lets open drawer using global key
                      Globals.scaffoldKey.currentState?.openEndDrawer();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        // If the button is pressed, return green, otherwise blue
                        if (states.contains(MaterialState.pressed)) {
                          return Theme.of(context).primaryColor;
                        }
                        return Colors.white;
                      }),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.sort, color: Colors.grey),
                        Text(
                          "Filters",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
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
                      title: Row(
                        children: [
                          Text("${branchesInstitutes[index].name} - "),
                          Text("(${branchesInstitutes[index].branch})")
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${branchesInstitutes[index].totalSeats - branchesInstitutes[index].filledSeats} Seats are available"),
                          Text("${branchesInstitutes[index].address} "),
                        ],
                      ),
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
                          CupertinoIcons.add,
                          color:
                              // institutes[index].isFav ? Colors.pink :
                              Colors.grey,
                        ),
                        onPressed: () {
                          print(
                              "display name - ${FirebaseAuth.instance.currentUser!.displayName}");
                          print(
                              "display photoUrl - ${FirebaseAuth.instance.currentUser!.photoURL}");
                          print(
                              "display email - ${FirebaseAuth.instance.currentUser!.email}");
                          print(
                              "display uid - ${FirebaseAuth.instance.currentUser!.uid}");
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
            ),
          ),
        ],
      ),
    );
  }
}
