import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seats_availability_in_university/pages/home.dart';
import 'package:seats_availability_in_university/pages/loginpages/login.dart';
import 'package:seats_availability_in_university/utils/google_sign_in_provider.dart';
import 'package:seats_availability_in_university/utils/routes.dart';
import 'package:seats_availability_in_university/utils/themes.dart';

import 'models/rounds.dart';
import 'pages/loginpages/register.dart';
import 'pages/loginpages/sign.dart';

late Rounds rounds = Rounds(
  firstRoundStart: Timestamp.now(),
  firstRoundEnd: Timestamp.now(),
  secondRoundStart: Timestamp.now(),
  secondRoundEnd: Timestamp.now(),
  registerStart: Timestamp.now(),
  registerEnd: Timestamp.now(),
  mockRoundStart: Timestamp.now(),
  mockRoundEnd: Timestamp.now(),
);

Future<void> _initRounds() async {
  Rounds returnValue = Rounds(
    firstRoundStart: Timestamp.now(),
    firstRoundEnd: Timestamp.now(),
    secondRoundStart: Timestamp.now(),
    secondRoundEnd: Timestamp.now(),
    registerStart: Timestamp.now(),
    registerEnd: Timestamp.now(),
    mockRoundStart: Timestamp.now(),
    mockRoundEnd: Timestamp.now(),
  );
  print("phele - ${returnValue}");
  rounds = await FirebaseFirestore.instance.collection('Admin').get().then(
    (snapshot) {
      for (var document in snapshot.docs) {
        returnValue = Rounds.fromFirestore(document, SnapshotOptions());
      }
      return returnValue;
    }
    //   (document) {
    //     returnValue = Rounds.fromFirestore(document, SnapshotOptions());
    //   },
    ,
    onError: (e) {
      print(e);
    },
  );

  print("badme - ${returnValue}");
  // return returnValue;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  _initRounds();
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
        themeMode: ThemeMode.system,
        // theme: MyTheme.lightTheme,
        // theme: MyTheme.lightTheme(context),
        // darkTheme: MyTheme.darkTheme(context),
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
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
