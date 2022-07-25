import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:simple_moment/simple_moment.dart';
import 'Modals/sun.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

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
  late String currentLocale = 'en_US';

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
        ? translate('today_brahma_muhurat_time')
        : translate('tomorrow_brahma_muhurat_time');
  }

  getMuhurtaHour(final String time, final String today, final String tomorrow) {
    final sunriseTime = muhuratBeforeTime(time) ? today : tomorrow;
    final muhuratTime = Moment.fromDate(getLocalTime(sunriseTime))
        .subtract(hours: 1, minutes: 36)
        .format('h');
    return int.parse(muhuratTime);
  }

  getMuhurtaMinute(
      final String time, final String today, final String tomorrow) {
    final sunriseTime = muhuratBeforeTime(time) ? today : tomorrow;
    final muhuratTime = Moment.fromDate(getLocalTime(sunriseTime))
        .subtract(hours: 1, minutes: 36)
        .format('mm');
    return int.parse(muhuratTime);
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
                ),
                Container(
                    margin: const EdgeInsets.only(top: 100.0),
                    child: const Text('')),
                ElevatedButton(
                    onPressed: () => {
                          FlutterAlarmClock.createAlarm(
                              getMuhurtaHour(
                                  snapshot.data!.today,
                                  snapshot.data!.today,
                                  snapshot.data!.tomorrow),
                              getMuhurtaMinute(
                                  snapshot.data!.today,
                                  snapshot.data!.today,
                                  snapshot.data!.tomorrow),
                              title: translate('brahm_muhrata_time'))
                        },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        translate('set_alarm'),
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )),
                ElevatedButton(
                    onPressed: () => {
                          changeLocale(context, currentLocale),
                          setState(() {
                            currentLocale =
                                currentLocale == "en_US" ? "en_US" : "hi_IN";
                          })
                        },
                    child: Text(translate('change_current_language')))
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
