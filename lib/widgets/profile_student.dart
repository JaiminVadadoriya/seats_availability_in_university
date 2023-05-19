import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/models/student.dart';
import 'package:seats_availability_in_university/widgets/show_info.dart';

import '../main.dart';
import '../pages/home.dart';
import '../utils/conform_seat.dart';
import 'merit.dart';

class ProfileStudent extends StatefulWidget {
  @override
  State<ProfileStudent> createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
  // const ProfileStudent({super.key});
  Student student = Student.fromMap(userData);

  Future<void> refreshUserInfo() async {
    final db = FirebaseFirestore.instance;
    final usersRef = db.collection('institutes').doc(userId);
    final docSnapshot = await usersRef.get();
    setState(() {
      userData = docSnapshot.data()!;
    });
  }

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
          FittedBox(
            child: const CircleAvatar(
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
            "${student.name}",
            style: TextStyle(fontSize: 29),
          ),
          SizedBox(
            height: 10,
          ),
          student.meritNo < 0
              ? Text(
                  "Merit no doesn't assign",
                  style: TextStyle(fontSize: 20),
                )
              : Text(
                  "${student.meritNo}",
                  style: TextStyle(fontSize: 23),
                ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeData().focusColor,
                  borderRadius: BorderRadius.all(
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
                      SizedBox(
                        height: 20,
                      ),
                      ShowInfo(
                        isInt: true,
                        userCollection: 'students',
                        keyToChng: "seatNo",
                        iconData: Icons.chair_alt,
                        string: "${student.seatNo.toString().toUpperCase()}",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Seat Number can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
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
                            "Maths - ${student.maths.toString().toUpperCase()}",
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
                        decoration: InputDecoration(
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
                            "Science - ${student.science.toString().toUpperCase()}",
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
                        decoration: InputDecoration(
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
                            "English - ${student.english.toString().toUpperCase()}",
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
                        decoration: InputDecoration(
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
                            "SocialScience - ${student.socialScience.toString().toUpperCase()}",
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
                        decoration: InputDecoration(
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
                            "Gujarati - ${student.gujrati.toString().toUpperCase()}",
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
                        decoration: InputDecoration(
                          hintText: "",
                          labelText: "Gujrati marks",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        refreshUserInfo: refreshUserInfo,
                      ),
                      rounds.mockroundEnds(Timestamp.now())
                          ? Container(
                              child: Column(children: [
                              // String namesinst = conformInstitute();
                              // Text(conformInstitute() as String),
                              // SizedBox(
                              //    height: 5,
                              //       ),
                            ]))
                          : Container(),
                      rounds.roundEnds(Timestamp.now())
                          ? Container(
                              child: Column(
                                children: [
                                  Text("conform you seat in "),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Future<bool> conform = conformSeat();
                                      //  bool checkConf=await conform as bool;
                                      //  print(checkConf);

                                      //if(!checkConf){

                                      //    print("ho raha he");
                                      Text(
                                          "You have successfully confirmed your institute branch ${student.confbranch.toString()}");
                                      // }
                                    },
                                    child: Text("conform"),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      //Future<bool> conform= conformInstitute();
                                      //   if(await conform){
                                      //   final db = FirebaseFirestore.instance;
                                      //  db
                                      //    .collection("students")
                                      //          .doc(student.uid)
                                      //      .update({
                                      //        "isSeatConf": context
                                      //       });
                                      Text(
                                          "You have cencel your confirmed  institute ");
                                      // }
                                    },
                                    child: Text("cencel"),
                                  ),
                                ],
                              ),
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
