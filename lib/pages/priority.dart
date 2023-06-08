import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seats_availability_in_university/models/student.dart';

import '../models/institute.dart';
import 'details_page.dart';
import 'front_page.dart';
import 'home.dart';

class Priority extends StatefulWidget {
  Priority({super.key});

  @override
  State<Priority> createState() => _PriorityState();
}

class _PriorityState extends State<Priority> {
  List<BranchInstitute> branchesInstitutes = [];

  var db = FirebaseFirestore.instance;

  Future<void> refreshInstitute() async {
    // List<String> documentIds = [];
    branchesInstitutes = [];
    //

    db.collection('students').doc(userId).get().then(
      (value) {
        userData = value.data()!;
        var stu = Student.fromMap(userData);
        List<String> instituteSelected = stu.fav;
        for (var institu in instituteSelected) {
          Institute institute;
          Branch branch;
          db.collection("institutes").doc(institu.substring(0, 20)).get().then(
            (valu) {
              // print("hell no ${value.data()}");
              institute = Institute.fromMap(valu.data()!);
              db.collection("institutes").doc(institu).get().then(
                (val) {
                  // print("hell no ${value.data()}");
                  branch = Branch.fromMap(val.data()!);
                  setState(() {
                    branchesInstitutes.add(
                      BranchInstitute(
                        minMarks: branch.minMarks,
                        totalSeats: branch.totalSeats,
                        filledSeats: branch.filledSeats,
                        isFav: branch.isFav,
                        branchName: branch.branchName,
                        bID: branch.bID,
                        uid: institute.uid,
                        user: institute.user,
                        name: institute.name,
                        loginemail: institute.loginemail,
                        email: institute.email,
                        ashiiCode: institute.ashiiCode,
                        address: institute.address,
                        site: institute.site,
                        phone: institute.phone,
                        password: institute.password,
                      ),
                    );
                  });
                },
              );
            },
          );
        }
      },
    );
    // end
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshInstitute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Priority"),
      ),
      body: RefreshIndicator(
        onRefresh: refreshInstitute,
        child: ListView.builder(
          itemCount: branchesInstitutes.length,
          itemBuilder: (context, index) {
            var selectionIs = true;
            return Card(
              child: ListTile(
                title: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${branchesInstitutes[index].name} - ${branchesInstitutes[index].branchName})",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${branchesInstitutes[index].totalSeats - branchesInstitutes[index].filledSeats} Seats are available"),
                    // Text("You have ${result} chances."),
                    Text("${branchesInstitutes[index].address} "),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              institute:
                                  branchesInstitutes[index].toInstitute(),
                            )),
                  );
                },
                trailing: rounds.roundOpen(Timestamp.now())
                    ? AnimatedRotation(
                        turns: selectionIs ? 0.375 : 1,
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.easeInBack,
                        child: IconButton(
                          icon: Icon(
                            // selectionIs ? Icons.favorite :
                            CupertinoIcons.add,
                            color: selectionIs ? Colors.red : Colors.green,
                          ),
                          onPressed: () {
                            // setState(() {
                            // });
                            final db = FirebaseFirestore.instance;
                            final studentRef =
                                db.collection("students").doc(userId);
                            if (selectionIs) {
                              // Atomically remove a region from the "regions" array field.
                              studentRef.update({
                                "fav": FieldValue.arrayRemove([
                                  "${branchesInstitutes[index].uid}/branch/${branchesInstitutes[index].bID}"
                                ]),
                              });

                              // _student.fav.add(branchesInstitutes[index].bID);
                            } else {
                              // Atomically add a new region to the "regions" array field.
                              studentRef.update({
                                "fav": FieldValue.arrayUnion([
                                  "${branchesInstitutes[index].uid}/branch/${branchesInstitutes[index].bID}"
                                ]),
                              });
                              // _student.fav
                              //     .remove(branchesInstitutes[index].bID);
                            }
                            setState(() {
                              selectionIs = !selectionIs;
                              branchesInstitutes
                                  .remove(branchesInstitutes[index]);
                            });
                            // refreshUserInfo();
                            // print(
                            //     "prssed- ${_student.fav.contains(branchesInstitutes[index].bID)}");
                            // userData = _student.toMap();
                            // if (!selectionIs) {
                            //   // Atomically add a new region to the "regions" array field.
                            // studentRef.update({
                            //   "fav": FieldValue.arrayUnion(
                            //       [branchesInstitutes[index].bID]),
                            // });
                            // } else {
                            //   // Atomically remove a region from the "regions" array field.
                            //   studentRef.update({
                            //     "fav": FieldValue.arrayRemove(
                            //         [branchesInstitutes[index].bID]),
                            //   });
                            // }

                            // setState(() {
                            //   selectionIs = !selectionIs;
                            // });
                          },
                        ),
                        // selectionIs?Icon(
                        // [index].isFav
                        // ? Icons.favorite
                        // :
                        //   CupertinoIcons.add,
                        //   color:
                        //       // institutes[index].isFav ? Colors.pink :
                        //       Colors.grey,
                        // ),
                      )
                    : null,
                // AnimatedIcon(
                //   icon: AnimatedIcons.event_add,
                //   progress: controller,
                //   size: 72.0,
                // )
                //
              ),
            );
          },
        ),
      ),
    );
  }
}
