import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eyewitness_app/providers/userManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'signIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  String _password,_email,_name,_mobileNumber,_photoUrl,_dob,_address,_occupation,_currentLocation;
  //Timestamp _dob;
  String _selectedGender = 'male';

  checkAuthentication()async{
    _auth.authStateChanges().listen((user) async{
      if(user!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
          // Navigator.pushReplacementNamed(context, "/");
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
        await _auth.currentUser.updateProfile(
          displayName: _name,photoURL: _photoUrl);
        userManagement(_name,_occupation,_currentLocation,_dob,_address,_mobileNumber,_photoUrl);
      }
      showDialog(context: context, 
            builder: (BuildContext context){
              return AlertDialog(
                content: Text("Registeration Successfully"),
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
    
      on FirebaseAuthException catch (e){
            if(e.code=='weak-password'){
                showDialog(context: context, 
                  builder: (BuildContext context){
                    return AlertDialog(
                      content: Text("The password provided is to weak \n(uppercase,atleast 7 character and a character)"),
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
           else if(e.code=='email already exist-in-use'){
             showDialog(context: context, 
            builder: (BuildContext context){
              return AlertDialog(
                content: Text("Account aleady exists for the email"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text('OK'))
                ],
              );
            });
           } //print(e);
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
              ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
            }, 
            child: Text('OK'))
          ],
        );
     });
 }


 File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });


    //String _selectedDate;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                 children: [
                     Padding(
                        padding: EdgeInsets.only(top: 50, left: 20),
                          child: Text("Personal Details", 
                            style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                              ),
                          ),

                      Padding(
                        padding: EdgeInsets.only(top:5),
                          child: Text("please enter your details", 
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                              ),
                          ),
                         ],
                       ),

              Container(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                   key: _formKey,
                  child: Column(
                   
                    children: [
                       GestureDetector(
                          onTap: (){ 
                            getImage();
                            },
                          child: Center(
                              child:CircleAvatar(
                                
                                radius: 70,
                                child: ClipRRect(
                                  borderRadius:BorderRadius.circular(80),
                                  child: _image == null
                                    ? Icon(Icons.add_a_photo, color: Colors.white,)
                                    : Image.file(_image,
                                        fit: BoxFit.cover,
                                    ),
                                ),
                                
                                backgroundColor: Colors.black,
                              ),
                          ),
                        ),
                     
                          TextFormField(
                        // ignore: missing_return
                            validator: (input){
                              if(input.isEmpty)
                                return 'Enter Name';
                            },

                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefix: Icon(Icons.person),
                          //border:BorderRadius.circular(10),
                            ),
                                onSaved: (input)=>_name=input,
                        ),

                            TextFormField(
                              validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
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
                                if(input.isEmpty)
                                    return 'enter mobile number';
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                                prefix: Icon(Icons.call_end_outlined),
                          //border:BorderRadius.circular(10),
                              ),
                               obscureText: true,
                                onSaved: (input)=>_mobileNumber=input,
                                
                            ),
                    Padding(
                      padding: EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Please let us know your gender:'),
                            ListTile(
                              leading: Radio(
                                value: 'male',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                     _selectedGender = value;
                              });
                            },),
                            title: Text('Male'),
                            ),
                            ListTile(
                                leading: Radio(
                                value: 'female',
                  			  groupValue: _selectedGender,
                  			  onChanged: (value) {
                    			setState(() {
                      				_selectedGender = value;
                    			});
                  				},
                			),
                		    title: Text('Female'),
              				),
              			    SizedBox(height: 25),
              			    Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
            				],
          			)),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:DateTimePicker(
                        initialValue: '',
                        type: DateTimePickerType.date,
                        dateLabelText: 'Select Date of Birth',
                        firstDate: DateTime(1960),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                        validator: (value){
                          return null;

                        },
                        onChanged: (value){
                          if(value.isNotEmpty){
                            setState((){
                              _dob = value;
                            });
                          }
                        },
                        

                      )
                    ),

                   TextFormField(
                        // ignore: missing_return
                    validator: (input){
                      if(input.isEmpty)
                        return 'Enter Address';
                          
                        },

                    decoration: InputDecoration(
                        labelText: 'Address',
                        prefix: Icon(Icons.location_city_outlined),
                          //border:BorderRadius.circular(10),
                        ),
                        onSaved: (input)=>_address=input,
                        ),

                    TextFormField(
                        // ignore: missing_return
                      validator: (input){
                        if(input.isEmpty)
                          return 'Enter Occupation';
                          
                        },

                      decoration: InputDecoration(
                        labelText: 'Occupation',
                          prefix: Icon(Icons.work_off_outlined),
                          //border:BorderRadius.circular(10),
                        ),
                        onSaved: (input)=>_occupation=input,
                        ),

      
                   TextFormField(
                        // ignore: missing_return
                      validator: Validators.compose([
                                Validators.required('Name is required'),
                                Validators.minLength(8, 'Name cannot be less than 8 characters'),
                                //Validators.maxLength(10, 'Name cannot be greater than 10 characters'),
                                //Validators: Validators.max(5, 'Value greater than 5 not allowed'),
                                Validators.required('Password is required'),
                                Validators.patternString(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', 'Invalid Password')
                              ]),

                    decoration: InputDecoration(
                      
                      labelText: 'Password',
                        prefix: Icon(Icons.lock_rounded),
                          //border:BorderRadius.circular(10),
                        ),
                        obscureText: true,
                        onSaved: (input)=>_password=input,
                        ),

                        TextFormField(
                        // ignore: missing_return
                        validator: (input){
                          if(input.isEmpty)
                            return 'Enter current Location';
                          
                        },

                        decoration: InputDecoration(
                          labelText: 'Current Location',
                          prefix: Icon(Icons.location_on,)
                          //border:BorderRadius.circular(10),
                        ),
                        onSaved: (input)=>_currentLocation=input,
                        ),

                        
                        

                        RaisedButton(
                          //padding: EdgeInsets.only(left: 30, right: 30),
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