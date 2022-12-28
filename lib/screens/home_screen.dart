import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:practice_app/common/utils/common_functions.dart';
import 'package:practice_app/common/utils/constants.dart';
import 'package:practice_app/data/selected_address_location.dart';
import 'package:practice_app/screens/detect_current_location.dart';
import 'package:practice_app/provider/location_provider.dart';
import 'package:provider/provider.dart';

import '../common/resources/images.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pickupAddressController = TextEditingController();

  SelectedAddressLocation _selectedAddressLocation = SelectedAddressLocation();
  DetectCurrentLocation _detectCurrentLocation = DetectCurrentLocation();

  ///Provider
  late LocationProvider locationData;

  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(23.0225, 72.5714), zoom: 14);

  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    locationData = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Google Map")),
      body: mainLayout,
    );
  }

  get mainLayout => Stack(
        children: [
          SizedBox(
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
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(23.0225, 72.5714),
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
          margin: EdgeInsets.only(bottom: 48),
          child: Image.asset(
            Images.icMarker,
            color: Colors.black,
          ),
        ),
      );

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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Select Location",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                googleAutoFillTextField,
                const SizedBox(
                  height: 20,
                ),
                useCurrentLocationBtn,
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      );

  get googleAutoFillTextField => Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GooglePlaceAutoCompleteTextField(
          textEditingController: pickupAddressController,
          googleAPIKey: GOOGLE_MAPS_API_KEY,
          getPlaceDetailWithLatLng: (detail) {
            dismissKeyboard(context);
            _selectedAddressLocation.lat = double.parse(detail.lat!);
            _selectedAddressLocation.lng = double.parse(detail.lng!);

            setState(() {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(double.parse(detail.lat ?? "0"),
                        double.parse(detail.lng ?? "0")),
                    zoom: 15.0,
                  ),
                ),
              );
            });

            // BotToast.closeAllLoading();
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                padding: EdgeInsets.all(11.0),
                child: Icon(Icons.search),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    "Use Current Location",
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
                      : SizedBox()
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

  onDetectLocationClick() async {
    dismissKeyboard(context);
    var address = await _detectCurrentLocation.getCurrentAddress();

    setState(() {
      if (address != null) {
        if (address.latitude != null || address.longitude != null)
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(address.latitude ?? 0, address.longitude ?? 0),
                zoom: 18.0,
              ),
            ),
          );

        selectedAddressLocation.lat = address.latitude;
        selectedAddressLocation.lng = address.longitude;
        selectedAddressLocation.address1 = address.address;
        selectedAddressLocation.address2 = address.address;
      }
    });
  }
}
