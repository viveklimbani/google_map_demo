import 'dart:convert';

class SelectedAddressLocation {
  String? address1;
  String? address2;
  double? lat;
  double? lng;

  SelectedAddressLocation({this.lat, this.address1, this.address2, this.lng});

  SelectedAddressLocation.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }

  @override
  String toString() {
    return json.encode(this.toJson());
  }
}