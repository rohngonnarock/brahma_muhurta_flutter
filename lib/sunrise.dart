import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';
import 'Modals/sun.dart';

class SunriseApp extends StatefulWidget {
  final double lat;
  final double long;

  const SunriseApp({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  State<SunriseApp> createState() => _SunriseAppState();
}

class _SunriseAppState extends State<SunriseApp> {
  late Future<Sunrise> sunriseData;

  @override
  void initState() {
    super.initState();
    sunriseData = fetchSunrise(widget.lat, widget.long);
  }

  timeLeftToMuhurta(
      final String time, final String today, final String tomorrow) {
    final sunriseTime = muhuratBeforeTime(time) ? today : tomorrow;
    final muhurtaTime = Moment.fromDate(getLocalTime(sunriseTime))
        .subtract(hours: 1, minutes: 36);
    return muhurtaTime.fromNow(true);
  }

  getLocalTime(utc) {
    var dateUtc = DateTime.parse(utc);
    var strToDateTime = DateTime.parse(dateUtc.toString());
    return strToDateTime.toLocal();
  }

  muhuratBeforeTime(final String sunriseTime) {
    final muhurtaTime = Moment.fromDate(getLocalTime(sunriseTime))
        .subtract(hours: 1, minutes: 36);
    return DateTime.parse(muhurtaTime.toString()).isAfter(DateTime.now());
  }

  getMuhurtatime(final String time, final String today, final String tomorrow) {
    final sunriseTime = muhuratBeforeTime(time) ? today : tomorrow;
    return Moment.fromDate(getLocalTime(sunriseTime))
        .subtract(hours: 1, minutes: 36)
        .format('h:mm:ss a');
  }

  getMuhurtaLabel(final String sunriseTime) {
    final isMuhratToday = muhuratBeforeTime(sunriseTime);
    return isMuhratToday
        ? "Today's Brahma Muhurta Time"
        : "Tomorrow's Brahma Muhurta Time";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Sunrise>(
      future: sunriseData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          const textStyle = TextStyle(
            fontSize: 24.0,
          );
          const mainTextStyle =
              TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  getMuhurtaLabel(snapshot.data!.today),
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(''),
                Text(
                  getMuhurtatime(snapshot.data!.today, snapshot.data!.today,
                      snapshot.data!.tomorrow),
                  style: mainTextStyle,
                  textAlign: TextAlign.center,
                ),
                const Text(''),
                Text(
                  timeLeftToMuhurta(snapshot.data!.today, snapshot.data!.today,
                      snapshot.data!.tomorrow),
                  style: textStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
