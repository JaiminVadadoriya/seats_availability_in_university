import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// class merit extends StatefulWidget {
//   // const merit({super.key,required this.student, required this.i});
//   // final Student student;
//   // final int i;

//   @override
//   State<merit> createState() => _meritState();
// }

// class _meritState extends State<merit> {

// //   bool selectionIs = false;
// // Future<void> refreshUserInfo() async {
// //     final db = FirebaseFirestore.instance;
// //     final usersRef = db.collection('students').doc(userId);
// //     final docSnapshot = await usersRef.get();

// // //        setState(() {
// // //       if (docSnapshot.exists) {
// // //         final data = docSnapshot.data();
// // //         if (data != null) {
// // //           print("pressed -  ${selectionIs}");
// // //           var student = Student.fromMap(data);
// // //           setState(() {
// // //             selectionIs =
// // //                 student.fav.contains(widget.student);
// // //             print("pressed -  ${selectionIs}");
// // //           });
// // //         }
// // //         // Student _student =
// // //         //     Student.fromMap(docSnapshot.data() as Map<String, dynamic>);
// // //       }
// // //     });
// // //         // Student _student =
// // //         //     Student.fromMap(docSnapshot.data() as Map<String, dynamic>);
// // //       }

//   @override

// //   //   void initState() {
// //   //   super.initState();
// //   //   refreshUserInfo();
// //   // }

// //   // void calculate(Student student) async{
// //   //   int totalMarks = student.maths+ student.english + student.gujrati + student.science + student.socialScience;
// //   //   double percentage = (totalMarks/500)*100;
// //   //   int totalthree=student.maths+ student.science+ student.socialScience;

// //   //   if(totalthree)
// //   // }

// //   void maritN(Student student){

// //   }

//   Widget build(BuildContext context) {
//     //calculateMeritList();
//      return Column(
//     children: [

//       ],
//     );}}
// //   }
// // }

// Define the Firestore collection where student data is stored

Future<void> calculateMeritList() async {
  // final List<Student> students = [];
  // final List<String> studentData = [];

  // final db = FirebaseFirestore.instance;
  // final studentRef = db
  //     .collection('students')
  //     .get()
  //     .then((value) => value.docs.forEach((element) {
  //           studentData.add(
  //             element.id,
  //           );
  //           students.add(
  //             Student.fromFirestore(
  //               element,
  //               SnapshotOptions(),
  //             ),
  //           );
  //         }));

  // /////////////trying new
  //   final db = FirebaseFirestore.instance;

  // // Fetch all the students from Firestore
  // final studentRef = db.collection('students');
  // final students = await studentRef.get().then((value) => value.docs
  //     .map((element) =>
  //         Student.fromFirestore(element,SnapshotOptions(),).uid = element.reference.id)
  //     .toList());
  // // Fetch all the students from Firestore

  // int getMeritNumber() {
  //   return stude+ mark2 + mark3;
  // }

  // int getMeritNumberWithExtraSubject() {
  //   return getMeritNumber() + mark4 + mark5;
  // }

  // final studentRef = db.collection('students');
  // final students = await studentRef.get().then((value) => value.docs
  //     .map((element) =>
  //         Student.fromFirestore(element)..id = element.reference.id)
  //     .toList());

  // // Sort the students based on their merit number and extra subject marks
  // students.sort((a, b) {
  //   int aMeritNumber = a.getMeritNumber();
  //   int bMeritNumber = b.getMeritNumber();
  //   int aExtraSubject = a.mark4 + a.mark5;
  //   int bExtraSubject = b.mark4 + b.mark5;
  //   if (aMeritNumber != bMeritNumber) {
  //     return bMeritNumber.compareTo(aMeritNumber);
  //   } else {
  //     return bExtraSubject.compareTo(aExtraSubject);
  //   }
  // });

  // // Assign the merit rank to each student
  // int currentRank = 1;
  // int currentMeritNumber = students[0].getMeritNumberWithExtraSubject();
  // for (int i = 0; i < students.length; i++) {
  //   Student student = students[i];
  //   int meritNumber = student.getMeritNumberWithExtraSubject();
  //   if (meritNumber != currentMeritNumber) {
  //     currentRank = i + 1;
  //     currentMeritNumber = meritNumber;
  //   }
  //   student.meritNo = currentRank;
  // }

  // // Update the Firestore document with the merit rank
  // for (Student student in students) {
  //   await studentRef.doc(student.uid).update(student.toFirestore());
  // }

  //////////////////
  ///
  final db = FirebaseFirestore.instance;

  // Fetch all the students from Firestore
  final studentRef = db.collection('students');
  final studentDocs = await studentRef.get();
  // final students = studentDocs.docs.map((doc) {
  //   Map<String, dynamic> data = doc.data();
  //   return {
  //     'uid': data['uid'] ?? 0,
  //     'maths': data['maths'] ?? 0,
  //     'english': data['english'] ?? 0,
  //     'science': data['science'] ?? 0,
  //     'socialScience': data['socialScience'] ?? 0,
  //     'gujrati': data['gujrati'] ?? 0,
  //     'meritNo': data['meritNo'] ?? 0,
  //   };
  // }).toList();
  final students = studentDocs.docs.map((doc) => doc.data()).toList();
  // Sort the students based on their merit number and extra subject marks
  students.sort((a, b) {
    int aMeritNumber = a['maths'] + a['science'] + a['english'];
    int bMeritNumber = b['maths'] + b['science'] + b['english'];
    int aExtraSubject = a['maths'] +
        a['science'] +
        a['english'] +
        a['socialScience'] +
        a['gujrati'];
    int bExtraSubject = b['maths'] +
        b['science'] +
        b['english'] +
        b['socialScience'] +
        b['gujrati'];

    if (aMeritNumber != bMeritNumber) {
      if (kDebugMode) {
        print("threee");
      }
      return bMeritNumber.compareTo(aMeritNumber);
    } else {
      return bExtraSubject.compareTo(aExtraSubject);
    }

    //   else if (aExtraSubject == bExtraSubject){
    //        if( bseat > aseat){
    //           return aseat;
    //            }
    //      }

    //  return bExtraSubject.compareTo(aExtraSubject);
  });
  //final s= studentDocs.docs.map((doc) => doc.id).toString();

  // Assign the merit rank to each student
  int currentRank = 1;
  int currentMeritNumber = students[0]['maths'] +
      students[0]['science'] +
      students[0]['english'] +
      students[0]['socialScience'] +
      students[0]['gujrati'];

  for (int i = 0; i < students.length; i++) {
    Map<String, dynamic> student = students[i];
    int meritNumber = student['maths'] +
        student['science'] +
        student['english'] +
        student['socialScience'] +
        student['gujrati'];
    if (meritNumber != currentMeritNumber) {
      currentRank = i + 1;
      currentMeritNumber = meritNumber;
    }
    student['meritNo'] = currentRank;
    await studentRef.doc(studentDocs.docs[i].id).update(student);
  }

  // Update the Firestore document with the merit rank
  // for (Map<String, dynamic> student in students) {
  //   await studentRef.doc(s).update( (student),);
  // }
}

  ///////

  // final CollectionReference studentsCollection = FirebaseFirestore.instance.collection('students');
  // // Retrieve all student documents from Firestore
  // final QuerySnapshot querySnapshot = await studentsCollection.get();

  // Create a list of Map that includes merit number and student data
  //final List<Map<String, dynamic>> studentList = [];

  // for (final DocumentSnapshot document in querySnapshot.docs) {
  //   final Map<String, dynamic> studentData = document.data() as Map<String, dynamic>;

  // Calculate the merit number based on the first three subjects
  //   final num meritNumber = int.parse(studentData['maths']) + studentData['science'] + studentData['english'];

  //   // Add merit number and student data to the list
  //   studentList.add({'meritNo': meritNumber,'id': document.id, ...studentData});
  //   print("hello for");
  // // }

  // // Sort the student list in descending order based on the merit number
  // // If two or more students have the same merit number, break the tie by considering the total marks of all 5 subjects
  // studentData.sort((a, b) {
  //   if (b['meritNo'] != a['meritNo']) {
  //     return (b['meritNo']).compareTo(a['meritNo']);
  //   } else {
  //     final int totalMarksA = a['maths'] + a['science'] + a['english'] + a['socialScience'] + a['gujrati'];
  //     final int totalMarksB = b['maths'] + b['science'] + b['english'] + b['socialScience'] + b['gujrati'];
  //     return totalMarksB.compareTo(totalMarksA);
  //     print("hello com");
  //   }
  // });

  //Create the merit list
  // int rank = 1;
  // int prevMeritNumber = -1;
  // for (final Map<String, dynamic> studentData in studentList) {
  //   // Compare the merit number with previous student's merit number
  //   if (studentData['meritNo'] != prevMeritNumber) {
  //     // Update the student document with rank in the merit list
  //     // await studentsCollection.doc(studentData['uid']).update({'meritNo': rank});
  //     print("hogaya rank");

  //     rank++;
  //     prevMeritNumber = studentData['meritNo'];
  //   } else {
  //     // Update the student document with the same rank as previous student
  //   //  await studentsCollection.doc(studentData['uid']).update({'meritNo': rank - 1});
  //     print("nahi aaya");
  //   }
  // }




// import 'package:cloud_firestore/cloud_firestore.dart';

// void generateMeritList() async {
//   // Get Firestore instance and collection reference
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   CollectionReference students = firestore.collection('students');

//   // Query all students
//   final querySnapshot = await students.get();
//   List<Map<String, dynamic>> studentList = [];
//     Student student = Student.fromMap(userData);

//   // Function to calculate merit number based on 3 subjects
//   int calculateMeritNumber(Map<String, dynamic> studentData) {
//     return studentData['maths'] + studentData['science'] + studentData['english'];
//   }

//   // Function to calculate merit number based on 5 subjects
//   int calculateMeritNumberFiveSub(Map<String, dynamic> studentData) {
//     return studentData['maths'] + studentData['science'] + studentData['english'] + studentData['socialScience'] + studentData['gujrati'];
//   }

//   // Iterate through each student and calculate merit rank
//   for (int i = 0; i < studentList.length; i++) {
//     int meritNumber = calculateMeritNumber(studentList[i]);
//     int meritNumberFiveSub = calculateMeritNumberFiveSub(studentList[i]);

//     // Check if student has the same merit number as other students
//     List<Map<String, dynamic>> sameMeritNumberStudents = studentList.where((s) => calculateMeritNumber(s) == meritNumber).toList();
//     if (sameMeritNumberStudents.length > 1) {
//       // If there are other students with the same merit number, compare their merit number based on 5 subjects
//       sameMeritNumberStudents.sort((a, b) => calculateMeritNumberFiveSub(b).compareTo(calculateMeritNumberFiveSub(a)));
//     }
//     // Assign merit rank to the student
//     studentList[i]['meritRank'] = sameMeritNumberStudents.indexWhere((s) => s['name'] == studentList[i]['name']) + 1;

//     // Update student data in Firestore
//     await students.doc(querySnapshot.docs[i].id).update({'meritNo': studentList[i]['meritNo']});
//   }
// }
