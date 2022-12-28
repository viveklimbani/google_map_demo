import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/home_screen.dart';

import '../common/resources/styles.dart';
import '../common/utils/common_functions.dart';
import '../common/utils/dimen.dart';
import '../provider/location_provider.dart';
import 'detect_current_location.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({Key? key}) : super(key: key);

  @override
  _ConfirmLocationScreenState createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  DetectCurrentLocation _detectCurrentLocation = DetectCurrentLocation();

  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(0, 0), zoom: 14);

  late GoogleMapController mapController;

  String? _mapStyle;

  ///Provider
  late LocationProvider locationData;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/style/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainLayout,
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
          bottomDetailsSheet(),
          headerBar,
        ],
      );

  get headerBar => Container(
        height: Spacing.JUMBO70,
        color: Colors.white,
        padding: const EdgeInsets.only(
          top: Spacing.JUMBO30,
          left: Spacing.normal,
          right: Spacing.normal,
          bottom: Spacing.small,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(
                  width: Spacing.xSmall,
                ),
                Text(
                  "Pickup Location",
                  style: TextStyles.appbarTextStyle
                      .copyWith(fontWeight: FontWeight.w600),
                )
              ],
            ),
          ],
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
          // mapController.setMapStyle(_mapStyle);
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
          locationData.onCameraMove(position);
        },
      );

  get centerMarker => Center(
        child: Container(
          height: DimenConst.marker50,
          margin: EdgeInsets.only(bottom: Spacing.JUMBO36),
          child: const Icon(
            Icons.location_on,
            size: 40,
          ),
        ),
      );

  Widget bottomDetailsSheet() {
    return DraggableScrollableSheet(
      initialChildSize: .53,
      minChildSize: .53,
      maxChildSize: .53,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                width: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        shortAddress,
                        const SizedBox(
                          width: 10,
                        ),
                        longAddress,
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  changeBtn,
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  get shortAddress => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
        child: Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 20,
            ),
            Text(
              selectedAddressLocation.address1?.split(",")[1] ?? "N/A",
              style: TextStyles.textFieldStyle
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );

  get longAddress => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          selectedAddressLocation.address2 ?? "N/A",
          style: TextStyle(
            fontSize: 11,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      );

  get changeBtn => InkWell(
        onTap: () => onChangeBtnClick(),
        child: const Text(
          "Change",
          style: TextStyle(decoration: TextDecoration.underline, fontSize: 12),
        ),
      );

  // get confirmLocationBtn => Padding(
  //   padding: const EdgeInsets.symmetric(horizontal: 16),
  //   child: RSSolidButton(
  //     title: "Confirm Location",
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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>  const HomeScreen()));
  }

  onNextBtnClick() {
    // context.router.pushNamed(ROUTE_DASHBOARD);
  }
}
