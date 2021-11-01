import "package:flutter/material.dart";
import "dart:async";


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            (){
           //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Welcome()),);
           Navigator.pushReplacementNamed(context, "welcome");

        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[700],
      body: Stack(
                fit:StackFit.expand,
                children:<Widget>[
                  Positioned(
                    top: 100,
                    left: 130,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('images/eye.jpeg'),
                          ),
                        ),
                      ),
                      radius: 50,),
                  ),
                  Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children:<Widget>[
                        Expanded(
                          flex:2,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                SizedBox(height: 100),
                                Padding(
                                  padding: EdgeInsets.only(left:10),
                                  child: Text("Mobile Eyewitness",
                                      style: TextStyle(
                                          fontSize: 38,
                                          color:Colors.white,
                                           // fontFamily: "SchoolBell",
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:<Widget>[
                                CircularProgressIndicator(),
                                Padding(
                                  padding:EdgeInsets.only(top: 23.0),
                                ),
                                Text("Safty first",
                                    style: TextStyle(color:Colors.white,
                                        fontSize: 14.0, fontWeight: FontWeight.bold)),
                              ]
                          ),
                        ),
                      ]
                  )
                ]
            )
    );
        
  }
}