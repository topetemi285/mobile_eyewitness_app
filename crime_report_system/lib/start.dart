import 'package:crime_report_system/authentications/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'authentications/signIn.dart';

class Start extends StatefulWidget {
  //const Start({ Key? key }) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  navigateToSignIn()async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignIn()));
    }
  
  navigateToRegister()async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 35,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image(
                    image: AssetImage('images/gym.jpg')
                    ,),
                    ),
              ),
                  SizedBox(height:20.0),

            RichText(
              text: TextSpan(
                text: 'Welcome to', style: TextStyle(
                  color:Colors.deepOrangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                children: [
                  TextSpan(
                    text: 'MobileEyeWitnessApp', 
                    style: TextStyle(
                      color:Colors.indigo, 
                      fontSize: 23, 
                      fontWeight: FontWeight.bold
                      )
                  ),
                ]
              )),
              Text('Just a click could safe a life', 
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 15,
                fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    onPressed: navigateToSignIn,
                    child: Text('Sign IN',
                    style: TextStyle(
                      fontSize:20, 
                      color: Colors.white,
                      fontWeight: FontWeight.bold ),),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                        ),
                        color: Colors.deepOrange,
                    ),

                    SizedBox(width: 20.0,),

                  RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    onPressed: navigateToRegister,
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
              SizedBox(height: 30,),
              SignInButton(
                      Buttons.Google,
                      text: "Sign up with Google",
                      onPressed: () {},
                    )
            ],
          ),
          
        ),
      ),
    );
  }
}