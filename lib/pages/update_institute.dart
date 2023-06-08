import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/pages/home.dart';

import '../models/institute.dart';
import '../widgets/select_branch.dart';

class UpdateInstitute extends StatelessWidget {
  UpdateInstitute({
    super.key,
    required this.refreshOwnBranches,
    // required this.decoration,
    // required this.keyboardType,
  });
  final Function refreshOwnBranches;
  // final InputDecoration decoration;
  // final TextInputType keyboardType;

  final _formKey = GlobalKey<FormState>();

  // TextEditingController branchController = TextEditingController();
  TextEditingController seatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("update"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const SelectBranch(),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: seatsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Seats can't be empty";
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //check brach is exiest or not
                    if (ownBranches.every((val) =>
                        val.branchName == SelectBranch.dropdownvalue)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Branch already exist.'),
                        ),
                      );
                    } else {
                      //save data
                      final db = FirebaseFirestore.instance;
                      db
                          .collection("institutes")
                          .doc(userId)
                          .collection("branch")
                          .add(Branch(
                            bID: "",
                            minMarks: 0,
                            totalSeats: int.parse(seatsController.text),
                            filledSeats: 0,
                            branchName: SelectBranch.dropdownvalue,
                          ).toMap())
                          .then((value) {
                        db
                            .collection("institutes")
                            .doc(userId)
                            .collection("branch")
                            .doc(value.id)
                            .update(
                          {"bID": value.id},
                        );
                      });
                      refreshOwnBranches;
                      Navigator.pop(context);
                    }
                    // FirebaseFirestore.instance
                    //     .collection('institutes')
                    //     .doc(docs.id)
                    //     .collection('branch')
                    //     .get()
                    //     .then(
                    //       (value) => value.docs.forEach(
                    //         (element) {
                    //           ownBranches.add(
                    //             Branch.fromFirestore(
                    //               element,
                    //               SnapshotOptions(),
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     ),
                    // Institute branchInstitute = Institute(
                    //   uid: FirebaseAuth.instance.currentUser!.uid,

                    //   // branch: SelectBranch.dropdownvalue,
                    //   user: "institute",
                    //   name: nameController.text,
                    //   // filledSeats: 0,
                    //   branches: [
                    //     Branch(
                    //       minMarks: 0,
                    //       totalSeats: int.parse(seatsController.text),
                    //       filledSeats: 0,
                    //       branchName: SelectBranch.dropdownvalue,
                    //     ),
                    //   ],
                    //   email: emailController.text,
                    //   loginemail: Signup.mailController.text,
                    //   password: Signup.passwordController.text,
                    //   ashiiCode: int.parse(ashiiController.text),
                    //   address: addressController.text,
                    //   site: siteController.text,
                    //   phone: phoneController.text,
                    // );
                    // print("branch - ${branchInstitute}");
                    // db.collection("institutes").add(
                    //       branchInstitute.toFirestore(),
                    //     );
                    // //move to new page
                    // Navigator.pushNamedAndRemoveUntil(
                    //   context,
                    //   MyRoutes.loginRoute,
                    //   (route) => false,
                    // );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
