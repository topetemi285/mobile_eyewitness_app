import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eyewitness_app/models/emergence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencePage extends StatefulWidget {
  const EmergencePage({ Key key }) : super(key: key);

  @override
  _EmergencePageState createState() => _EmergencePageState();
}

class _EmergencePageState extends State<EmergencePage> {
  final number = '08138303723';

 Emergence emerg =Emergence();

final FirebaseAuth _auth = FirebaseAuth.instance;

CollectionReference users = FirebaseFirestore.instance.collection('users');
  
  Future<void> addUser()async{

  
    var position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    var lati = position.latitude;
    var longi = position.longitude;
    // setState(() {
    //    locationMessage = "$lati, $longi";
    // });

    final User user = _auth.currentUser;
    final uid = user.uid;
    print(uid);
    return users
    .doc(uid)
    .collection("emergence")
    .add({"emergence": "peter you need to save someone",
    "latitude":lati,
    "longitude":longi});
  }
                          
  
  User user;

  bool isLoggedIn =false;

  checkAuthentication () async{
    _auth.authStateChanges().listen((user) {
      if(user==null){
        Navigator.of(context).pushReplacementNamed("start");
      }
     });
  }

  getUser()async{
   User UserCredential  = _auth.currentUser;
   await UserCredential?.reload();
   UserCredential= _auth.currentUser;

   if(UserCredential!=null){
     setState(() {
       this.user=UserCredential;
       this.isLoggedIn=true;
     });
   }

  }
  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }
   signOut()async{
    _auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    //final emergenceProvider = Provider.of<  EmergenceProvider>(context);
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
              children: [
                SizedBox(height: 40,),
                  AvatarGlow(
                    endRadius: 100,
                    glowColor: Colors.red,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    child: Material(
                      //elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.red[700],
                        child: MaterialButton(
                          child: Text("Emergence", 
                          style: TextStyle(
                            color: Colors.white
                            ),
                          ), 
                                onPressed:addUser 
                              ),
                          ),
                        ),
                    ),
                  
                          
                      
                    
                // Container(
                //   child: Image(
                //    image:AssetImage('images/gym.jpg')
                //     ),
                //   ),

                  // RaisedButton(
                  //     padding: EdgeInsets.only(left: 30, right: 30),
                  //     onPressed:(){
                  //       signOut();
                  //     },
                  //     child: Text('Sign Out',
                  //             style: TextStyle(
                  //               fontSize:20, 
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold ),),

                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(10)
                  //           ),
                  //           color: Colors.deepOrange,
                  //     ),


                  SizedBox(height: 150,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: AvatarGlow(
                        endRadius: 100,
                        glowColor: Colors.grey,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon
                              (
                                Icons.call,
                                color: Colors.red[700],
                                        size: 36,
                              ), 
                                onPressed: () async{
                                      launch('tel://$number');
                                      await FlutterPhoneDirectCaller.callNumber(number);
                                }
                              ),
                          ),
                        ),
                        ),
                  ),


                //       CircleAvatar(
                //         backgroundColor: Colors.red,
                //         child: IconButton(
                //            onPressed: () async{
                //           launch('tel://$number');
                //           await FlutterPhoneDirectCaller.callNumber(number);
                //         }, 
                //         icon: Icon(Icons.call,
                //         color: Colors.white,
                        
                //         )
                //   ),
                        
                // )
            ],
          ),
      ),
    );
  }

}

