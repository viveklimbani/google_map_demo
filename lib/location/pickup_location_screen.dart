// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../common/resources/images.dart';
// import '../common/utils/common_functions.dart';
// import '../data/selected_address_location.dart';
// import 'detect_current_location.dart';
//
// class PickUpLocationScreen extends StatefulWidget {
//   const PickUpLocationScreen({Key? key}) : super(key: key);
//
//   @override
//   _PickUpLocationScreenState createState() => _PickUpLocationScreenState();
// }
//
// class _PickUpLocationScreenState extends State<PickUpLocationScreen> {
//   final pickupAddressController = TextEditingController();
//
//   SelectedAddressLocation _selectedAddressLocation = SelectedAddressLocation();
//   DetectCurrentLocation _detectCurrentLocation = DetectCurrentLocation();
//
//   ///Provider
//
//   CameraPosition _initialLocation =
//   CameraPosition(target: LatLng(0, 0), zoom: 14);
//
//   late GoogleMapController mapController;
//   @override
//   Widget build(BuildContext context) {
//     // locationData = Provider.of<LocationProvider>(context);
//     return Scaffold(
//       body: mainLayout,
//     );
//   }
//   get mainLayout => Container(
//     height:
//     MediaQuery.of(context).viewInsets.bottom > 0.0 ? 200 : 400,
//     child: Stack(
//       children: [
//         googleMap,
//         centerMarker,
//       ],
//     ),
//   );
//
//
//   get googleMap => GoogleMap(
//     initialCameraPosition: _initialLocation,
//     myLocationEnabled: true,
//     myLocationButtonEnabled: false,
//     mapType: MapType.normal,
//     zoomGesturesEnabled: true,
//     zoomControlsEnabled: false,
//     onMapCreated: (GoogleMapController controller) {
//       mapController = controller;
//       mapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng(selectedAddressLocation.lat ?? 0,
//                 selectedAddressLocation.lng ?? 0),
//             zoom: 15.0,
//           ),
//         ),
//       );
//     },
//     onCameraMove: (CameraPosition position) {
//       // locationData.onCameraMove(position);
//     },
//   );
//
//   get centerMarker => Center(
//     child: Container(
//       height: 50,
//       margin: const EdgeInsets.only(bottom: 48),
//       child: Image.asset(
//         Images.icMarker,
//         color: Colors.black,
//       ),
//     ),
//   );
//
//   get bottomDetailsSheet => DraggableScrollableSheet(
//     initialChildSize: .55,
//     minChildSize: .5,
//     maxChildSize: .91,
//     builder: (BuildContext context, ScrollController scrollController) {
//       return Container(
//         color: Colors.white,
//         child: ListView(
//           controller: scrollController,
//           padding: EdgeInsets.zero,
//           children: [
//             const SizedBox(height: 12,),
//             const Padding(
//               padding:
//               EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 "Select Location",
//                 style: TextStyle(fontSize: 12),
//             ),),
//             const SizedBox(height: 20,),
//             useCurrentLocationBtn,
//             const Divider(),
//             // spacingVerticalXxSmall,
//             // savedLocation,
//             // recentLocation,
//             // spacingVerticalXLarge
//           ],
//         ),
//       );
//     },
//   );
//
//   get googleAutoFillTextField => Container(
//     height: 40,
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: GooglePlaceAutoCompleteTextField(
//       textEditingController: pickupAddressController,
//       googleAPIKey: GOOGLE_MAPS_API_KEY,
//       getPlaceDetailWithLatLng: (detail) {
//         dismissKeyboard(context);
//         _selectedAddressLocation.lat = double.parse(detail.lat!);
//         _selectedAddressLocation.lng = double.parse(detail.lng!);
//
//         setState(() {
//           mapController.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(double.parse(detail.lat ?? "0"),
//                     double.parse(detail.lng ?? "0")),
//                 zoom: 15.0,
//               ),
//             ),
//           );
//         });
//
//         // BotToast.closeAllLoading();
//       },
//       itmClick: (detail) {
//         dismissKeyboard(context);
//         _selectedAddressLocation.address1 =
//             detail.structuredFormatting?.mainText ?? "";
//         _selectedAddressLocation.address2 =
//             detail.structuredFormatting?.secondaryText ?? "";
//       },
//       isLatLngRequired: true,
//       inputDecoration: InputDecoration(
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(RadiusConst.smallBox),
//           borderSide: BorderSide(color: Colors.black),
//         ),
//         contentPadding:
//         const EdgeInsets.symmetric(horizontal: Spacing.xxSmall),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(RadiusConst.smallBox),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(RadiusConst.smallBox),
//           borderSide: BorderSide(color: Colors.black),
//         ),
//         prefixIcon: Container(
//           padding: const EdgeInsets.only(right: 10),
//           height: 10,
//           width: 10,
//           child: Padding(
//             padding: const EdgeInsets.all(Spacing.xSmall11),
//             child: SvgPicture.asset(
//               Images.icSearch3Svg,
//             ),
//           ),
//         ),
//         filled: true,
//         hintStyle: TextStyles.textFieldStyle.copyWith(
//           color: MGColors.textColor.withOpacity(0.5),
//           fontSize: TextSize.font11,
//         ),
//         hintText: StringResource.searchAddressStreet,
//         fillColor: Colors.white70,
//       ),
//     ),
//   );
//
//   get useCurrentLocationBtn => Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: InkWell(
//       onTap: () => onDetectLocationClick(),
//       child: Row(
//         children: [
//           const Icon(Icons.my_location, size: 12,),
//
//           SizedBox(height: 10,),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Use Current Locations",
//                 style: TextStyle(fontSize: 12),
//               ),
//               selectedAddressLocation.address2 != null
//                   ? Container(
//                 width: MediaQuery.of(context).size.width - 100,
//                 child: Text(
//                   "${selectedAddressLocation.address2}",
//                   style: const TextStyle(fontSize: 12),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   softWrap: false,
//                 ),
//               )
//                   : SizedBox()
//             ],
//           ),
//           const Spacer(),
//           const Icon(
//             Icons.arrow_forward_ios,
//             size: 20,
//           )
//         ],
//       ),
//     ),
//   );
//
//   get savedLocation => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Text(
//           StringResource.savedLocation,
//           style: TextStyles.smallText.copyWith(
//             color: MGColors.textColor,
//           ),
//         ),
//       ),
//       spacingVerticalNormal14,
//       ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext, int) => showAddressWidget(int),
//         itemCount: 4,
//       ),
//     ],
//   );
//
//   get recentLocation => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
//         child: Text(
//           StringResource.recentLocation,
//           style: TextStyles.smallText.copyWith(
//             color: MGColors.textColor,
//           ),
//         ),
//       ),
//       spacingVerticalNormal14,
//       ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext, int) => showAddressWidget(int),
//         itemCount: 20,
//       ),
//     ],
//   );
//
//   Widget showAddressWidget(int index) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Column(
//                 children: [
//                   SvgPicture.asset(
//                     Images.icHomeSvg,
//                     height: DimenConst.iconSize,
//                     width: DimenConst.iconSize,
//                   ),
//                   Text(
//                     "4 km",
//                     style: TextStyles.textFieldStyle.copyWith(
//                       fontSize: TextSize.font9,
//                     ),
//                   ),
//                 ],
//               ),
//               spacingHorizontalXSmall,
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Home',
//                     style: TextStyles.textFieldStyle.copyWith(
//                         fontSize: TextSize.font9, fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     "4 bunglow Road, andheri, lakhand wala, Mumbai",
//                     style: TextStyles.textFieldLabelStyle,
//                   ),
//                 ],
//               )
//             ],
//           ),
//           spacingVerticalXxSmall,
//           Divider(),
//         ],
//       ),
//     );
//   }
//
//   onDetectLocationClick() async {
//     dismissKeyboard(context);
//     // BotToast.showLoading();
//     var address = await _detectCurrentLocation.getCurrentAddress();
//
//     setState(() {
//       if (address != null) {
//         // pickupAddressController.text = address.address?.streetAddress?? "";
//
//         if (address.latitude != null || address.longitude != null) {
//           mapController.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(address.latitude ?? 0, address.longitude ?? 0),
//                 zoom: 18.0,
//               ),
//             ),
//           );
//         }
//
//         // _currentAddress=  address.address?.streetAddress ??
//         //       "${address.address?.streetNumber ?? ""} ${address.address?.streetAddress ?? ""} ${address.address?.postal ?? ""}";
//
//         selectedAddressLocation.lat = address.latitude;
//         selectedAddressLocation.lng = address.longitude;
//         selectedAddressLocation.address1 = address.address;
//         selectedAddressLocation.address2 = address.address;
//       }
//     });
//
//     // context.router.pushNamed(ROUTE_CURRENT_LOCATION);
//   }
// }
