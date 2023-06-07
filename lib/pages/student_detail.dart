import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/models/student.dart';

import '../utils/routes.dart';
import 'loginpages/sign.dart';

class StudentDetail extends StatelessWidget {
  StudentDetail({super.key});
  final _formKey = GlobalKey<FormState>();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController seatController = TextEditingController();
  static TextEditingController mark1Controller = TextEditingController();
  static TextEditingController mark2Controller = TextEditingController();
  static TextEditingController mark3Controller = TextEditingController();
  static TextEditingController mark4Controller = TextEditingController();
  static TextEditingController mark5Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name can't be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "",
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: seatController,
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
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mark1Controller,
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
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mark2Controller,
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
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mark3Controller,
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
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mark4Controller,
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
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mark5Controller,
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
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //save data

                    final db = FirebaseFirestore.instance;
                    Student student = Student(
                      meritNo: -1,
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      name: nameController.text,
                      email: Signup.mailController.text,
                      seatNo: seatController.text,
                      maths: int.parse(mark1Controller.text),
                      science: int.parse(mark2Controller.text),
                      english: int.parse(mark3Controller.text),
                      socialScience: int.parse(mark4Controller.text),
                      gujrati: int.parse(mark5Controller.text),
                      user: "student",
                      password: Signup.passwordController.text,
                      fav: [],
                      isSeatConf: false,
                      confbranch: "",
                      confinstitute: "",
                    );
                    db.collection("students").add(student.toFirestore()).then(
                        (value) => db
                            .collection("students")
                            .doc(value.id)
                            .update({"uid": value.id}));
                    // db.collection("students").add({
                    //   "r_email": Signup.mailController.text,
                    //   "r_password": Signup.passwordController.text,
                    //   "name": nameController.text,
                    //   "maths": int.parse(mark1Controller.text),
                    //   "science": int.parse(mark2Controller.text),
                    //   "english": int.parse(mark3Controller.text),
                    // });
                    //move to new page
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyRoutes.loginRoute,
                      (route) => false,
                    );
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
