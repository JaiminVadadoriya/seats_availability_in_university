import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../utils/routes.dart';
import '../front_page.dart';

class Login extends StatefulWidget {
  static const String _title = 'Login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController mailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Login._title)),
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
                // const Text(
                //   'Register',
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: mailController,
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
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: !_passwordVisible,
                  controller: passwordController,
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

                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          //loading circle
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          // checking Email AND Password
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: mailController.text,
                                  password: passwordController.text);

                          //pop the loading
                          Navigator.of(context).pop();

                          // send to new page
                          Navigator.pushNamedAndRemoveUntil(
                              context, MyRoutes.homeRoute, ((route) => false));
                        } on FirebaseAuthException catch (e) {
                          Navigator.of(context).pop();
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No user found for that email.'),
                              ),
                            );
                            // print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            // print('Wrong password provided for that user.');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Wrong password provided for that user.'),
                              ),
                            );
                          }
                        }

                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        /////////////////////////////////////////////////////////////////////////////////////////

                        // print(_user);

                        /////////////////////////
                        ///add to fire base
                        /////////////////////////
                      }
                    },
                  ),
                ),
                rounds.registerOpen(Timestamp.now())
                    ? Row(
                        children: <Widget>[
                          const Text('Does not have account?'),
                          TextButton(
                            child: const Text(
                              'Register',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: () {
                              //signup screen

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                MyRoutes.signRoute,
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );

// );
  }
}
