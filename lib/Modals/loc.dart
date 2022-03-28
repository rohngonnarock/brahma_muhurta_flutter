import 'dart:async';
import 'package:flutter/services.dart';
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

  initLocation() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      return _serviceEnabled;
    } on PlatformException catch (err) {
      print("Platform exception calling serviceEnabled(): $err");
      _serviceEnabled = false;

      // location service is still not created

      initLocation(); // re-invoke himself every time the error is catch, so until the location service setup is complete
    }
    return false;
  }

  _serviceEnabled = await initLocation();
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
