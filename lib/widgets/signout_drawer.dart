import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/utils/routes.dart';

class SignoutDrawer extends StatelessWidget {
  const SignoutDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 40, 8.0, 8.0),
        child: Column(
          children: [
            const SizedBox(
              child: CircleAvatar(
                radius: 40,
                // backgroundColor: Color.fromRGBO(0, 102, 133, 1),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.account_circle,
                    // color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              // style: ButtonStyle(backgroundColor: ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MyRoutes.loginRoute,
                  (route) => false,
                );
              },
              child: const Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
