Future<bool> conformSeat() async {
  // Fetch all the students from Firestore
  // studentDocs.docs.map((doc) => Student.fromMap(doc.data())).toList();

  // List<Institute> instituteData = [];

  // final institutesSnapshot =
  //     await FirebaseFirestore.instance.collection('institutes').get();
  // for (final instituteDocument in institutesSnapshot.docs) {
  //   final branchesSnapshot = await FirebaseFirestore.instance
  //       .collection('institutes')
  //       .doc(instituteDocument.id)
  //       .collection('branch')
  //       .get();

  //   List<Branch> branches = branchesSnapshot.docs
  //       .map((element) => Branch.fromFirestore(element, SnapshotOptions()))
  //       .toList();

  //   Institute temp =
  //       Institute.fromFirestore(instituteDocument, SnapshotOptions());
  //   temp.branches = branches;
  //   instituteData.add(temp);
  // }

  bool confirmed = false;

  //for (int i = 0; i < students.length; i++) {

  // for (int j = 0; j < students.fav.length; j++) {
  //   String currentFav = students.fav[j];

  //   for (int z = 0; z < instituteData.length; z++) {
  //     for (int x = 0; x < instituteData[z].branches.length; x++) {
  //       if (currentFav == instituteData[z].branches[x].bID) {
  //         // if(j == 0){
  //         //   await db
  //         //     .collection("institutes")
  //         //     .doc(instituteData[z].uid)
  //         //     .collection("branch")
  //         //     .doc(instituteData[z].branches[x].bID)
  //         //     .update({'filledSeats': 0});

  //         // }
  //       }
  //     }
  //     if (confirmed) {
  //       break;
  //     }
  //   }
  // }
  // if (confirmed) {
  //   break;
  // }

  return confirmed;
}
