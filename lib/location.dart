import 'dart:async';
import 'package:brahma_muhurta/sunrise.dart';
import 'package:flutter/material.dart';
import 'Modals/loc.dart';

class LocationApp extends StatefulWidget {
  const LocationApp({Key? key}) : super(key: key);

  @override
  State<LocationApp> createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  late Future<Loc> geoData;

  @override
  void initState() {
    super.initState();
    geoData = getGPSLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Loc>(
      future: geoData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.lat == 0.0 && snapshot.data!.long == 0.0) {
            return const Text('Permission Denied');
          }
          return SunriseApp(
            lat: snapshot.data!.lat,
            long: snapshot.data!.long,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [CircularProgressIndicator()]));
      },
    );
  }
}
