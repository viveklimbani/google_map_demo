import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:location/location.dart';
import 'package:practice_app/location/current_location_screen.dart';
import 'package:practice_app/provider/location_provider.dart';

import 'common/resources/images.dart';
import 'common/utils/common_functions.dart';
import 'common/utils/constants.dart';
import 'common/utils/dimen.dart';
import 'data/selected_address_location.dart';
import 'location/detect_current_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pickupAddressController = TextEditingController();
  TextEditingController searchEditingController = TextEditingController();
  SelectedAddressLocation _selectedAddressLocation = SelectedAddressLocation();
  DetectCurrentLocation _detectCurrentLocation = DetectCurrentLocation();
  late GoogleMapController mapController;
  String? _mapStyle;
  Location currentLocation = Location();
  String googleApikey = GOOGLE_MAPS_API_KEY;
  String searchLocation = "Search Location";
  final Set<Marker> _markers = {};

  late LocationProvider locationData;

  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(0, 0), zoom: 14);

  // void getLocation() async {
  //   var location = await currentLocation.getLocation();
  //   currentLocation.onLocationChanged.listen((LocationData loc) {
  //     mapController
  //         ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //       zoom: 12.0,
  //     )));
  //     print(loc.latitude);
  //     print(loc.longitude);
  //     setState(() {
  //       _markers.add(Marker(
  //           markerId: const MarkerId('Home'),
  //           position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   getLocation();
    // });
    rootBundle.loadString('assets/style/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.0673, 72.5567),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: mainLayout,

      // Stack(
      //   children: [
      //     googleMap,
      //     centerMarker,
      //     // Container(
      //     //   height: MediaQuery.of(context).size.height,
      //     //   width: MediaQuery.of(context).size.width,
      //     //   child: GoogleMap(
      //     //     zoomControlsEnabled: false,
      //     //     initialCameraPosition: const CameraPosition(
      //     //       target: LatLng(48.8561, 2.2930),
      //     //       zoom: 12.0,
      //     //     ),
      //     //     onMapCreated: (GoogleMapController controller) {
      //     //       mapController = controller;
      //     //     },
      //     //     markers: _markers,
      //     //   ),
      //     // ),
      //     bottomDetailsSheet,
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(
      //     Icons.location_searching,
      //     color: Colors.white,
      //   ),
      //   onPressed: () => onDetectLocationClick(context),
      //   // onPressed: () {
      //   //   getLocation();
      //   // },
      // ),
    );
  }

  get mainLayout => Stack(
        children: [
          Container(
            height: MediaQuery.of(context).viewInsets.bottom > 0.0 ? 200 : 400,
            child: Stack(
              children: [
                googleMap,
                centerMarker,
              ],
            ),
          ),
          bottomDetailsSheet,
        ],
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
          mapController?.animateCamera(
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
          locationData.onCameraMove(position);
        },
      );

  get centerMarker => Center(
        child: Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 48),
          child: Image.asset(
            Images.icMarker,
            color: Colors.black,
          ),
        ),
      );

  // get getSearchBox => Padding(
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: Spacing.space10,
  //         vertical: Spacing.space10,
  //       ),
  //       child: TextFieldSearchCustom(
  //         hintText: "Search Location",
  //         onChangeField: (value) {
  //           // filterSearchResults(value);
  //         },
  //         controller: searchEditingController,
  //       ),
  //     );

  get bottomDetailsSheet => DraggableScrollableSheet(
        initialChildSize: .55,
        minChildSize: .5,
        maxChildSize: .91,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: Colors.white,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Select Location",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                googleAutoFillTextField,
                const SizedBox(
                  height: 20,
                ),
                useCurrentLocationBtn,
                const Divider(),
              ],
            ),
          );
        },
      );

  onDetectLocationClick() async {
    dismissKeyboard(context);
    var address = await _detectCurrentLocation.getCurrentAddress();

    setState(() {
      if (address != null) {

        if (address.latitude != null || address.longitude != null) {
          mapController?.animateCamera(
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

    // onUseLocationClick();
  }

  onUseLocationClick(){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CurrentLocationScreen()));
  }

  get googleAutoFillTextField => Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GooglePlaceAutoCompleteTextField(
          textEditingController: pickupAddressController,
          googleAPIKey: GOOGLE_MAPS_API_KEY,
          getPlaceDetailWithLatLng: (detail) {
            dismissKeyboard(context);
            _selectedAddressLocation.lat = double.parse(detail.lat!);
            _selectedAddressLocation.lng = double.parse(detail.lng!);

            setState(() {
              mapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(double.parse(detail.lat ?? "0"),
                        double.parse(detail.lng ?? "0")),
                    zoom: 15.0,
                  ),
                ),
              );
            });

          },
          itmClick: (detail) {
            dismissKeyboard(context);
            _selectedAddressLocation.address1 =
                detail.structuredFormatting?.mainText ?? "";
            _selectedAddressLocation.address2 =
                detail.structuredFormatting?.secondaryText ?? "";
          },
          isLatLngRequired: true,
          inputDecoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: Spacing.xxSmall),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            prefixIcon: Container(
              padding: const EdgeInsets.only(right: 10),
              height: 10,
              width: 10,
              child: const Padding(
                padding: EdgeInsets.all(Spacing.xSmall11),
                child: Icon(
                  Icons.search,
                  size: 10,
                ),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(
              fontSize: 11,
              color: Colors.black.withOpacity(0.5),
            ),
            hintText: "Search Address",
            fillColor: Colors.white70,
          ),
        ),
      );

  get useCurrentLocationBtn => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () => onDetectLocationClick(),
          child: Row(
            children: [
              const Icon(
                Icons.my_location,
                size: 12,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Use Current Locations",
                    style: TextStyle(fontSize: 12),
                  ),
                  selectedAddressLocation.address2 != null
                      ? Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(
                            "${selectedAddressLocation.address2}",
                            style: const TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              )
            ],
          ),
        ),
      );
}
