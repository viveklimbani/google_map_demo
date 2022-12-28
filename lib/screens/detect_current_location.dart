import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:geocode/geocode.dart';
import 'package:http/http.dart' as http;
import 'package:practice_app/common/utils/constants.dart';

class DetectCurrentLocation with ChangeNotifier {
  Location location = Location();
  GeoCode geoCode = GeoCode();

  Future<LocationData?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation().catchError((onError) {
      if (kDebugMode) {
        print("Location error $onError");
      }
    });
    notifyListeners();
    return locationData;
  }

  Future<CustomAddress?> getCurrentAddress({lat, lng}) async {
    LocationData? currentLocationDetail;
    if (lat == null && lng == null) {
      currentLocationDetail = await getCurrentLocation();
    } else {
      currentLocationDetail =
          LocationData.fromMap({"latitude": lat, "longitude": lng});
    }

    if (currentLocationDetail != null) {
      // From coordinates
      final coordinates = Coordinates(
          latitude: currentLocationDetail.latitude,
          longitude: currentLocationDetail.longitude);

      // var addresses = await geoCode.reverseGeocoding(
      //     latitude: coordinates.latitude!, longitude: coordinates.longitude!);

      var addresses = await getAddressFromLatLng(
          latitude: coordinates.latitude!, longitude: coordinates.longitude!);

      // var first = addresses.first;
      // print("${addresses.postal}");
      return CustomAddress(
          address: addresses,
          latitude: coordinates.latitude,
          longitude: coordinates.longitude);
      // return addresses;
    }

    return null;
  }

  Future<bool> hasLocationPermission() async {
    return (await location.hasPermission()) == PermissionStatus.granted;
  }
}

getAddressFromLatLng(
    {required double latitude, required double longitude}) async {
  String host = 'https://maps.google.com/maps/api/geocode/json';
  final url =
      '$host?key=$GOOGLE_MAPS_API_KEY&language=en&latlng=$latitude,$longitude';
  if (latitude != null && longitude != null) {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      String formattedAddress = data["results"][0]["formatted_address"];
      if (kDebugMode) {
        print("response ==== $formattedAddress");
      }
      return formattedAddress;
    } else {
      return null;
    }
  } else {
    return null;
  }
}

class CustomAddress {
  double? latitude;
  double? longitude;
  String? address;

  CustomAddress({this.latitude, this.longitude, this.address});
}
