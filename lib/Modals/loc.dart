import 'dart:async';
import 'package:location/location.dart';

class Loc {
  final double lat;
  final double long;

  const Loc({
    required this.lat,
    required this.long,
  });

  factory Loc.fromJson(lat, long) {
    return Loc(
      lat: lat,
      long: long,
    );
  }
}

Future<Loc> getGPSLocation() async {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return Loc.fromJson(0.0, 0.0);
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return Loc.fromJson(0.0, 0.0);
    }
  }

  _locationData = await location.getLocation();
  return Loc.fromJson(_locationData.latitude, _locationData.longitude);
}
