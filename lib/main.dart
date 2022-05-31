import 'dart:async';

import 'package:eventchannel/util/listener.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? _streamSubscription;

  List<double>? sensorValues;

  @override
  void initState() {
    sensorValues = const <double>[];

    _streamSubscription = eventData!.listen((event) {
      setState(() {
        sensorValues = <double>[event.x, event.y, event.z];
        print(sensorValues);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event channel'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'X:${sensorValues![0]}',
          ),
          Text(
            'Y:${sensorValues![1]}',
          ),
          Text(
            'Z:${sensorValues![2]}',
          ),
        ],
      ),
    );
  }
}
