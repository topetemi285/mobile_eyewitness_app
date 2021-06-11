//import 'package:crime_report_system/start.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
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

  signOut()async{
    _auth.signOut();
  }
  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          child: !isLoggedIn
          ?Container(child: Padding(
            padding: const EdgeInsets.only(top: 50,left: 50),
            child: CircularProgressIndicator(),
          ))
          :Column(
            children: [
              Container(
                child: Image(
                 image:AssetImage('images/gym.jpg')
                  ),
                ),
              Container(
                child: Text("Hello ${user.email} welcome to the app"),),

                RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    onPressed:signOut,
                    child: Text('Sign Out',
                            style: TextStyle(
                              fontSize:20, 
                              color: Colors.white,
                              fontWeight: FontWeight.bold ),),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.deepOrange,
                    ),
          ],
        )
        )
      )
      
    );
  }
}

