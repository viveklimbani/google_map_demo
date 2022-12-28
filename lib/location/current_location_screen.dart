import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../common/utils/common_functions.dart';
import 'detect_current_location.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  DetectCurrentLocation _detectCurrentLocation = DetectCurrentLocation();

  CameraPosition _initialLocation =
  CameraPosition(target: LatLng(0, 0), zoom: 14);

  late GoogleMapController mapController;

  String? _mapStyle;

  ///Provider
  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/style/map_style.txt').then((string) {
      _mapStyle = string;
    });

    // rootBundle.loadString(MapStyle.mapStyle).then((string) {
    //   _mapStyle = string;
    // });
  }
  @override
  Widget build(BuildContext context) {
    return mainLayout;
  }
  get mainLayout => SafeArea(
    child: Scaffold(
      body: GestureDetector(
        onTap: () {
          dismissKeyboard(context);
        },
        child: Stack(
          children: [
            googleMap,
            currentLocationBtn,
            centerMarker,
          ],
        ),
      ),
    ),
  );


  get googleMap => GoogleMap(
    initialCameraPosition: _initialLocation,
    myLocationEnabled: true,
    myLocationButtonEnabled: false,
    mapType: MapType.normal,
    zoomGesturesEnabled: true,
    zoomControlsEnabled: false,
    onMapCreated: (GoogleMapController controller) {
      mapController = controller;
      mapController.setMapStyle(_mapStyle);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(selectedAddressLocation.lat ?? 0,
                selectedAddressLocation.lng ?? 0),
            zoom: 15.0,
          ),
        ),
      );
    },
    onCameraMove: (CameraPosition position) {
      // mapController.setMapStyle(_mapStyle);
      // locationData.onCameraMove(position);
    },
  );

  get currentLocationBtn => SafeArea(
    child: Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(
            right: 12,
            bottom: MediaQuery.of(context).size.height * 0.27),
        child: ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              onTap: () => onDetectLocationClick(),
              splashColor: Colors.orange, // inkwell color
              child: Container(
                padding: const EdgeInsets.all(08),
                child: const Icon(Icons.my_location, size: 36,),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  get centerMarker => Center(
    child: Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 36),
      child: const Icon(Icons.my_location, size: 40,),
    ),
  );

  // Widget bottomDetailsSheet() {
  //   return DraggableScrollableSheet(
  //     initialChildSize: .25,
  //     minChildSize: .25,
  //     maxChildSize: .25,
  //     builder: (BuildContext context, ScrollController scrollController) {
  //       return Container(
  //         color: Colors.white,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             spacingVerticalXxxSmall,
  //             Expanded(
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         spacingVerticalLarge,
  //                         shortAddress,
  //                         spacingVerticalXxxSmall,
  //                         longAddress,
  //                       ],
  //                     ),
  //                   ),
  //                   spacingHorizontalXxSmall,
  //                   changeBtn,
  //                   spacingHorizontalLarge,
  //                 ],
  //               ),
  //             ),
  //             spacingVerticalLarge,
  //             confirmLocationBtn,
  //             spacingVerticalLarge,
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  get shortAddress => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Icon(Icons.location_on),
        Text(
          selectedAddressLocation.address1?.split(",")[1] ?? "N/A",
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );

  get longAddress => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      selectedAddressLocation.address2 ?? "N/A",
      style: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.5)),
    ),
  );

  get changeBtn => InkWell(
    onTap: () => onChangeBtnClick(),
    child: Text(
      "Change",
      style: const TextStyle(fontSize: 12)
          .copyWith(decoration: TextDecoration.underline),
    ),
  );

  // get confirmLocationBtn => Padding(
  //   padding: const EdgeInsets.symmetric(horizontal: 16),
  //   child: RSSolidButton(
  //     title: StringResource.confirmLocationBtn,
  //     isLoading: false,
  //     onPress: () => onNextBtnClick(),
  //   ),
  // );

  onDetectLocationClick() async {
    dismissKeyboard(context);

    var address = await _detectCurrentLocation.getCurrentAddress();

    setState(() {
      if (address != null) {
        if (address.latitude != null || address.longitude != null) {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(address.latitude ?? 0, address.longitude ?? 0),
                zoom: 18.0,
              ),
            ),
          );
        }

        selectedAddressLocation.lat = address.latitude;
        selectedAddressLocation.lng = address.longitude;
        selectedAddressLocation.address1 = address.address;
        selectedAddressLocation.address2 = address.address;
      }
    });
  }

  onChangeBtnClick() {
    Navigator.pop(context);
  }

  onNextBtnClick() {
    // context.router.pushNamed(ROUTE_CONFIRM_LOCATION_SCREEN);
  }
}