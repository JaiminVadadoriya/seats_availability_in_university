// import 'package:ai_app/models/user.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../utils/routes.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  static TextEditingController mailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  var _passwordVisible = false;
  var _conPasswordVisible = false;

  static TextEditingController confpasswordController = TextEditingController();
  // final FirebaseFirestore db = FirebaseFirestore.instance;

  // TextEditingController nameController = TextEditingController();
  // TextEditingController confpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /////////////////////////////////////////////////////////////////////////////
    // Users _user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                // Container(
                //   alignment: Alignment.center,
                //   padding: const EdgeInsets.all(10),
                //   child: const Text(
                //     'Geo-Tag',
                //     style: TextStyle(
                //       color: Colors.blue,
                //       // color: Theme.of(context).colorScheme.primary,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 30,
                //     ),
                //   ),
                // ),
                Image.asset(
                  'assets/images/login.png',
                  width: 300,
                  // height: double.infinity,
                  // width: double.infinity * .5,
                ),
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 20,
                // ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: Signup.mailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email can't be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "",
                    labelText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(),
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: !_passwordVisible,
                  controller: Signup.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    } else if (value.length < 8) {
                      return "Password is too short";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  obscureText: !_conPasswordVisible,
                  controller: confpasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    } else if (value != Signup.passwordController.text) {
                      return "Password is not same";
                    }
                    return null;
                  },
                  // decoration: const InputDecoration(
                  //   border: OutlineInputBorder(),
                  //   labelText: 'Confirm Password',
                  // ),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Enter your confirm password',
                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _conPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _conPasswordVisible = !_conPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          /////////////////////////
                          ///Loading ui
                          /////////////////////////
                          //loading circle
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: Signup.mailController.text,
                            password: Signup.passwordController.text,
                          );
                          Navigator.of(context).pop();

                          Navigator.pushNamed(context, MyRoutes.registerRoute);

                          //pop the loading
                        } on FirebaseAuthException catch (e) {
                          Navigator.of(context).pop();
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'The password provided is too weak.')),
                            );
                            // print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'The account already exists for that email.')),
                            );
                            if (kDebugMode) {
                              print(
                                  'The account already exists for that email.');
                            }
                          }
                        } catch (e) {
                          Navigator.of(context).pop();
                          if (kDebugMode) {
                            print(e);
                          }
                        }

                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        /////////////////////////////////////////////////////////////////////////////////////////

                        // print(_user);

                        /////////////////////////
                        ///add to fire base
                        /////////////////////////

                        /////////////////////////
                        ///navigate new page
                        /////////////////////////
                      }
                    },
                  ),
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
