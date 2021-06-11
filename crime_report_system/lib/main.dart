import 'package:crime_report_system/pages/welcome.dart';
//import 'package:crime_report_system/start.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';
// import 'authentications/signIn.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    //home: SignIn(),
    debugShowCheckedModeBanner: false,
    home: Welcome(),
  ));
}



