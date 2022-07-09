import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:app/datahandler.dart';

class Llmap extends StatefulWidget {
  const Llmap({Key? key}) : super(key: key);

  @override
  State<Llmap> createState() => _Llmap();
}

const maxMarkersCount = 5;

class _Llmap extends State<Llmap> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];

  int _sliderVal = 100;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      var r = Random();
      //use datahandler to get all bike
      DataHandler.getAllBikes().then((bikes) {
        //for each bike
        for (var bike in bikes) {
          print(bike.id);
          //get bike location
          var loc = bike.loc;
          //get bike id
          var id = bike.id;
          //get bike status
          var status = bike.status;
          //get bike last update
          var lastUpdate = bike.lastUpdate;
          //get bike current user
          var curUser = bike.curUser;
          //create marker
          var marker = Marker(
              width: 100.0,
              height: 100.0,
              point: LatLng(loc.latitude, loc.longitude),
              builder: (ctx) => Container(
                height: 1.0,
                width: 1.0,
                  child: Transform.scale(
                    scale: 0.7,
                    child: FloatingActionButton(
                      shape: CircleBorder() ,
                      child:
                           Icon(
                            Icons.directions_bike,
                            size: 50,
                            color: status == 0 ? Colors.green : Colors.red,
                          ),
                          onPressed: ()
                          {

                            //if bike is available
                            //show dialog
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                        title: Text("Reserve Bike"),
                                        content: Text(
                                            "Do you want to reserve this bike?"),
                                        actions: <Widget>[
                                          TextButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                //close dialog
                                                Navigator.of(ctx).pop();
                                              }),
                                          TextButton(
                                              child: Text("Yes"),
                                              onPressed: () {
                                                //close dialog
                                                Navigator.of(ctx).pop();
                                              })
                                        ]));

                            if (status ==0) {}
                            //if bike is available
                            //set bike status to unavailable
                            //DataHandler.setBikeStatus(id, false);
                          }),
                  ),
                  ));
          //add marker to allMarkers
          this.allMarkers.add(marker);
        }
        print ('allMarkers size: ' + allMarkers.length.toString());
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterMap(
          options: MapOptions(
            center: LatLng(50, 20),
            zoom: 5.0,
            interactiveFlags: InteractiveFlag.all,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
                markers:
                    allMarkers.sublist(0, min(allMarkers.length, _sliderVal))),
          ],
        ),

    );
  }
}
