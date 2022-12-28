import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  double latitude = 37.421632;
  double longitude = -122.084664;
  bool permissionAllowed = false;
  var selectedAddress;
  bool loading = false;

  // SharedPreferences pref = SharedPreferences.getInstance() as SharedPreferences;

  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (position != null) {
      this.latitude = position.latitude;
      this.longitude = position.longitude;

      final addresses = await placemarkFromCoordinates(
          this.latitude.toDouble(), this.longitude.toDouble());
      this.selectedAddress = addresses.first;

      this.permissionAllowed = true;
      notifyListeners();
    } else {
      print('Permisson not Allowed');
    }
  }

  void onCameraMove(CameraPosition camaraPosition) async {
    this.latitude = camaraPosition.target.latitude;
    this.longitude = camaraPosition.target.longitude;
    notifyListeners();
  }

  Future<void> getMoveCamara() async {
    final addresses = await placemarkFromCoordinates(
        this.latitude.toDouble(), this.longitude.toDouble());
    this.selectedAddress = addresses.first;
    notifyListeners();
    print("${selectedAddress.featureName} : ${selectedAddress.addressLine}");
  }

  // Future<void> savePrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setDouble('latitude', this.latitude);
  //   prefs.setDouble('longitude', this.longitude);
  //   prefs.setString('address', this.selectedAddress.addressLine);
  //   prefs.setString('location', this.selectedAddress.featureName);
  // }
}