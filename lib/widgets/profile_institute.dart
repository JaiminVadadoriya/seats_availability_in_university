import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/models/institute.dart';
import 'package:seats_availability_in_university/pages/update_institute.dart';
import 'package:seats_availability_in_university/widgets/show_info.dart';

import '../pages/home.dart';

class ProfileInstitute extends StatefulWidget {
  const ProfileInstitute({super.key});

  @override
  State<ProfileInstitute> createState() => _ProfileInstituteState();
}

class _ProfileInstituteState extends State<ProfileInstitute> {
  Institute branchInstitute = Institute.fromMap(userData);

  TextEditingController seatsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    refreshOwnBranches();
    refreshUserInfo();
  }

  Future<void> refreshOwnBranches() async {
    ownBranches = [];
    FirebaseFirestore.instance
        .collection('institutes')
        .doc(userId)
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
        );
    setState(() {});
    // final docSnapshot = await usersRef.get();
    // setState(() {
    // userData = docSnapshot.data()!;
    // });
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            child: CircleAvatar(
              radius: 40,
              // backgroundColor: Color.fromRGBO(0, 102, 133, 1),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.account_balance,
                  // CupertinoIcons.bala,
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  branchInstitute.name.toUpperCase(),
                  style: const TextStyle(fontSize: 25),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     ElevatedButton(
                    //       child: Row(
                    //         children: [
                    //           Icon(CupertinoIcons.pen, size: 20),
                    //           Text(
                    //             "Edit",
                    //             style: TextStyle(
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       onPressed: () => showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) => AlertDialog(
                    //           title: const Text('Delete Problem'),
                    //           content: const Text(
                    //               'This will delete your problem!!!'),
                    //           actions: <Widget>[
                    //             TextButton(
                    //               onPressed: () => {
                    //                 // Navigator.pop(context),
                    //                 print('click cancel')
                    //               },
                    //               child: const Text('Cancel'),
                    //             ),
                    //             TextButton(
                    //               onPressed: () {
                    //                 //delete from collection
                    //                 print('click ok');
                    //                 // problem.doc(documentId).delete();
                    //                 //pop from dialog
                    //                 // Navigator.pop(context);
                    //               },
                    //               child: const Text('OK'),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    ShowInfo(
                      isInt: false,
                      userCollection: 'institutes',
                      keyToChng: "email",
                      iconData: Icons.email,
                      string: branchInstitute.email.toString().toUpperCase(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email can't be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Eg - principal_gpg@yahoo.co.in",
                        labelText: "Institute Email",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      refreshUserInfo: refreshUserInfo,
                    ),

                    ShowInfo(
                      isInt: false,
                      userCollection: 'institutes',
                      keyToChng: "address",
                      iconData: Icons.location_on,
                      string: branchInstitute.address.toString().toUpperCase(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Address can't be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText:
                            "Eg - k-6, Electronics Indust. Estate, Sector-26, Gandhinagar - 382028",
                        labelText: "Institute Address",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                      refreshUserInfo: refreshUserInfo,
                    ),
                    ShowInfo(
                      isInt: true,
                      userCollection: 'institutes',
                      keyToChng: "ashiiCode",
                      iconData: Icons.numbers_rounded,
                      string:
                          branchInstitute.ashiiCode.toString().toUpperCase(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Number can't be empty";
                        } else if (value.length < 6) {
                          return "Number is not less than 6";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Eg - 382028",
                        labelText: "Ashii code",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      refreshUserInfo: refreshUserInfo,
                    ),
                    ShowInfo(
                      isInt: false,
                      userCollection: 'institutes',
                      keyToChng: "phone",
                      iconData: Icons.phone,
                      string: branchInstitute.phone.toString().toUpperCase(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Number can't be empty";
                        } else if (value.length < 10) {
                          return "Number is not less than 10";
                        } else if (int.parse(value) < 0) {
                          return 'Number is not in negeative';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Eg - (079) 27664785",
                        labelText: "Institute phone",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      refreshUserInfo: refreshUserInfo,
                    ),
                    for (var branch in ownBranches)
                      Card(
                        child: ListTile(
                          trailing: ownBranches.length == 1
                              ? null
                              : IconButton(
                                  icon: const Icon(CupertinoIcons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Delete'),
                                        content: const Text(
                                            "Branch will be deleted!!!"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => {
                                              Navigator.pop(context),
                                            },
                                            child: const Text(
                                              'Cancel',
                                              //                             style:
                                              // Theme.of(context).textTheme.labelLarge,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              var db =
                                                  FirebaseFirestore.instance;
                                              //update from branch seats
                                              db
                                                  .collection("institutes")
                                                  .doc(userId)
                                                  .collection("branch")
                                                  .doc(branch.bID)
                                                  .delete();
                                              refreshOwnBranches();
                                              //pop from dialog
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    setState(() {});
                                  },
                                ),
                          title: Text(
                            branch.branchName,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Wrap(
                                  children: [
                                    const Icon(Icons.chair_alt),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${branch.filledSeats.toString().toUpperCase()} / ${branch.totalSeats.toString().toUpperCase()}",
                                      style: const TextStyle(
                                        fontSize: 17,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: "edit Seats",
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Update'),
                                    content: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: seatsController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "merit can't be empty";
                                          } else if (int.parse(value) < 0) {
                                            return 'Seats is not in negeative';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          hintText: "Eg - 120",
                                          labelText: "Institute Branch Seats",
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => {
                                          Navigator.pop(context),
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            var db = FirebaseFirestore.instance;
                                            //update from branch seats
                                            db
                                                .collection("institutes")
                                                .doc(userId)
                                                .collection("branch")
                                                .doc(branch.bID)
                                                .update(
                                              {
                                                "totalSeats": int.parse(
                                                  seatsController.text,
                                                ),
                                              },
                                            );
                                            refreshOwnBranches();
                                            // final usersRef = db
                                            //     .collection('institutes')
                                            //     .doc(userId);
                                            // // .where("uid", isEqualTo: uid);
                                            // usersRef.update({
                                            //   "email": seatsController.text
                                            // }).then((value) {
                                            //   setState(() {
                                            //     refreshUserInfo();
                                            //   });
                                            //   print(
                                            //       "DocumentSnapshot successfully updated!");
                                            // },
                                            //     onError: (e) => print(
                                            //         "Error updating document $e"));
                                            //pop from dialog
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                ),
                                // onPressed: () {
                                //   // on edit button pressed
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: ((context) => UpdateInstitute(
                                //             validator: validator,
                                //             keyboardType: keyboardType,
                                //             decoration: decoration,
                                //           )),
                                //     ),
                                //   );
                                // },
                                icon: const Icon(CupertinoIcons.pen),
                              )
                            ],
                          ),

                          // ShowInfo( isInt: false,
                          //   iconData: Icons.chair_alt,
                          //   string:
                          //       "${branch.filledSeats.toString().toUpperCase()} / ${branch.totalSeats.toString().toUpperCase()}",
                          // ),
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => UpdateInstitute(
                                  refreshOwnBranches: refreshOwnBranches,
                                  // validator: validator,
                                  // keyboardType: keyboardType,
                                  // decoration: decoration,
                                )),
                          ),
                        );
                        setState(() {});
                      },
                      icon: const Icon(CupertinoIcons.add_circled),
                      tooltip: "Add Branch",
                    ),

////////

                    // child: Column(
                    //   children: [
                    //     ShowInfo( isInt: false,
                    //       iconData: Icons.chair_alt,
                    //       string:
                    //           "${_branch.filledSeats.toString().toUpperCase()} / ${_branch.totalSeats.toString().toUpperCase()}",
                    //     ),
                    //   ],
                    // ),
                    // ListView.builder(
                    //   itemBuilder: (context, index) {
                    //     return

                    //   },
                    //   itemCount: branchInstitute.branches.length,
                    // )

                    // ShowInfo( isInt: false,
                    //   iconData: Icons.location_on,
                    //   string:
                    //       "${branchInstitute.branch.toString().toUpperCase()}",
                    // ),
                  ],
                ),
              ),
            ),
          )

              // ListView.builder(
              //   itemCount: 3,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text(
              //         "${branchInstitute}",
              //         style: TextStyle(fontSize: 19),
              //       ),
              //     );
              //   },
              // ),
              ),
        ],
      ),
    );
  }
}
