// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:seats_availability_in_university/models/student.dart';

// import '../models/institute.dart';
// import '../pages/home.dart';

// Future<String> conformSeat() async {
//   final db = FirebaseFirestore.instance;

//   // Fetch all the students from Firestore
//   final studentRef = db.collection('students');
//   final studentDocs = await studentRef.get();
//   final students = Student.fromMap(userData);
//   // studentDocs.docs.map((doc) => Student.fromMap(doc.data())).toList();

//   List<Institute> instituteData = [];

//   final institutesSnapshot = await FirebaseFirestore.instance.collection('institutes').get();
//   for (final instituteDocument in institutesSnapshot.docs) {
//     final branchesSnapshot = await FirebaseFirestore.instance
//         .collection('institutes')
//         .doc(instituteDocument.id)
//         .collection('branch')
//         .get();

//     List<Branch> branches = branchesSnapshot.docs
//         .map((element) => Branch.fromFirestore(element, SnapshotOptions()))
//         .toList();

//     Institute temp = Institute.fromFirestore(instituteDocument, SnapshotOptions());
//     temp.branches = branches;
//     instituteData.add(temp);
//   }

//   bool confirmed = false;
//   double percentage;

//   //for (int i = 0; i < students.length; i++) {
//     int currentMerit = students.meritNo;

//     for (int j = 0; j < students.fav.length; j++) {
//       String currentFav = students.fav[j];

//       for (int z = 0; z < instituteData.length; z++) {
//         for (int x = 0; x < instituteData[z].branches.length; x++) {
//           //if (currentFav == instituteData[z].branches[x].bID) {
              
//             int minMerit = instituteData[z].branches[x].minMarks;
//             //int totalSeats = instituteData[z].branches[x].totalSeats;
//            // print(currentSeats);
//             // print(totalSeats);
//             // print(currentMerit);
//              percentage= (currentMerit*100)/minMerit;

            
            
//           //}
//         }
        
//       }
//     }
//     // if (confirmed) {
//     //   break;
//     // }
  

//   return percentage;
// }
