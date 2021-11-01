import 'package:eyewitness_app/models/details.dart';
import 'package:flutter/material.dart';
import 'package:eyewitness_app/services/firestore_services.dart';
import 'package:uuid/uuid.dart';

  

class DetailedProvider with ChangeNotifier{

  final firestoreservices = FirestoreServices();
   String _subject;
   String _address;
   String _description;
   String _currentLocation;
   DateTime _doi;
   String _longi;
   String _latitude;
  //  String _detailId;
  //  var uuid = Uuid();

  //getter of the parameters
  String get subject =>_subject;
  String get address =>_address;
  String get description => _description;
  String get currentLocation => _currentLocation;
  DateTime get doi=>_doi;
  String get longi=> _longi;
   String get lati=> _latitude;
  //String get detailedId=>_detailId;

  //setters of the parameter
  changeSubject(String value){
    _subject=value;
    notifyListeners();
  }

  changeaAddress(String value){
    _address = value;
    notifyListeners();
  }

  changeDescription(String value){
    _description = value;
    notifyListeners();
  }

  changeCurrentLocation(String value){
    _currentLocation=value;
    notifyListeners();
  }

  changeDoi(String value){
    _doi = DateTime.parse(value);
  }


  saveDetail(){
    //print("$subject, $address, $description, $currentLocation");
    var newDetail = Detail(subject:subject, 
                  address:address,description:description,
                  currentLocation:currentLocation,
                  doi:doi,

                  //detailId:uuid.v4()
                  );
    firestoreservices.saveDetail(newDetail);
  }
  
}

