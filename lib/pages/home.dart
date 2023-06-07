import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:seats_availability_in_university/pages/all_institute.dart';
import 'package:seats_availability_in_university/pages/priority.dart';
import 'package:seats_availability_in_university/pages/profile.dart';
import 'package:seats_availability_in_university/widgets/filter_drawer.dart';

import '../models/institute.dart';
import '../utils/globals.dart';
import '../widgets/signout_drawer.dart';
import 'front_page.dart';
import 'message_page.dart';

// import 'package:timezone/timezone.dart' as tz;
// late Future<Rounds> rounds;
late Map<String, dynamic> userData;
// late Rounds rounds = Rounds(
//   firstRoundStart: Timestamp.now(),
//   firstRoundEnd: Timestamp.now(),
//   secondRoundStart: Timestamp.now(),
//   secondRoundEnd: Timestamp.now(),
//   registerStart: Timestamp.now(),
//   registerEnd: Timestamp.now(),
//   mockRoundStart: Timestamp.now(),
//   mockRoundEnd: Timestamp.now(),
// );

String userId = "";
List<Branch> ownBranches = [];

List<Institute> allbranchies = [];
List<Institute> branchesInstitutes = [
  // Institute(
  //   name: "GP, Gandhinagar",
  //   email: "principal_gpg@yahoo.co.in",
  //   ashiiCode: 382028,
  //   address: "k-6, Electronics Indust. Estate, Sector-26, Gandhinagar - 382028",
  //   phone: "(079) 23287433",
  //   site: "www.gpgandhinagar.edu.in", user: 'Institute',
  //   // isFav: false,
  //   // branch: [],
  //   // minMarks: 70,
  // ),
  // Institute(
  //   name: "R.C. Technical Institute",
  //   email: "rctisola@yahoo.com",
  //   ashiiCode: 380060,
  //   address:
  //       "Ahemedabad sarkej-Gandhinagar Highway, opp. Gujarat High Court, Sola, Ahmedabad - 380060",
  //   phone: "(079) 27664785",
  //   site: "www.rcti.in",
  //   user: 'Institute',
  //   // isFav: false,
  //   // branch: [],
  //   // minMarks: 70,
  // ),
  // Institute(
  //   name: "R.C. Technical Institute",
  //   email: "rctisola@yahoo.com",
  //   ashiiCode: 380060,
  //   address:
  //       "Ahemedabad sarkej-Gandhinagar Highway, opp. Gujarat High Court, Sola, Ahmedabad - 380060",
  //   phone: "(079) 27664785",
  //   site: "www.rcti.in",
  //   user: 'Institute',
  //   // isFav: false,
  //   // branch: [],
  //   // minMarks: 70,
  // ),
  // Institute(
  //   name: "R.C. Technical Institute",
  //   email: "rctisola@yahoo.com",
  //   ashiiCode: 380060,
  //   address:
  //       "Ahemedabad sarkej-Gandhinagar Highway, opp. Gujarat High Court, Sola, Ahmedabad - 380060",
  //   phone: "(079) 27664785",
  //   site: "www.rcti.in",
  //   user: 'Institute',
  // isFav: false,
  // branch: [],
  // minMarks: 70,
  // ),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                    print("institute exist!!!"),
                    print("institute $userDataFun exist!!!"),
                  }
              }
            else
              {
                studentRef = db
                    .collection('students')
                    .where("email", isEqualTo: emailid),
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
    setState(() {
      userData = userDataFun;
    });
    // return userDataFun;
    // final data =
    //     await FirebaseFirestore.instance.collection('institutes').doc().get().then((value) => {
    //  user = value.data(),
    // String name = data['user'];
  }

  // List<String> _docIds = [];

  @override
  void initState() {
    // _initRounds();
    _initUserInfo();
    super.initState();
  }

  // Future<void> _initInstitute() async {
  //   // List<String> documentIds = [];
  //   await FirebaseFirestore.instance.collection('institutes').get().then(
  //         (snapshot) => snapshot.docs.forEach(
  //           (document) {
  //             // documentIds.add(document.reference.id);
  //             // document.data();
  //             Institute temp = Institute.fromFirestore(
  //               document,
  //               SnapshotOptions(),
  //             );
  //             branchesInstitutes.contains(temp)
  //                 ? null
  //                 : branchesInstitutes.add(temp);
  //           },
  //         ),
  //         // (snapshot) => snapshot.docs.forEach(
  //         //   (document) {
  //         //     // documentIds.add(document.reference.id);
  //         //     branchesInstitutes.add(
  //         //       BranchInstitute.fromFirestore(
  //         //         document,
  //         //         SnapshotOptions(),
  //         //       ),
  //         //     );
  //         //   },
  //         // ),
  //       );
  // }

  Future<void> refreshInstitute() async {
    // List<String> documentIds = [];
    branchesInstitutes = [];
    //

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
    // end
    // allbranchies = branchesInstitutes;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // https://firebase.google.com/docs/firestore/query-data/get-data
//     // below line is used to get the

    List<Widget> widgetOptions = userData['user'] == "student"
        ? <Widget>[
            //vaidik

            AllInstitute(
              refreshInstitute: refreshInstitute,
              rounds: rounds,
            ),
            //vaidik end
            // FavInstitute(
            //   refreshInstitute: refreshInstitute,
            // ),
            const MessagePage(),
            const Profile(),
            // MapMun(
            //     cameraTarget: cameraTarget,
            //     dekhBinod: () => {
            //           dekhBinod(),
            //         }),
          ]
        : <Widget>[
            const MessagePage(),

            // FavInstitute(
            //   refreshInstitute: refreshInstitute,
            // ),
            const Profile(),
          ];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      key: Globals.scaffoldKey,

      //
      // ---> below we provide filter
      //

      endDrawer: const FilterDrawer(),

      //
      // ---> below we provide Signout logic
      //

      drawer: const SignoutDrawer(),

      //
      // ---> below we provide priorities logic
      //

      floatingActionButton: _selectedIndex == 0 && userData['user'] == "student"
          ? rounds.roundOpen(Timestamp.now()) ||
                  rounds.mockRoundOpen(Timestamp.now())
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      // NotificationApi.initState();

                      // // void listenNotifications() =>
                      // //     NotificationApi.onNotification.stream.listen(onClickedNotification);
                      // NotificationApi.showScheduledNotification(
                      //   title: 'hi${FirebaseAuth.instance.currentUser?.displayName}',
                      //   body: 'hey! Do we have everything we need for the lunch',
                      //   payload: 'sarah.abs',
                      //   scheduledDate: tz.TZDateTime.now(tz.local).add(
                      //     const Duration(seconds: 1),
                      //   ),
                      // );
                      // if (MyMap.problemSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => Priority()),
                        ),
                      );
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     content: Text("Please select problem location!!!"),
                      //   ));
                      // }
                    },
                    label: const Text('added collages'),
                    icon: const Icon(Icons.add),
                  ),
                )
              : Container()
          : null,
      //
      // ---> below we provide appbar logic
      //

      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text("Home"),
              actions: <Widget>[
                Container(),
              ],
            )
          : AppBar(
              title: const Text("Colleges"),
              actions: <Widget>[
                Container(),
              ],
            ),
      // body: Center(
      //   child: RefreshIndicator(
      //     onRefresh: () async {},
      //     child: ListView.builder(
      //       itemCount: institutes.length,
      //       prototypeItem: Container(
      //         height: 90,
      //         width: double.infinity,
      //       ),
      //       itemBuilder: (context, index) {
      //         return Card(
      //           child: ListTile(
      //             title: Text("${institutes[index].name} "),
      //             subtitle: Text("${institutes[index].address}"),
      //             trailing: IconButton(
      //               icon: Icon(
      //                 institutes[index].isFav
      //                     ? Icons.favorite
      //                     : Icons.favorite_border_outlined,
      //                 color:
      //                     institutes[index].isFav ? Colors.pink : Colors.grey,
      //               ),
      //               onPressed: () {
      //                 setState(() {
      //                   institutes[index].isFav =
      //                       institutes[index].isFav ? false : true;
      //                 });
      //               },
      //             ),
      //           ),
      //         );
      //         // return ListTile(
      //         //   title: Text(docIds[index]),
      //         //   trailing: Icon(Icons.edit),
      //         //   // isThreeLine: true,
      //         // );
      //       },
      //     ),
      //   ),
      // ),
      body: widgetOptions.elementAt(_selectedIndex),

      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 0,
      //   selectedIconTheme: IconThemeData(
      //     color: Colors.black87,
      //   ),
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //       backgroundColor: Colors.transparent,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'All Problems',
      //       backgroundColor: Colors.transparent,
      //       // backgroundColor: Colors.green,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'My Problems',
      //       backgroundColor: Colors.transparent,
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.settings),
      //     //   label: 'Settings',
      //     //   backgroundColor: Colors.transparent,
      //     // ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.black87,
      //   onTap: _onItemTapped,
      // ),

      //
      // ---> below we provide bottom nav bar logic
      //

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 15.0,
        ),
        child: GNav(
          gap: 10,
          // activeColor: Theme.of(context).primaryColor,
          tabBackgroundColor: Theme.of(context).focusColor,
          onTabChange: _onItemTapped,
          padding: const EdgeInsets.all(10),
          tabs: userData['user'] == "student"
              ? [
                  const GButton(
                    // icon: CupertinoIcons.home,
                    icon: Icons.home_filled,
                    text: 'Home',
                  ),
                  const GButton(
                    icon: Icons.info,
                    text: 'Information',
                  ),
                  const GButton(
                    icon: Icons.account_circle,
                    text: 'Account',
                  ),
                ]
              : [
                  const GButton(
                    icon: Icons.info,
                    text: 'Information',
                  ),
                  const GButton(
                    icon: Icons.account_circle,
                    text: 'Account',
                  ),
                ],
        ),
      ),
    );
  }
}
