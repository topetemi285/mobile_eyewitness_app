import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class CameraComponent extends StatefulWidget {
  const CameraComponent({ Key key }) : super(key: key);

  @override
  _CameraComponentState createState() => _CameraComponentState();
}

class _CameraComponentState extends State<CameraComponent> {

 File _image;
  final picker = ImagePicker();

  Future<void>_showChoiceDialog(BuildContext context){

    _openCamera(BuildContext context)async{
     final pickedFile = await picker.getImage(source: ImageSource.camera);
      setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.of(context).pop();
    }

    _openGallary(BuildContext context)async{
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
      Navigator.of(context).pop();
    }

    _openVideo()async{
      
    }

    _openRecord()async{
      
    }


    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.grey[900],
        elevation: 1,
        title: Text("Evidence Choice", 
        style: TextStyle(color: Colors.white),),
        content: SingleChildScrollView(
          
          child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.camera_outlined,color: Colors.white),
                          onTap: (){
                            _openCamera(context);
                          },
                        ),
                        Text("pictures", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(right:8.0)),

                    Column(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.image,color: Colors.white),
                          onTap: (){
                            _openGallary(context);
                          },
                        ),
                        Text("Gallary", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(right:8.0)),
                    Column(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.video_call,color: Colors.white),
                          onTap: (){
                            //_openVideo();
                          },
                        ),
                        Text("Video", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(right:8.0)),

                    Column(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.mic, color: Colors.white),
                          onTap: (){
                            //_openRecord();
                          },
                        ),
                        Text("Record", style: TextStyle(color: Colors.white),)
                      ],
                    ),


                  ],
          ),
        ),
      );
    });
  }

  Widget _decideImageView(){
    if (_image==null){
      return Text("No Image Selected");
    }
    else{
      return Image.file(_image, width: 100, height:400);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _decideImageView(),

                 RaisedButton(
                   onPressed: ()=>{
                     _showChoiceDialog(context),
                 },
                 child: Text("Select Image"),)
              ],
            ),
          ) ,
           
      
    );
  }
}