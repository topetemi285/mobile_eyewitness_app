//import 'package:crime_report_system/authentications/signIn.dart';
import 'package:crime_report_system/authentications/signIn.dart';
import 'package:crime_report_system/pages/welcome.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUp extends StatefulWidget {
  //const SignUp({ Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  String _password,_email,_name;

  checkAuthentication()async{
    _auth.authStateChanges().listen((user) {
      if(user!=null){
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
          Navigator.pushReplacementNamed(context, "/");
      }
     });
  }
  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
  }

  signUp()async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
    }
    try{
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      if(user!=null){
        // userUpdateInfo updateuser = userUpdateInfo; 
        await _auth.currentUser.updateProfile(displayName: _name);
        await Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
      }
    }
    catch(e){
            showError(e.errormessage);

          }
        }
 
 showError(String errormessage){
   showDialog(
     context: context, 
     builder: (BuildContext context){
        return AlertDialog(
          title: Text('ERROR'),
          content: Text(errormessage),

          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
            }, 
            child: Text('OK'))
          ],
        );
     });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container( 
                child: Image(
                  image:AssetImage('images/gym.jpg'),
                  ),
                  ),

              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // ignore: missing_return
                        validator: (input){
                          if(input.isEmpty)
                            return 'Name';
                          
                        },

                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefix: Icon(Icons.person),
                          //border:BorderRadius.circular(10),
                        ),
                        onSaved: (input)=>_name=input,
                        ),

                      TextFormField(
                        // ignore: missing_return
                        validator: (input){
                          if(input.isEmpty)
                            return 'Enter Email';
                          
                        },

                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefix: Icon(Icons.email_sharp),
                          //border:BorderRadius.circular(10),
                        ),
                        onSaved: (input)=>_email=input,
                        ),

                       TextFormField(
                        // ignore: missing_return
                        validator: (input){
                          if(input.length<6)
                            return 'Provide Minimum of 6 character';
                          
                        },

                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefix: Icon(Icons.lock_rounded),
                          //border:BorderRadius.circular(10),
                        ),
                        obscureText: true,
                        onSaved: (input)=>_password=input,
                        ),

                        RaisedButton(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          onPressed:signUp,
                          child: Text('Sign Up',
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
                    ),
                    ),
              ),
            ],
          ),
        ),
      )
    );
  }
}