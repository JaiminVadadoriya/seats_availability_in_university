import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/models/institute.dart';
import 'package:seats_availability_in_university/widgets/show_info.dart';

import '../pages/front_page.dart';
import '../pages/home.dart';

class ProfileStudent extends StatefulWidget {
  const ProfileStudent({super.key});

  @override
  State<ProfileStudent> createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
  // const ProfileStudent({super.key});
  // Student student = userData[" "]fromMap(userData);

  Future<void> refreshUserInfo() async {
    final db = FirebaseFirestore.instance;
    final usersRef = db.collection('students').doc(userId);
    usersRef.get().then((value) {
      setState(() {
        userData = value.data()!;
        if (userData["confinstitute"].toString().isNotEmpty &&
            userData["confbranch"].toString().isNotEmpty) {
          refreshInstituteInfo(value.data()!["confinstitute"].toString(),
              value.data()!["confbranch"].toString());
        }
        // student = userData[" "]fromMap(userData);
      });
    });
  }

  Future<void> refreshInstituteInfo(String insti, String bran) async {
    final db = FirebaseFirestore.instance;
    db.collection("institutes").doc(insti).get().then(
      (val) {
        confromInstitute = Institute.fromFirestore(val, SnapshotOptions()).name;
        db
            .collection("institutes")
            .doc(insti)
            .collection("branch")
            .doc(bran)
            .get()
            .then(
          (value) {
            setState(() {
              confromBranch =
                  Branch.fromFirestore(value, SnapshotOptions()).branchName;
            });
          },
        );
      },
    );
  }

  String confromInstitute = "";
  String confromBranch = "";
  @override
  void initState() {
    super.initState();
    refreshUserInfo();
  }

  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // conformInstitute();

    // conformInstitute();
    // generateMeritList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const FittedBox(
            child: CircleAvatar(
              radius: 40,
              // backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
              ),
            ),
          ),
          Text(
            "${userData["name"]}",
            style: const TextStyle(fontSize: 29),
          ),
          const SizedBox(
            height: 10,
          ),
          userData["meritNo"] < 0
              ? const Text(
                  "Merit no doesn't assign",
                  style: TextStyle(fontSize: 20),
                )
              : Text(
                  "Merit - ${userData["meritNo"]}",
                  style: const TextStyle(fontSize: 23),
                ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeData().focusColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ShowInfo(
                        isInt: true,
                        userCollection: 'students',
                        keyToChng: "seatNo",
                        iconData: Icons.chair_alt,
                        string: userData["seatNo"].toString().toUpperCase(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Seat Number can't be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "",
                          labelText: "Seat Number",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        refreshUserInfo: refreshUserInfo,
                      ),
                      ShowInfo(
                        isInt: true,
                        userCollection: 'students',
                        keyToChng: "maths",
                        iconData: Icons.numbers_rounded,
                        string:
                            "Maths - ${userData["maths"].toString().toUpperCase()}",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Number can't be empty";
                          } else if (int.parse(value) < 34) {
                            return "Number is not less than 34";
                          } else if (int.parse(value) > 100) {
                            return "Number is not greater than 100";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "",
                          // labelText: "English marks",
                          labelText: "Maths marks",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        refreshUserInfo: refreshUserInfo,
                      ),
                      ShowInfo(
                        isInt: true,
                        userCollection: 'students',
                        keyToChng: "science",
                        iconData: Icons.numbers_rounded,
                        string:
                            "Science - ${userData["science"].toString().toUpperCase()}",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Number can't be empty";
                          } else if (int.parse(value) < 34) {
                            return "Number is not less than 34";
                          } else if (int.parse(value) > 100) {
                            return "Number is not greater than 100";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "",
                          labelText: "Science marks",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        refreshUserInfo: refreshUserInfo,
                      ),
                      ShowInfo(
                        isInt: true,
                        userCollection: 'students',
                        keyToChng: "english",
                        iconData: Icons.numbers_rounded,
                        string:
                            "English - ${userData["english"].toString().toUpperCase()}",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Number can't be empty";
                          } else if (int.parse(value) < 34) {
                            return "Number is not less than 34";
                          } else if (int.parse(value) > 100) {
                            return "Number is not greater than 100";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "",
                          labelText: "English marks",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        refreshUserInfo: refreshUserInfo,
                      ),
                      ShowInfo(
                        isInt: true,
                        userCollection: 'students',
                        keyToChng: "socialScience",
                        iconData: Icons.numbers_rounded,
                        string:
                            "SocialScience - ${userData["socialScience"].toString().toUpperCase()}",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Number can't be empty";
                          } else if (int.parse(value) < 34) {
                            return "Number is not less than 34";
                          } else if (int.parse(value) > 100) {
                            return "Number is not greater than 100";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "",
                          labelText: "SocialScience marks",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        refreshUserInfo: refreshUserInfo,
                      ),
                      ShowInfo(
                        isInt: true,
                        userCollection: 'students',
                        keyToChng: "gujrati",
                        iconData: Icons.numbers_rounded,
                        string:
                            "Gujarati - ${userData["gujrati"].toString().toUpperCase()}",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Number can't be empty";
                          } else if (int.parse(value) < 34) {
                            return "Number is not less than 34";
                          } else if (int.parse(value) > 100) {
                            return "Number is not greater than 100";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "",
                          labelText: "Gujrati marks",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        refreshUserInfo: refreshUserInfo,
                      ),
                      // rounds.mockroundEnds(Timestamp.now())
                      //     ? Container(
                      //         child: Column(children: [
                      //         // String namesinst = conformInstitute();
                      //         Text(""),
                      //         SizedBox(
                      //            height: 5,
                      //               ),
                      //       ]))
                      //     : Container(),
                      rounds.roundEnds(Timestamp.now()) &&
                              userData["confinstitute"].toString().isNotEmpty &&
                              userData["confbranch"].toString().isNotEmpty &&
                              !userData['isSeatConf']
                          ? Column(
                              children: [
                                Text(
                                  "conform you seat in $confromInstitute - $confromBranch",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        db
                                            .collection("institutes")
                                            .doc(userData["confinstitute"])
                                            .collection("branch")
                                            .doc(userData["confbranch"])
                                            .get()
                                            .then((value) {
                                          Branch branch =
                                              Branch.fromMap(value.data()!);
                                          db
                                              .collection("institutes")
                                              .doc(userData["confinstitute"])
                                              .collection("branch")
                                              .doc(userData["confbranch"])
                                              // .doc(instituteData[z].branches[x].bID)
                                              .update({
                                            'filledSeats':
                                                (branch.filledSeats + 1)
                                          }).then((value) {
                                            db
                                                .collection("students")
                                                .doc(userData["uid"])
                                                .update({
                                              'isSeatConf': true,
                                            });
                                            setState(() {
                                              userData['isSeatConf'] = true;
                                            });
                                          });
                                        });

                                        //if(!checkConf){
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "You have successfully confirmed your institute branch $confromBranch",
                                            ),
                                          ),
                                        );
                                        //    print("ho raha he");

                                        // }
                                      },
                                      child: const Text("conform"),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        db
                                            .collection("students")
                                            .doc(userData["uid"])
                                            .update({
                                          'confinstitute': "",
                                          'confbranch': "",
                                        });
                                        setState(() {
                                          userData["confbranch"] = "";
                                          userData["confinstitute"] = "";
                                        });
                                        //Future<bool> conform= conformInstitute();
                                        //   if(await conform){
                                        //   final db = FirebaseFirestore.instance;
                                        //  db
                                        //    .collection("students")
                                        //          .doc(userData[" "]uid)
                                        //      .update({
                                        //        "isSeatConf": context
                                        //       });
                                        // db
                                        //     .collection("students")
                                        //     .doc(userData["uid"])
                                        //     .update({
                                        //   'confinstitute': "",
                                        //   'confbranch': "",
                                        // });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "You have cancel your confirmed  institute ",
                                            ),
                                          ),
                                        );

                                        // }
                                      },
                                      child: const Text("cancel"),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                      rounds.roundEnds(Timestamp.now()) &&
                              userData["confinstitute"].toString().isNotEmpty &&
                              userData["confbranch"].toString().isNotEmpty &&
                              userData['isSeatConf']
                          ? Text(
                              'You have successfully confirmed your institute branch "$confromBranch", submit your documents in "$confromInstitute" as soon as possible',
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
