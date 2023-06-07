import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seats_availability_in_university/models/student.dart';

import '../models/institute.dart';

Future<String> conformInstitute() async {
  final db = FirebaseFirestore.instance;

  // Fetch all the students from Firestore
  final studentRef = db.collection('students');
  final studentDocs = await studentRef.get();
  final students = //Student.fromMap(userData);
      studentDocs.docs.map((doc) => Student.fromMap(doc.data())).toList();

  List<Institute> instituteData = [];

  final institutesSnapshot =
      await FirebaseFirestore.instance.collection('institutes').get();
  for (final instituteDocument in institutesSnapshot.docs) {
    final branchesSnapshot = await FirebaseFirestore.instance
        .collection('institutes')
        .doc(instituteDocument.id)
        .collection('branch')
        .get();

    List<Branch> branches = branchesSnapshot.docs
        .map((element) => Branch.fromFirestore(element, SnapshotOptions()))
        .toList();

    Institute temp =
        Institute.fromFirestore(instituteDocument, SnapshotOptions());
    temp.branches = branches;
    instituteData.add(temp);
  }

  bool confirmed = false;
  String instiname = "";
  String branchname = "";

  for (int i = 0; i < students.length; i++) {
    int currentMerit = students[i].meritNo;

    for (int j = 0; j < students[i].fav.length; j++) {
      String currentFav = students[i].fav[j];

      for (int z = 0; z < instituteData.length; z++) {
        for (int x = 0; x < instituteData[z].branches.length; x++) {
          if (currentFav == instituteData[z].branches[x].bID) {
            String instiname = instituteData[z].name;
            String branchname = instituteData[z].branches[x].branchName;
            String stuname = students[i].name;
            //  int currentSeats = instituteData[z].branches[x].filledSeats;
            // int totalSeats = instituteData[z].branches[x].totalSeats;
            // print(currentSeats);
            // print(totalSeats);
            // print(currentMerit);

            if ( //currentMerit <= totalSeats ||
                // (currentMerit >= totalSeats &&
                instituteData[z].branches[x].filledSeats <
                    instituteData[z].branches[x].totalSeats //)
                ) {
              // Update the favorite institute branch of the student

              instituteData[z].branches[x].filledSeats++;

              // Increment the seats in the branch document within the institute collection
              if (instituteData[z].branches[x].minMarks == 0 ||
                  instituteData[z].branches[x].minMarks < students[i].meritNo) {
                instituteData[z].branches[x].minMarks = students[i].meritNo;
                print("$stuname get this $instiname in $branchname");
                //   await db
                // .collection("institutes")
                // .doc(instituteData[z].uid)
                // .collection("branch")
                // .doc(instituteData[z].branches[x].bID)
                // .update({'filledSeats': instituteData[z].branches[x].filledSeats});

                await db
                    .collection("institutes")
                    .doc(instituteData[z].uid)
                    .collection("branch")
                    .doc(instituteData[z].branches[x].bID)
                    .update(
                        {'minMarks': instituteData[z].branches[x].minMarks});
              }
              // else if( ){
              //   instituteData[z].branches[x].minMarks = students.meritNo;
              // }

              print('You have successfully confirmed your institute branch.');
              confirmed = true;
              break;
            } else {
              print(
                  'Your merit number is not within the available seats for this institute branch. Please wait for next round.');
              confirmed = false;
            }
          }
          if (confirmed) {
            break;
          }
        }
        // if (confirmed) {
        //   break;
        // }
      }
      if (confirmed) {
        break;
      }
    }
    //   if (confirmed) {
    //     break;
    //  }
  }

  return instiname + branchname;
}
