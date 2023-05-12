// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seats_availability_in_university/models/rounds.dart';

import 'package:seats_availability_in_university/pages/details_page.dart';

import '../main.dart';
import '../models/institute.dart';
import '../utils/globals.dart';
import '../utils/routes.dart';
import 'home.dart';

// class AnimatedLogo extends AnimatedWidget {
//   const AnimatedLogo({super.key, required Animation<double> animation})
//       : super(listenable: animation);

//   @override
//   Widget build(BuildContext context) {
//     final animation = listenable as Animation<double>;
//     return Center(
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         height: animation.value,
//         width: animation.value,
//         child: const FlutterLogo(),
//       ),
//     );
//   }
// }

class AllInstitute extends StatefulWidget {
  Future<void> Function() refreshInstitute;
  final Rounds rounds;

  AllInstitute({
    Key? key,
    required this.refreshInstitute,
    required this.rounds,
  }) : super(key: key);

  @override
  State<AllInstitute> createState() => _AllInstituteState();
}

class _AllInstituteState extends State<AllInstitute>
    with TickerProviderStateMixin {
  String searchText = "";
  List<Institute> allbranchies = [];
  bool selectionIs = true;
  var _controller = TextEditingController();
  //late
  late Animation<double> animation;
  late AnimationController controller;

  void updateList(String value) {
    // this is the function that will filter our list
    if (value.isNotEmpty) {
      setState(() {
        allbranchies = branchesInstitutes.where((element) {
          element.branches = element.branches
              .where((element) => element.branchName
                  .toLowerCase()
                  .contains(value.toLowerCase()))
              .toList();
          if (element.branches.isNotEmpty) {
            return true;
          }
          return (element.name.toLowerCase().contains(value.toLowerCase()))
              ? true
              : false;
        }).toList();
      });
    } else {
      setState(() {
        allbranchies = branchesInstitutes;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allbranchies = branchesInstitutes;
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
    //
    selectionIs = rounds.firstRoundOpen(Timestamp.now());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  List<Widget> branchDisplayer(Institute institute) {
    List<Widget> branchWidget = [];
    // loop for showing branches in institute
    for (var i = 0; i < institute.branches.length; i++) {
      branchWidget.add(
        Card(
          child: ListTile(
            title: Row(
              children: [
                Flexible(
                  child: Text(
                    "${institute.name} - ${institute.branches[i].branchName})",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${institute.branches[i].totalSeats - institute.branches[i].filledSeats} Seats are available"),
                Text("${institute.address} "),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          institute: institute,
                        )),
              );
            },
            trailing: rounds.roundOpen(Timestamp.now())
                ? AnimatedRotation(
                    turns: selectionIs ? 1 : .375,
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.easeInBack,
                    child: IconButton(
                      icon: Icon(
                        // selectionIs ? Icons.favorite :
                        CupertinoIcons.add,
                        color: selectionIs ? Colors.green : Colors.red,
                      ),
                      onPressed: () {
                        // print(
                        //     "display name - ${FirebaseAuth.instance.currentUser!.displayName}");
                        // print(
                        //     "display photoUrl - ${FirebaseAuth.instance.currentUser!.photoURL}");
                        // print(
                        //     "display email - ${FirebaseAuth.instance.currentUser!.email}");
                        // print(
                        //     "display uid - ${FirebaseAuth.instance.currentUser!.uid}");
                        setState(() {
                          selectionIs = !selectionIs;
                          // institutes[index].isFav =
                          //     institutes[index].isFav ? false : true;
                        });
                      },
                    ),
                    // selectionIs?Icon(
                    // [index].isFav
                    // ? Icons.favorite
                    // :
                    //   CupertinoIcons.add,
                    //   color:
                    //       // institutes[index].isFav ? Colors.pink :
                    //       Colors.grey,
                    // ),
                  )
                : null,
            // AnimatedIcon(
            //   icon: AnimatedIcons.event_add,
            //   progress: controller,
            //   size: 72.0,
            // )
            //
          ),
        ),
      );
    }
    return branchWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Search box
                Expanded(
                  child: Material(
                    elevation: 1.2,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30.0),
                      right: Radius.circular(4.0),
                    ),
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        // setState(() {
                        // if (value.isEmpty) {
                        //   setState(() {});
                        // } else {
                        updateList(value);
                        // }
                        // });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Theme.of(context).focusColor,
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(8.0),
                        //   borderSide: BorderSide.none,
                        // ),

                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30.0),
                            right: Radius.circular(4.0),
                          ),
                        ),
                        hintText: "eg: Goverment Polytechnic",
                        prefixIcon: Icon(Icons.search),
                        // suffix:
                        //     // _controller.text.isEmpty
                        //     //     ? null
                        //     //     :
                        //     IconButton(
                        //   onPressed: _controller.clear,
                        //   icon: Icon(Icons.clear),
                        // ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.5,
                ),
                // providing filter page
                Tooltip(
                  message: "Filters",
                  child: SizedBox(
                    height: 60,
                    // width: 40,s
                    child: ElevatedButton(
                      onPressed: () {
                        // Lets open drawer using global key
                        Globals.scaffoldKey.currentState?.openEndDrawer();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.resolveWith(
                          (states) {
                            // If the button is pressed, return green, otherwise blue
                            if (states.contains(MaterialState.pressed)) {
                              return RoundedRectangleBorder(
                                // side: BorderSide(),
                                borderRadius: BorderRadiusDirectional.all(
                                    Radius.circular(8.0)),
                              );
                            }
                            return RoundedRectangleBorder(
                              // side: BorderSide(),
                              borderRadius: BorderRadiusDirectional.horizontal(
                                start: Radius.circular(
                                  4.0,
                                ),
                                end: Radius.circular(
                                  30.0,
                                ),
                              ),
                            );
                          },
                        ),
                        // elevation: MaterialStateProperty.resolveWith((states) {
                        //   return null;
                        // }),
                        // backgroundColor: MaterialStateProperty.resolveWith(
                        //   (states) {
                        //     // If the button is pressed, return green, otherwise blue
                        //     if (states.contains(MaterialState.pressed)) {
                        //       return Theme.of(context).indicatorColor;
                        //     }
                        //     return Theme.of(context).focusColor;
                        //   },
                        // ),
                      ),
                      child:
                          // Row(
                          //   children: [
                          Icon(
                        CupertinoIcons.slider_horizontal_3,
                        // color: ThemeData().secondaryHeaderColor,
                      ),
                      // Text(
                      //   "Filters",
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      // ],
                      // )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: widget.refreshInstitute,
            child: ListView.builder(
              itemCount: allbranchies.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: branchDisplayer(allbranchies[index]),
                  ),
                );

                // ListView.builder(
                //   itemCount: allbranchies[index].branches.length,
                //   itemBuilder: (context, indexbar) {
                //     return

                // return ListTile(
                //   title: Text(docIds[index]),
                //   trailing: Icon(Icons.edit),
                //   // isThreeLine: true,
                // );
                // }
                // );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// class LogoRotate extends StatefulWidget {
//   const LogoRotate({super.key});

//   @override
//   State<LogoRotate> createState() => LogoRotateState();
// }

// class LogoRotateState extends State<LogoRotate> {
//   double turns = 0.0;

//   void _changeRotation() {
//     setState(() => turns += 1.0 / 8.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         ElevatedButton(
//           onPressed: _changeRotation,
//           child: const Text('Rotate Logo'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(50),
//           child: AnimatedRotation(
//             turns: turns,
//             duration: const Duration(seconds: 1),
//             child: const FlutterLogo(),
//           ),
//         ),
//       ],
//     );
//   }
// }
