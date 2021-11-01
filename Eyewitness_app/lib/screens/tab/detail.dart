import 'package:date_time_picker/date_time_picker.dart';
import 'package:eyewitness_app/providers/details_provider.dart';
import 'package:eyewitness_app/screens/components/speechText.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:eyewitness_app/screens/components/cameraWidget.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comment_box/comment/comment.dart';

class DetailReportPage extends StatefulWidget {
  const DetailReportPage({ Key key }) : super(key: key);

  @override
  _DetailReportPageState createState() => _DetailReportPageState();
}
final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
class _DetailReportPageState extends State<DetailReportPage> {

  //final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  
   TextEditingController _subject = new TextEditingController();
   TextEditingController _address = TextEditingController();
   TextEditingController _description = TextEditingController();
   TextEditingController _currentLocation =TextEditingController();
   TextEditingController _doi =TextEditingController();

   final FlutterTts _flutterTts = FlutterTts(); 
  @override
  Widget build(BuildContext context) {

speak()async{
  await _flutterTts.setLanguage("en-US");
  await _flutterTts.setPitch(1);
  await _flutterTts.speak("Hep! Help!! Help!!!");
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
          child: Text('OK')),
        ],
      );
  });
}
    final detailedProvider = Provider.of<DetailedProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
            //reverse:true,
            child: Column(
              children: [
                
                Padding(
                  padding: EdgeInsetsDirectional.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                
                                controller: _subject,
                          // ignore: missing_return
                                validator: (input){
                                  if(input.isEmpty)
                                    return 'Incident Subject';
                                },

                                  decoration: InputDecoration(
                                    
                                    border:OutlineInputBorder(),
                                    hintText: "Crime",
                                    labelText: 'Type of Crime',
                                    //prefix: Icon(Icons.),
                              
                                ),
                                onChanged: (value){
                                  detailedProvider.changeSubject(value);
                                },
                                    //onSaved: (input)=>_name=input,
                          ),
                            ),
                          Padding(
                              padding: EdgeInsets.all(8.0),
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
                                      _doi = value as TextEditingController;
                                  });
                                }
                              },
        
                            )
                          ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _address,
                          // ignore: missing_return
                                  validator: (input){
                                    if(input.isEmpty)
                                      return 'Enter the address';  
                                    },

                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Address',
                                    hintText: 'Enter Address'
                                      ),
                                      onChanged: (value){
                                        detailedProvider.changeaAddress(value);
                                },
                                    //onSaved: (input)=>_email=input,
                                ),
                              ),
                          Row(
                            children: [
                               Container(
                                 width:260,
                                 child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                        controller: _description,
                                        maxLines: 3,
                          // ignore: missing_return
                                        validator: (input){
                                          if(input.isEmpty)
                                            return 'Enter Description';  
                                          },

                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Describe scene',
                                          labelText: 'Description of the event',
                            
                                            ),
                                        onChanged: (value){
                                          detailedProvider.changeDescription(value);
                                  },
                                          //onSaved: (input)=>_email=input,
                                  ),
                              ),
                               ),


                              AvatarGlow(
                                // animate: isListening,
                              endRadius: 30,
                              glowColor: Colors.grey[700],
                              child: IconButton(
                                icon: Icon(Icons.mic_none,
                                  color: Colors.black,
                                    size: 30,
                                    ), 
                                    onPressed: (){
                                      Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:(context)=> SpeechToText(),
                                    ),
                                  );
                                    },
                                    
                                ),
                              ),
                            ],
                         ), 
            
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(top:20,left: 10),
                            child: Text("EVIDENCE OF THE CRIME",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.indigo[900],
                                 fontWeight: FontWeight.bold
                                ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CameraComponent(),
                          ),

                          RaisedButton(
                            onPressed: (){
                              try{
                                 detailedProvider.saveDetail();
                                 showDialog(
                                    context: context, 
                                    builder: (BuildContext context){
                                    return AlertDialog(
                                      //title: Text('ERROR'),
                                      content: Text("Report successfully"),
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
                              catch(error){
                                  showError(error);
                              }   
                            },
                            child: Text('Report',
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

                // Row(
                //             children: [
                //               CircleAvatar(
                //                 backgroundColor: Colors.orangeAccent,
                //                 child: IconButton(
                //                   icon: Icon(
                //                     Icons.add_a_photo,
                //                     color: Colors.black,
                //                     ), 
                //                     onPressed: () {  },
                //                 ),
                //                 ),

                //                 CircleAvatar(
                //                 backgroundColor: Colors.orangeAccent,
                //                 child: IconButton(
                //                   icon: Icon(
                //                     Icons.record_voice_over,
                //                     color: Colors.black,
                //                     ), 
                //                     onPressed: () { 
                //                       speak();
                //                      },
                //                 ),
                //                 ),
                           



                //             ],
                //           ),
              ],
            
          ),
        
      ),
    );
  }

//   Future toggleRecording()=>SpeechApi.toggleRecording(
//     onResult: (text)=>setState(()=> this.text = text,
//     ), 
//     onListening: (isListening) {  
//        setState(()=>this.isListening = isListening);
//     });
 }






