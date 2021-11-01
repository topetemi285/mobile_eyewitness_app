import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eyewitness_app/models/details.dart';
import 'package:eyewitness_app/models/emergence.dart';
import 'package:firebase_auth/firebase_auth.dart';



class FirestoreServices{
  FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        
          Future<void> saveDetail(Detail detail){

              final User user = _auth.currentUser;
              final uid = user.uid;
              print(uid);
              return users.doc(uid).collection("detail").add(detail.toMap());
          }    

          Future<void> saveEmergence(Emergence emergencee){
              final User user = _auth.currentUser;
              final uid = user.uid;
              print(uid);
              return users.doc(uid).collection("emergence").add(emergencee.toMap());
          }    
      
    // Future<void>saveDetail(Detail detail){
    // return  db.collection("users").doc(detail.detailId).collection("detail").add(detail.toMap());
    // }

    Stream<List<Detail>> getDetail(){
      db.collection("users").snapshots().map((snapshot)=>snapshot.docs.map((document) =>
       Detail.fromFirestore(document.data()))).toList();
    }

    
    // Future<void>saveEmergence(Emergence emergencee){
    // return  db.collection("users").doc(emergencee.emergenceId).collection("emergence").add(emergencee.toMap());
    // }

    Stream<List<Detail>> getEmergence(){
      db.collection("users").snapshots().map((snapshot)=>snapshot.docs.map((document) =>
       Detail.fromFirestore(document.data()))).toList();

    }

}

