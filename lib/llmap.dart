
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:app/datahandler.dart';
class Llmap extends StatefulWidget{
  const Llmap({Key? key}) : super(key: key);

  @override
  State<Llmap> createState() => _Llmap();

}
const maxMarkersCount = 5000;
class _Llmap extends State<Llmap>{
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];

  int _sliderVal = 100;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      var r = Random();
      for (var x = 0; x < maxMarkersCount; x++) {
        allMarkers.add(
          Marker(
            point: LatLng(
              doubleInRange(r, 37, 55),
              doubleInRange(r, -9, 30),
            ),
            builder: (context) => Stack(
              fit: StackFit.expand,
              children:const <Widget> [Icon(Icons.location_on,
                color: Colors.white,
                size: 12.0*4),


              ]
            ),
          ),
        );
      }
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(50, 20),
            zoom: 5.0,
            interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
                markers: allMarkers.sublist(
                    0, min(allMarkers.length, _sliderVal))),
          ],
        ),
      ),
    );
  }
}