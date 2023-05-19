// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seats_availability_in_university/main.dart';

import '../pages/home.dart';
import '../pages/update_institute.dart';

class ShowInfo extends StatelessWidget {
  final IconData iconData;
  final String string;
  final String userCollection;
  final String keyToChng;
  final Function validator;
  final Function refreshUserInfo;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final bool isInt;

  ShowInfo({
    Key? key,
    required this.iconData,
    required this.string,
    required this.validator,
    required this.decoration,
    required this.keyboardType,
    required this.keyToChng,
    required this.refreshUserInfo,
    required this.userCollection,
    required this.isInt,
  }) : super(key: key);

  TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(iconData),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "${string}",
                          style: TextStyle(
                            fontSize: 17,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              rounds.registerOpen(Timestamp.now())
                  ? IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Update'),
                          content: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: nameController,
                              validator: (value) => validator(value),
                              decoration: decoration,
                              keyboardType: keyboardType,
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
                                if (_formKey.currentState!.validate()) {
                                  var db = FirebaseFirestore.instance;
                                  //update from collection
                                  var updateValute = isInt == true
                                      ? int.parse(nameController.text)
                                      : nameController.text;
                                  final usersRef =
                                      db.collection(userCollection).doc(userId);
                                  // .where("uid", isEqualTo: uid);
                                  usersRef.update(
                                      {keyToChng: updateValute}).then((value) {
                                    refreshUserInfo;
                                    print(
                                        "DocumentSnapshot successfully updated!");
                                  },
                                      onError: (e) =>
                                          print("Error updating document $e"));
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
                      icon: Icon(CupertinoIcons.pen),
                    )
                  : Container(),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
