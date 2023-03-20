import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seats_availability_in_university/pages/home.dart';
import 'package:seats_availability_in_university/pages/loginpages/login.dart';
import 'package:seats_availability_in_university/utils/google_sign_in_provider.dart';
import 'package:seats_availability_in_university/utils/routes.dart';
import 'package:seats_availability_in_university/utils/themes.dart';

import 'pages/loginpages/register.dart';
import 'pages/loginpages/sign.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // debugRepaintRainbowEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        //Signup();
        ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        themeMode: ThemeMode.light,
        // theme: MyTheme.lightTheme,
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        debugShowCheckedModeBanner: false,
        // initialRoute: MyRoutes.signRoute,

        initialRoute: "/",
        // initialRoute: (isSignIn ? "/" : MyRoutes.loginRoute),
        //initialRoute: MyRoutes.mapRoute,
        // initialRoute: MyRoutes.compRoute,

        routes: {
          "/": (context) =>
              ((FirebaseAuth.instance.currentUser != null) ? Home() : Login()),
          MyRoutes.signRoute: (context) => Signup(),
          MyRoutes.loginRoute: (context) => Login(),
          MyRoutes.homeRoute: (context) => Home(),
          MyRoutes.registerRoute: (context) => Register(),
          // MyRoutes.compRoute: (context) => const ComForm(),
          // MyRoutes.statRoute: (context) => AllProblem(),
        },
      ),
    );
  }
}
