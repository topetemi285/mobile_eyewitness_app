//import 'package:crime_report_system/authentications/signUp.dart';
import 'package:crime_report_system/pages/welcome.dart';
//import 'package:crime_report_system/start.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:crime_report_system/pages/welcome.dart';

//import 'dart:async';

// class SignIn extends StatefulWidget {
//   //const SignIn({ Key? key }) : super(key: key);

//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   String _email,_password;
//   GlobalKey<FormState>_formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login"),
//         ),

//         body: Form(
//            key: _formKey,
//            child: Column(
//              children: [
//                TextFormField(
                
//                  validator:(input){
//                    if (input.isEmpty){
//                      return "Please enter your email";
//                    }
//                  },
//                  onSaved:(input)=>{
//                    _email = input
//                  },
//                  decoration:InputDecoration(
//                    labelText:"Email",
//                  )
//                ),

//                TextFormField(
//                  validator:(input){
//                    if (input.length<6){
//                      return "atleast 6 characters";
//                    }
//                  },
//                  onSaved:(input)=>{
//                    _password = input
//                  },
//                  decoration:InputDecoration(
//                    labelText:"password",
//                  ),
//                  obscureText: true,
//                ),

               
//                RaisedButton(
//                  onPressed:logIn,
                 
//                  child: Text("Login"),
//                  )

//              ],) ,)
      
//     );
//   }

//   Future<void> logIn() async{
//     final formState = _formKey.currentState;
//     if(formState.validate()){
//       formState.save();
//       try{
        
//         UserCredential user =await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((value) => 
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()))
//         );
        
//       }catch(e){
//         print(e.message);
//       }
      
//        //FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
//     }
//   }
// }

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
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
        // Navigator.pushReplacementNamed(context, "/");
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
          _formKey.currentState.save();
          try{
            UserCredential user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
          }catch(e){
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


 navigateToSignUp()async{
   Navigator.push(context, MaterialPageRoute(builder: (context)=>navigateToSignUp()));
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
                          onPressed:login,
                          child: Text('Sign In',
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

                 GestureDetector(
                   child: Text('Create an account?'),
                   onTap: navigateToSignUp,
                 )
             ],
          ),
        ),
      )
    );
  }
}