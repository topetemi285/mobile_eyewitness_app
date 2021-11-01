import 'package:eyewitness_app/screens/histories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'map/google_map_screen.dart';
import 'tab/detail.dart';
import 'tab/emergence.dart';



class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
 final FirebaseAuth _auth = FirebaseAuth.instance;
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

  TabController _tabController;

  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
    this.getUser();
    _tabController =TabController(length: 2, vsync: this);
  }

  GlobalKey<ScaffoldState>drawerKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      )
    );
    // if(isLoggedIn){
    return Scaffold(
              key:drawerKey,
              appBar: AppBar(
                  backgroundColor: Colors.grey[700],
                  elevation: 1,
                  leading:IconButton(
                  icon:Icon(Icons.menu,color:Colors.white),
                  onPressed:(){
                    drawerKey.currentState.openDrawer();
                  }
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search,color: Colors.white,),
                      onPressed:() {},
                  ),                // 
              ],


                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text('Emergence'),
                      ),
                      Tab(
                        child: Text('Detail Reports'),
                      ),  
                    ],
                    controller: _tabController,
                    //indicator: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  bottomOpacity: 1,
                ),

                
              drawerEdgeDragWidth: 0,
              //drawer: MainDrawer(),
              drawer:Drawer(
                child:ListView(
                  children:[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color:Colors.grey[900],
                          borderRadius:BorderRadius.circular(16),
                      ),
                    
                        
                       accountEmail:Text("${_auth.currentUser.email}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0
                        ),),
                     

                      accountName:
                      Text("${_auth.currentUser.displayName}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0
                        ),),
                      
                      currentAccountPicture:ClipRRect(
                        borderRadius:BorderRadius.circular(70),
                        child:
                         Image(
                          image:NetworkImage("https://th.bing.com/th/id/OIP.7R0PTlj7Bd4dcQYePwYjfwHaLp?w=115&h=180&c=7&r=0&o=5&pid=1.7"),
                          width:70,
                          height:70,
                          fit:BoxFit.cover,
                        )
                       
                        ),
                      ),
                  

                    ListTile(
                      title:Text("Home"),
                      leading:Icon(Icons.home_sharp,color:Colors.black),
                      onTap: (){
                          Navigator.of(context).pushReplacementNamed("welcome");
                      },
                    ),
                    ListTile(
                      title:Text("Message"),
                      leading:Icon(Icons.chat, color:Colors.black),
                      onTap: (){
                        Navigator.of(context).pushReplacementNamed("SmsFile");
                      },
                    ),
                    ListTile(
                      title:Text("History", ),
                      leading:Icon(Icons.history_edu_outlined, color:Colors.black),
                      onTap: (){
                          Navigator.of(context).pushReplacementNamed("history");
                      },
                    ),
                    
                    ListTile(
                      title:Text("Notifications"),
                      leading:Icon(Icons.notifications, color:Colors.black),
                      onTap: (){
                        Navigator.of(context).pushReplacementNamed("camera");
                      },
                    ),

                   ListTile(
                      title:Text("My Location"),
                      leading:Icon(Icons.location_on, color:Colors.black,),
                      onTap:(){
                          Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context)=>GoogleMapScreen()));     
                      }
                      //GoogleMapScreen()
                    ),
                    ListTile(
                      title:Text("Settings"),
                      leading:Icon(Icons.settings, color: Colors.black,),
                      onTap: (){}    
                    ),

                    ListTile(
                      title:Text("logOut"),
                      leading:Icon(Icons.logout),
                      onTap: (){
                        signOut();
                      }
                    )
                  ]
                )
              ),
          
              body:TabBarView(
                    children: <Widget>[
                      EmergencePage(),
                      DetailReportPage(), 
               ],
               controller: _tabController,
             ),
            );
      }
}

