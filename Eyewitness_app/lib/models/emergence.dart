class Emergence{

   String emergence;
  final String emergenceId;

  Emergence({this.emergence,this.emergenceId});


  Map<String, dynamic>toMap(){
    return{
      "emergenceId":emergenceId,
      'emergence':emergence,
    };
  }

  //Retrieving data from firestore
  // Detail.fromFirestore(Map<String,dynamic>firestore)
  // : detailId = firestore['detailId'],
  //   subject = firestore['subject'],
  //   address = firestore['address'],
  //   description=firestore['description'],
  //   currentLocation=firestore['currentLocation'],
  //   doi=firestore['doi'];

}