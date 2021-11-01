import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eyewitness_app/screens/components/cameraWidget.dart';
// import 'package:eyewitness_app/services/firestore_services.dart';
import 'package:provider/provider.dart';
import 'package:eyewitness_app/providers/details_provider.dart';
import 'package:eyewitness_app/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authentications/signIn.dart';
import 'authentications/signUp.dart';
import 'providers/emergence_provider.dart';
import 'screens/histories.dart';
import 'screens/homePage.dart';
import 'blocs/application_bloc.dart';
import 'screens/start.dart';
import 'screens/tab/smsPage.dart';
// import 'services/firestore_services.dart';
import 'services/auth_services.dart';
import 'widget/widget_provider.dart';



void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());}
  

class MyApp extends StatefulWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //var firestoreServices = FirestoreServices();
    return MultiProvider(
      providers:[

        ChangeNotifierProvider(create: (context)=> DetailedProvider()),
        ChangeNotifierProvider(create: (context)=> EmergenceProvider()),
        ChangeNotifierProvider(create: (context)=> ApplicationBloc()),

        //StreamProvider(create: (contex)=>firestoreServices.getDetail()),
      ],
      
      child:WidgetProvider(
         auth: AuthService(),
          db: FirebaseFirestore.instance,
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.white,
        ),
        home:SplashScreen(),

        routes: <String,WidgetBuilder>{

            "Login" : (BuildContext context)=>SignIn(),
            "SignUp":(BuildContext context)=>SignUp(),
            "start":(BuildContext context)=>Start(),
            "welcome":(BuildContext context)=>Welcome(),
            'history':(BuildContext context)=>Histories(),
            'camera':(BuildContext context)=>CameraComponent(),
            'SmsFile':(BuildContext context)=>SmsFile(),
            
          },

          ),
      )
    ); 
}
}
