import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/pages/loginpages/sign.dart';

import '../utils/routes.dart';

class InstituteDetail extends StatelessWidget {
  InstituteDetail({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ashiiController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController meritController = TextEditingController();
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
                  hintText: "Eg - GP, Gandhinagar",
                  labelText: "Institute Name",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email can't be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Eg - principal_gpg@yahoo.co.in",
                  labelText: "Institute Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ashiiController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Number can't be empty";
                  } else if (int.parse(value) < 10000) {
                    return "Number is not less than 10";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Eg - 382028",
                  labelText: "Ashii code",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: addressController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Number can't be empty";
                  } else if (int.parse(value) < 10) {
                    return "Number is not less than 10";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText:
                      "Eg - k-6, Electronics Indust. Estate, Sector-26, Gandhinagar - 382028",
                  labelText: "Institute Address",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Number can't be empty";
                  } else if (int.parse(value) < 10000000000) {
                    return "Number is not less than 10";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Eg - (079) 27664785",
                  labelText: "Institute phone",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: siteController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "site can't be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Eg - www.gpgandhinagar.edu.in",
                  labelText: "Institute website",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: meritController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "merit can't be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Eg - 700000",
                  labelText: "Institute min Merit",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: branchController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Branch can't be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Eg - EC, CH, CE",
                  labelText: "Institute Branches",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //save data

                    final db = FirebaseFirestore.instance;
                    db.collection("institutes").add({
                      "r_email": Signup.mailController.text,
                      "r_password": Signup.passwordController.text,
                      "name": nameController.text,
                      "email": emailController.text,
                      "ashiiCode": int.parse(ashiiController.text),
                      "merit": int.parse(meritController.text),
                      "address": addressController.text,
                      "site": siteController.text,
                      "phone": phoneController.text,
                      "branch": branchController.text,
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
