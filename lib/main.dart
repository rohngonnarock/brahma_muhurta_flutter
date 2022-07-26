import 'dart:io';

import 'package:brahma_muhurta/location.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String latLong = "";
  String todayTomorrow = "";

  @override
  Widget build(BuildContext context) {
    var gradientBox = const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromARGB(255, 131, 222, 207),
      Color.fromRGBO(160, 148, 227, 1),
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter));

    // var imageBox = const BoxDecoration(
    //   image: DecorationImage(
    //       image: NetworkImage(
    //           'https://images.unsplash.com/photo-1648563678346-d72fd33aa451?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80'),
    //       fit: BoxFit.cover),
    // );
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        decoration: gradientBox,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              LocationApp(),
            ],
          )),
        ),
      ),
    );
  }
}
