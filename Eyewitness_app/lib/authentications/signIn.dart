import 'package:eyewitness_app/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

import 'signUp.dart';


class SignIn extends StatefulWidget {
  const SignIn({ Key key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  String _email,_password;

  checkAuthentication() async{
    _auth.authStateChanges().listen((user){
      if(user !=null ){
       print(user);
      //  Navigator.pushReplacementNamed(context, "/");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Welcome()));
      }
    });
  }

    @override
    void initState(){
      super.initState();
      this.checkAuthentication();
    }
 

    login()async{
      if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          try{
           UserCredential user = await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
            showDialog(context: context, 
            builder: (BuildContext context){
              return AlertDialog(
                content: Text("Login Successfully"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text('OK'))
                ],
              );
            });
             // Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
          }
          on FirebaseAuthException catch(e){
            if(e.code == 'user-not-found'){
              showDialog(context: context, 
            builder: (BuildContext context){
              return AlertDialog(
                content: Text("No user found for that emai. "),
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
            else if(e.code == 'wrong-password'){
              showDialog(context: context, 
            builder: (BuildContext context){
              return AlertDialog(
                content: Text("Wrong password provided for that user"),
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
          }
          catch(e){
            showError(e.errormessage);
            //print('this is the error'+ e);
          }
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


 navigateToSignUp()async{
   Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container( 
                  child: Image(
                    image:AssetImage('images/eye.jpeg',),
                    width: 200,
                    height: 200,
                    ),
                    ),
              ),

              Container(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                   key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            prefix: Icon(Icons.email_sharp),
                            //border:BorderRadius.circular(10),
                          ),
                          onSaved: (input)=>_email=input,
                          ),
                      ),

                       Padding(
                         padding: const EdgeInsets.all(20),
                         child: TextFormField(
                          // ignore: missing_return
                          validator: (input){
                            if(input.length<6)
                              return 'Provide Minimum of 6 character with uppercase\nand a character';
                            
                          },

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Password",
                            labelText: 'Password',
                            prefix: Icon(Icons.lock_rounded),
                            //border:BorderRadius.circular(10),
                          ),
                          obscureText: true,
                          onSaved: (input)=>_password=input,
                          ),
                       ),

                        RaisedButton(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          onPressed:login,
                          child: Text('Sign In',
                            style: TextStyle(
                              fontSize:20, 
                              color: Colors.white,
                              fontWeight: FontWeight.bold ),),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.indigo[900],
                          ),
                        ],
                      ),
                    ),
                 ),

                 GestureDetector(
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Text('Create an account?', style: TextStyle(fontSize: 20),),
                   ),
                   onTap: navigateToSignUp,
                 )
             ],
          ),
        ),
      )
    );
  }
}