// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:login/blocs/application_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';


// class mapPage extends StatefulWidget {
//   const mapPage({ Key  key }) : super(key: key);

//   @override
//   _mapPageState createState() => _mapPageState();
// }


// class _mapPageState extends State<mapPage> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future<void> requestPermission() async 
//     { await Permission.location.request(); }
//   }

  
 
//   @override
//   Widget build(BuildContext context) {
//     final applicationBloc = Provider.of<ApplicationBloc>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title:Text('Google Map '),
//         actions: [],
//         ),

//       body: (applicationBloc.currentLocation == null)
//       ?Center(child: CircularProgressIndicator(),)
//       :ListView(
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Search Location'
//             ),
//           ),
//           Container(
//             height: 300,
//             child: GoogleMap(
//             myLocationEnabled: true,
//             // onMapCreated: onMapCreated,
//             // markers: _marker,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(applicationBloc.currentLocation.latitude,applicationBloc.currentLocation.longitude),
//               zoom: 15,
//               )
//         ),
//           ),
//         ],
         
//       )
//     );
//   }
// }