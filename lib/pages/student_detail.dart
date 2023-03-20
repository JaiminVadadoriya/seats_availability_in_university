import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/routes.dart';

class StudentDetail extends StatelessWidget {
  StudentDetail({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mark1Controller = TextEditingController();
  TextEditingController mark2Controller = TextEditingController();
  TextEditingController mark3Controller = TextEditingController();
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
              Row(
                // ignore: sort_child_properties_last
                children: <Widget>[
                  const Text('Already have account?'),
                  TextButton(
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontSize: 17),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          MyRoutes.loginRoute,
                          (route) => false,
                        );
                      })
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //save data
                    //move to new page
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyRoutes.signRoute,
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
