// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import 'package:eyewitness_app/models/place_searc.dart';

// class PlaceSearch{
//    final key ="AIzaSyDQoYJ63I1AhkqXq5XmoV2y3aMvjg5Q_h4";
//   Future<List<PlaceSearch>>getAutocomplete(String search) async{

//     var url = 
//       "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&language=pt_BR&key=key";
//     var response = await http.get(url);
//     var json = convert.jsonDecode(response.body);
//     var jsonResults = json["predictions"] as List;
//     return jsonResults.map((place)=>PlaceSearch.fromJson(place)).toList();

//     //fromJson(place)).toList();

//   }
// }

