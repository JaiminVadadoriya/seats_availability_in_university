import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/routes.dart';
import 'loginpages/sign.dart';

class StudentDetail extends StatelessWidget {
  StudentDetail({super.key});
  final _formKey = GlobalKey<FormState>();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController mark1Controller = TextEditingController();
  static TextEditingController mark2Controller = TextEditingController();
  static TextEditingController mark3Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            children: [
              SizedBox(
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
                decoration: InputDecoration(
                  hintText: "",
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mark1Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Number can't be empty";
                  } else if (int.parse(value) < 10) {
                    return "Number is not less than 10";
                  } else if (int.parse(value) > 70) {
                    return "Number is not greater than 70";
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
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mark2Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Number can't be empty";
                  } else if (int.parse(value) < 10) {
                    return "Number is not less than 10";
                  } else if (int.parse(value) > 70) {
                    return "Number is not greater than 70";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "",
                  labelText: "Science marks",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mark3Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Number can't be empty";
                  } else if (int.parse(value) < 10) {
                    return "Number is not less than 10";
                  } else if (int.parse(value) > 70) {
                    return "Number is not greater than 70";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "",
                  labelText: "English marks",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //save data

                    final db = FirebaseFirestore.instance;
                    db.collection("students").add({
                      "r_email": Signup.mailController.text,
                      "r_password": Signup.passwordController.text,
                      "name": nameController.text,
                      "maths": int.parse(mark1Controller.text),
                      "science": int.parse(mark2Controller.text),
                      "english": int.parse(mark3Controller.text),
                    });
                    //move to new page
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyRoutes.loginRoute,
                      (route) => false,
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
