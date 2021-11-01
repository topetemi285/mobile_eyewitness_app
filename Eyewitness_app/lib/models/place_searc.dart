import 'dart:convert';

import 'package:flutter/cupertino.dart';

class PlaceSearch{
  final String description;
  final String placeId;

  PlaceSearch({this.description, this.placeId});


  factory PlaceSearch.fromJson(Map<String, dynamic> json){
    return PlaceSearch(
      description: json['description'],
      placeId: json['placeId'],
    );
  }

}