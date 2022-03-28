import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Sunrise {
  final String today;
  final String tomorrow;

  const Sunrise({
    required this.today,
    required this.tomorrow,
  });

  factory Sunrise.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> json2) {
    return Sunrise(
      today: json['results']["sunrise"],
      tomorrow: json2['results']['sunrise'],
    );
  }
}

Future<Sunrise> fetchSunrise(lat, long) async {
  final response = await Future.wait([
    http.get(Uri.parse(
        'https://api.sunrise-sunset.org/json?lat=${lat}&lng=${long}&date=today&formatted=0')),
    http.get(Uri.parse(
        'https://api.sunrise-sunset.org/json?lat=${lat}&lng=${long}&date=tomorrow&formatted=0'))
  ]);

  if (response[0].statusCode == 200 && response[1].statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Sunrise.fromJson(convert.jsonDecode(response[0].body),
        convert.jsonDecode(response[1].body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Sunrise');
  }
}
