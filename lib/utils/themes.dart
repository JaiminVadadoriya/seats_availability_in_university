// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MyTheme {
//   static ThemeData lightTheme(BuildContext context) => ThemeData(
//         // primarySwatch: Colors.indigo,
//         // 3F51BE
//         // colorSchemeSeed: Color.fromRGBO(0, 102, 174, 1),
//         // hex: A3D4ED
//         colorSchemeSeed: Color.fromARGB(255, 163, 212, 237),
//         // hex for appbar #006685, (255, 0, 102, 133)
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         // appBarTheme: AppBarTheme(),
//         // appBarTheme: AppBarTheme(
//         //   color: Colors.white,
//         //   titleTextStyle: TextStyle(
//         //     // color: Colors.blue,
//         //     color: Theme.of(context).colorScheme.primary,
//         //     fontWeight: FontWeight.w500,
//         //     fontSize: 20,
//         //   ),
//         //   elevation: 0.0,
//         //   iconTheme: IconThemeData(color: Colors.black),
//         //   // textTheme: Theme.of(context).textTheme,
//         // ),
//       );

//   static ThemeData darkTheme(BuildContext context) => ThemeData(
//         brightness: Brightness.dark,
//         colorSchemeSeed: Color.fromARGB(255, 163, 212, 237),
//         // colorSchemeSeed: Color.fromARGB(255, 0, 25, 35),
//         // primarySwatch: Colors.indigo,
//       );

//   // //Colors
//   // static Color creamColor = Color(0xfff5f5f5);
//   // static Color darkBluishColor = Color(0xff403b58);
// }

//////////////////// matrial 3

import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006685),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFBFE9FF),
  onPrimaryContainer: Color(0xFF001F2A),
  secondary: Color(0xFF006685),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFBEE9FF),
  onSecondaryContainer: Color(0xFF001F2A),
  tertiary: Color(0xFF00658C),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFC6E7FF),
  onTertiaryContainer: Color(0xFF001E2D),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFCFF),
  onBackground: Color(0xFF001D31),
  surface: Color(0xFFFCFCFF),
  onSurface: Color(0xFF001D31),
  surfaceVariant: Color(0xFFDCE3E9),
  onSurfaceVariant: Color(0xFF40484C),
  outline: Color(0xFF70787D),
  onInverseSurface: Color(0xFFE7F2FF),
  inverseSurface: Color(0xFF003351),
  inversePrimary: Color(0xFF6DD2FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006685),
  outlineVariant: Color(0xFFC0C8CD),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF6DD2FF),
  onPrimary: Color(0xFF003547),
  primaryContainer: Color(0xFF004D65),
  onPrimaryContainer: Color(0xFFBFE9FF),
  secondary: Color(0xFF6AD3FF),
  onSecondary: Color(0xFF003546),
  secondaryContainer: Color(0xFF004D65),
  onSecondaryContainer: Color(0xFFBEE9FF),
  tertiary: Color(0xFF81CFFF),
  onTertiary: Color(0xFF00344B),
  tertiaryContainer: Color(0xFF004C6B),
  onTertiaryContainer: Color(0xFFC6E7FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001D31),
  onBackground: Color(0xFFCDE5FF),
  surface: Color(0xFF001D31),
  onSurface: Color(0xFFCDE5FF),
  surfaceVariant: Color(0xFF40484C),
  onSurfaceVariant: Color(0xFFC0C8CD),
  outline: Color(0xFF8A9297),
  onInverseSurface: Color(0xFF001D31),
  inverseSurface: Color(0xFFCDE5FF),
  inversePrimary: Color(0xFF006685),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF6DD2FF),
  outlineVariant: Color(0xFF40484C),
  scrim: Color(0xFF000000),
);
