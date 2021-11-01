
class Detail{

  
  final String subject;
  final String address;
  final String description;
  final String currentLocation;
  final DateTime doi;
  final String detailId;

  Detail({this.subject, this.address, this.description, this.currentLocation, this.doi, this.detailId});
  

  Map<String, dynamic>toMap(){

    return{
      "detailId":detailId,
      'suject':subject,
      "address":address,
      "description":description,
      "currentLocation":currentLocation,
      "doi":doi,

    };
  }

  //Retrieving data from firestore
  Detail.fromFirestore(Map<String,dynamic>firestore)
  : detailId = firestore['detailId'],
    subject = firestore['subject'],
    address = firestore['address'],
    description=firestore['description'],
    currentLocation=firestore['currentLocation'],
    doi=firestore['doi'];

}