// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userManagement(
  String displayName, 
  String occupation, 
  String currentLocation,
  String dob,
  String address,
  String mobileNumber,
  String photoURL,
  ) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth _auth =FirebaseAuth.instance;
  String uid =_auth.currentUser.uid;
  users.add({
    "displayName":displayName,
    "mobileNumber":mobileNumber,
    "currentLocation":currentLocation,
    "dob":dob,
    "occupation":occupation,
    "address":address,
    'photoURL':photoURL,
    "uid":uid.toString()
  });
    return;
  
}


