// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   GoogleMapController? mapController;
//   String? _mapStyle;
//
//
//
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(23.0673, 72.5567),
//     zoom: 14.4746,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//
//     rootBundle.loadString('assets/style/map_style.txt').then((string) {
//       _mapStyle = string;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GoogleMap(
//           initialCameraPosition: _kGooglePlex,
//           onMapCreated: (GoogleMapController controller) {
//             mapController = controller;
//             mapController?.setMapStyle(_mapStyle);
//             mapController?.animateCamera(
//               CameraUpdate.newCameraPosition(
//                 const CameraPosition(
//                   target: LatLng(23.0673, 72.5568),
//                   zoom: 15.0,
//                 ),
//               ),
//             );
//           },
//           onCameraMove: (CameraPosition position) {
//
//           },
//         ),
//       ),
//     );
//   }
// }
