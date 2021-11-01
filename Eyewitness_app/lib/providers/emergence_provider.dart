import 'package:eyewitness_app/models/details.dart';
import 'package:eyewitness_app/models/emergence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eyewitness_app/services/firestore_services.dart';
import 'package:uuid/uuid.dart';

  

class EmergenceProvider with ChangeNotifier{

  final firestoreservices = FirestoreServices();
  
  

   String _emergence;
  //  String _emergenceId;
   //var uuid = Uuid();
   var help = "help!!!";

  //getter of the parameters
  String get emergence =>_emergence;
  // String get emergenceId=>_emergenceId;

  //setters of the parameter
  changeSubject(String value){
    _emergence="I need help";
    notifyListeners();
  }

  saveEmergence(){
    //print("$subject, $address, $description, $currentLocation");
    var newEmergence = Emergence(emergence: help);
    firestoreservices.saveEmergence(newEmergence);
  }
  
}

