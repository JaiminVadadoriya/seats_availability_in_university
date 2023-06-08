import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/models/institute.dart';

import '../models/student.dart';
import '../pages/details_page.dart';
import '../pages/front_page.dart';
import '../pages/home.dart';

class InstituteCard extends StatefulWidget {
  const InstituteCard({super.key, required this.institute, required this.i});
  final Institute institute;
  final int i;

  @override
  State<InstituteCard> createState() => _InstituteCardState();
}

class _InstituteCardState extends State<InstituteCard> {
  bool selectionIs = false;
  Student student = Student.fromMap(userData);
  // Student _student = Student.fromMap(userData);
  Future<void> refreshUserInfo() async {
    final db = FirebaseFirestore.instance;
    final usersRef = db.collection('institutes').doc(userId);
    final docSnapshot = await usersRef.get();
    setState(() {
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          if (kDebugMode) {
            print("pressed -  $selectionIs");
          }
          student = Student.fromMap(data);
          setState(() {
            selectionIs = student.fav.contains(
                "${widget.institute.uid}/branch/${widget.institute.branches[widget.i].bID}");
            if (kDebugMode) {
              print("pressed -  $selectionIs");
            }
          });
          userData = data;
        }
        // Student _student =
        //     Student.fromMap(docSnapshot.data() as Map<String, dynamic>);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    refreshUserInfo();
    student = Student.fromMap(userData);
    selectionIs = student.fav.contains(
        '${widget.institute.uid}/branch/${widget.institute.branches[widget.i].bID}');
  }

  double calculatePossibility(
      int totalSeats, int maxMerit, int studentMeritNumber) {
    if (studentMeritNumber <= maxMerit) //5 <= 6
    {
      double possibility = ((maxMerit - studentMeritNumber) / maxMerit) *
          (totalSeats.toDouble() / totalSeats);
      return possibility * 100;
    } else {
      return 0;
    }
  }

  final students = Student.fromMap(userData);
  //   studentDocs.docs.map((doc) => Student.fromMap(doc.data())).toList();
  @override
  Widget build(BuildContext context) {
    int totalStu = students.meritNo;

    // (titul sea * fillseat)100//20

    int minMerit = widget.institute.branches[widget.i].minMarks; //3
//2*100 = 200/3 = 33.
    double result = calculatePossibility(
        widget.institute.branches[widget.i].totalSeats, minMerit, totalStu);
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Flexible(
              child: Text(
                "${widget.institute.name} - ${widget.institute.branches[widget.i].branchName})",
                style: const TextStyle(
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
                "${widget.institute.branches[widget.i].totalSeats - widget.institute.branches[widget.i].filledSeats} Seats are available"),
            Text("You have $result chances."),
            Text("${widget.institute.address} "),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      institute: widget.institute,
                    )),
          );
        },
        trailing: rounds.roundOpen(Timestamp.now()) && !userData['isSeatConf']
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
                    print(
                        "muje sona ${widget.institute.uid}/branch/${widget.institute.branches[widget.i].bID}");
                    setState(() {
                      selectionIs = !selectionIs;
                    });
                    final db = FirebaseFirestore.instance;
                    final studentRef = db.collection("students").doc(userId);
                    if (selectionIs) {
                      // Atomically add a new region to the "regions" array field.
                      studentRef.update({
                        "fav": FieldValue.arrayUnion([
                          "${widget.institute.uid}/branch/${widget.institute.branches[widget.i].bID}"
                        ]),
                      });

                      // _student.fav.add(widget.institute.branches[widget.i].bID);
                    } else {
                      // Atomically remove a region from the "regions" array field.
                      studentRef.update({
                        "fav": FieldValue.arrayRemove([
                          "${widget.institute.uid}/branch/${widget.institute.branches[widget.i].bID}"
                        ]),
                      });
                      // _student.fav
                      //     .remove(widget.institute.branches[widget.i].bID);
                    }

                    // refreshUserInfo();
                    // print(
                    //     "prssed- ${_student.fav.contains(widget.institute.branches[widget.i].bID)}");
                    // userData = _student.toMap();
                    // if (!selectionIs) {
                    //   // Atomically add a new region to the "regions" array field.
                    // studentRef.update({
                    //   "fav": FieldValue.arrayUnion(
                    //       [widget.institute.branches[widget.i].bID]),
                    // });
                    // } else {
                    //   // Atomically remove a region from the "regions" array field.
                    //   studentRef.update({
                    //     "fav": FieldValue.arrayRemove(
                    //         [widget.institute.branches[widget.i].bID]),
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
  }
}
