import 'package:agah/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Color(0xFF69BF7D),
      accentColor: Colors.green,

      visualDensity: VisualDensity.adaptivePlatformDensity,
      // Define the default font family.
      fontFamily: 'Bold',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 25.0,
            fontFamily: 'ExtraBold',
            color: Color(0xFFC5EDCC),
            fontWeight: FontWeight.bold),
        headline5: TextStyle(
          fontSize: 17.0,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
        headline4: TextStyle(
          fontSize: 17.0,
          color: Color(0xFFC5EDCC),
          fontWeight: FontWeight.w500,
        ),
        headline3: TextStyle(
            fontSize: 24.0, color: Colors.black54, fontFamily: 'Bold'),
        bodyText2: TextStyle(
          fontFamily: 'Regular',
          fontSize: 14.0,
          color: Colors.black45,
        ),
      ),
    ),
    home: HomePage(),
  ));
}
