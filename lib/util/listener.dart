// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/services.dart';

const EventChannel channel = EventChannel("com.example.eventchannel");

class EventChannelData {
  //x Axis
  double x;

  //y Axis
  double y;

  //z Axis
  double z;

  //get Z axis
  double getZ() => z;

  //GET X axis
  double getX() => x;

  //GET Y axis
  double getY() => y;

  EventChannelData({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  String toString() => 'EventChannelData(x: $x, y: $y, z: $z)';
}

EventChannelData _listOfData(List<double> data) {
  return EventChannelData(
    x: data[0],
    y: data[1],
    z: data[2],
  );
}

Stream<EventChannelData>? _gyroscopeEvents;
Stream<EventChannelData>? get eventData {
  _gyroscopeEvents ??= channel
      .receiveBroadcastStream()
      .map(((event) => _listOfData(event.cast<double>())));
  return _gyroscopeEvents;
}
