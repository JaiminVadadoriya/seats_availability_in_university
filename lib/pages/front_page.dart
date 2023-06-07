import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/institute.dart';
import '../models/rounds.dart';
import '../utils/routes.dart';
import 'home.dart';

Rounds rounds = Rounds(
  firstRoundStart: Timestamp.now(),
  firstRoundEnd: Timestamp.now(),
  secondRoundStart: Timestamp.now(),
  secondRoundEnd: Timestamp.now(),
  registerStart: Timestamp.now(),
  registerEnd: Timestamp.now(),
  mockRoundStart: Timestamp.now(),
  mockRoundEnd: Timestamp.now(),
);

Future<void> _initRounds() async {
  Rounds returnValue = Rounds(
    firstRoundStart: Timestamp.now(),
    firstRoundEnd: Timestamp.now(),
    secondRoundStart: Timestamp.now(),
    secondRoundEnd: Timestamp.now(),
    registerStart: Timestamp.now(),
    registerEnd: Timestamp.now(),
    mockRoundStart: Timestamp.now(),
    mockRoundEnd: Timestamp.now(),
  );
  if (kDebugMode) {
    print("phele - $returnValue");
  }
  rounds = await FirebaseFirestore.instance.collection('Admin').get().then(
    (snapshot) {
      for (var document in snapshot.docs) {
        returnValue = Rounds.fromFirestore(document, SnapshotOptions());
      }
      return returnValue;
    }
    //   (document) {
    //     returnValue = Rounds.fromFirestore(document, SnapshotOptions());
    //   },
    ,
    onError: (e) {
      if (kDebugMode) {
        print(e);
      }
    },
  );

  if (kDebugMode) {
    print("badme - $returnValue");
  }
  // return returnValue;
}

Future<void> _initUserInfo() async {
  String? emailid = FirebaseAuth.instance.currentUser?.email;

  final db = FirebaseFirestore.instance;
  final usersRef =
      db.collection('institutes').where("loginemail", isEqualTo: emailid);
  //  print("exist - ${_uid}");
  Query<Map<String, dynamic>> studentRef;
  Map<String, dynamic> userDataFun = {};

  usersRef.get().then(
        (docSnapshot) => {
          // if (docSnapshot)
          //   {
          // docSnapshot.docs

          if (docSnapshot.docs.isNotEmpty)
            {
              for (var docs in docSnapshot.docs)
                {
                  ///user id
                  userId = docs.id,
                  FirebaseFirestore.instance
                      .collection('institutes')
                      .doc(docs.id)
                      .collection('branch')
                      .get()
                      .then(
                        (value) => value.docs.forEach(
                          (element) {
                            ownBranches.add(
                              Branch.fromFirestore(
                                element,
                                SnapshotOptions(),
                              ),
                            );
                          },
                        ),
                      ),

                  userDataFun = docs.data(),
                  // setState(() {
                  userData = userDataFun,
                  // }),
                }
            }
          else
            {
              studentRef =
                  db.collection('students').where("email", isEqualTo: emailid),
              studentRef.get().then(
                (docSnapshot) {
                  if (docSnapshot.docs.isNotEmpty) {
                    for (var docs in docSnapshot.docs) {
                      ///user id
                      userId = docs.id;

                      userDataFun = docs.data();
                      // setState(() {
                      userData = userDataFun;
                      // });
                    }
                  } else {
                    //no student and institute data
                  }
                },
              ),
            }
        },
      );
  // setState(() {
  userData = userDataFun;
  // });
  // return userDataFun;
  // final data =
  //     await FirebaseFirestore.instance.collection('institutes').doc().get().then((value) => {
  //  user = value.data(),
  // String name = data['user'];
}

Future<void> _initInstitute() async {
  await FirebaseFirestore.instance.collection('institutes').get().then(
        (snapshot) => snapshot.docs.forEach(
          (document) {
            List<Branch> branches = [];
            FirebaseFirestore.instance
                .collection('institutes')
                .doc(document.id)
                .collection('branch')
                .get()
                .then(
                  (value) => value.docs.forEach(
                    (element) {
                      branches.add(
                        Branch.fromFirestore(
                          element,
                          SnapshotOptions(),
                        ),
                      );
                    },
                  ),
                );
            Institute temp = Institute.fromFirestore(
              document,
              SnapshotOptions(),
            );
            temp.branches = branches;
            branchesInstitutes.add(temp);
          },
        ),
      );
  // for (var branch in temp.branches) {
  //   if (branchesInstitutes.any((inst) =>
  //       inst.uid == temp.uid &&
  //       inst.branches
  //           .any((b) => b.branchName == branch.branchName))) {
  //     continue;
  //   }
  // Branch newBranch = Branch(
  //   isFav: branch.isFav,
  //   minMarks: branch.minMarks,
  //   totalSeats: branch.totalSeats,
  //   filledSeats: branch.filledSeats,
  //   branchName: branch.branchName,
  // );
  // Institute newInstitute = temp.copyWith(branches: [newBranch]);
  // }
}

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  void initState() {
    super.initState();
    _initRounds();
    _initUserInfo();
    _initInstitute();
    Timer(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(
        context,
        (FirebaseAuth.instance.currentUser != null)
            ? MyRoutes.homeRoute
            : MyRoutes.loginRoute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        color: isDarkMode
            ? Theme.of(context).primaryColor
            : Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
              ),
              const Text(
                "Seat Portal",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
