import 'dart:async';

// import 'package:ai_app/pages/com_form.dart';
// import 'package:ai_app/utils/notification_api.dart';
// import 'package:ai_app/widgets/user_map.dart';
// import 'package:ai_app/widgets/all_problem.dart';
// import 'package:ai_app/widgets/user_problem.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:seats_availability_in_university/pages/all_institute.dart';
import 'package:seats_availability_in_university/pages/fav_institute.dart';
import 'package:seats_availability_in_university/pages/profile.dart';

import '../models/institute.dart';
// import 'package:timezone/timezone.dart' as tz;

List<Institute> institutes = [
  Institute(
    name: "GP, Gandhinagar",
    email: "principal_gpg@yahoo.co.in",
    ashiiCode: 382028,
    address: "k-6, Electronics Indust. Estate, Sector-26, Gandhinagar - 382028",
    phone: "(079) 23287433",
    site: "www.gpgandhinagar.edu.in",
    isFav: false,
    branch: [],
    minMarks: 70,
  ),
  Institute(
    name: "R.C. Technical Institute",
    email: "rctisola@yahoo.com",
    ashiiCode: 380060,
    address:
        "Ahemedabad sarkej-Gandhinagar Highway, opp. Gujarat High Court, Sola, Ahmedabad - 380060",
    phone: "(079) 27664785",
    site: "www.rcti.in",
    isFav: false,
    branch: [],
    minMarks: 70,
  ),
  Institute(
    name: "R.C. Technical Institute",
    email: "rctisola@yahoo.com",
    ashiiCode: 380060,
    address:
        "Ahemedabad sarkej-Gandhinagar Highway, opp. Gujarat High Court, Sola, Ahmedabad - 380060",
    phone: "(079) 27664785",
    site: "www.rcti.in",
    isFav: false,
    branch: [],
    minMarks: 70,
  ),
  Institute(
    name: "R.C. Technical Institute",
    email: "rctisola@yahoo.com",
    ashiiCode: 380060,
    address:
        "Ahemedabad sarkej-Gandhinagar Highway, opp. Gujarat High Court, Sola, Ahmedabad - 380060",
    phone: "(079) 27664785",
    site: "www.rcti.in",
    isFav: false,
    branch: [],
    minMarks: 70,
  ),
];

class Home extends StatefulWidget {
  Home({super.key});

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

  @override
  Widget build(BuildContext context) {
    // https://firebase.google.com/docs/firestore/query-data/get-data
//     // below line is used to get the
//     // instance of our FIrebase database.
//     final FirebaseFirestore db = FirebaseFirestore.instance;
//     // below line is used to get collection reference for our database.
//     final collection = db.collection("problems");
//     final docRef = collection
//         .withConverter(
//           fromFirestore: (snapshot, options) => Complain.fromFirestore(
//               snapshot.data()! as DocumentSnapshot<Map<String, dynamic>>,
//               options),
//           toFirestore: (Complain city, options) => city.toFirestore(),
//         )
//         .doc();
// final docSnap = await ref.get();
// final city = docSnap.data(); // Convert to City object
// if (city != null) {
//   print(city);
// } else {
//   print("No such document.");
// }

    List<Widget> widgetOptions = <Widget>[
      AllInstitute(),
      FavInstitute(),
      Profile(),
      // MapMun(
      //     cameraTarget: cameraTarget,
      //     dekhBinod: () => {
      //           dekhBinod(),
      //         }),
    ];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text("Home"),
              // actions: <Widget>[
              //   // on pressing icon button the camera will take to user current location
              //   IconButton(
              //     tooltip: 'find current location',
              //     icon: const Icon(Icons.location_searching_rounded),
              //     onPressed: () {
              //       // dekhBinod();
              //     },
              //   ),
              // ],
            )
          : AppBar(
              title: const Text("Colleges"),
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
      // on pressing floating action button the camera will take to user current location

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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 15.0,
        ),
        child: GNav(
          gap: 10,
          activeColor: Theme.of(context).primaryColor,
          tabBackgroundColor: Theme.of(context).secondaryHeaderColor,
          onTabChange: _onItemTapped,
          padding: EdgeInsets.all(10),
          tabs: [
            GButton(
              icon: Icons.view_list_rounded,
              text: 'Home',
            ),
            GButton(
              icon: Icons.favorite_border_rounded,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.account_circle,
              text: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
