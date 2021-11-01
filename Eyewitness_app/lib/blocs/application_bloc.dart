
import 'package:eyewitness_app/services/geolocator_services.dart';
import 'package:flutter/foundation.dart';


import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class ApplicationBloc with ChangeNotifier{
  final geolocatorServices = GeolocatorServices();

  Position currentLocation;

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation () async{
    currentLocation = await geolocatorServices.getCurrentLocation();
    notifyListeners();

  }
}