//datahandler class handle firebase database
//and excute query
//list of query
//1.get geolocation of bike in a specific area circle
//2.update geolocation of user
//3.get geolocation of user as a list
//4.make reservation (date,time,location,user)
//5.get reservation of user


import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'bike.dart';


class DataHandler {
  static Future<List<Bike>> getAllBikes() async {
    List<Bike> bikes = [];
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('Bikes').get();
    print('Firebase Bikes LOL'+ qs.size.toString());
    for (var element in qs.docs) {
      bikes.add(Bike.fromDocumentSnapshot(element.id,element.data)!);
    }
    return bikes;
  }

  //get geolocation of bike in a specific area circle
  //return list of bike
  Future<List<Bike>> getBikeInArea(
      double lat, double lng, double radius) async {
    List<Bike> bikeList = [];
    //get ""Bike"" collection
    var dbRef = FirebaseFirestore.instance.collection("Bikes");
    //get bike in radious
    var bikeSnapshot = await dbRef.get();
    //get all bike
    bikeSnapshot.docs.forEach((bike) {
      //get bike data
      var bikeData = bike.data();
      //loc is a geoPoint
      GeoPoint loc = bikeData["loc"];
      //calculate distance
      var distance = getDistance(lat, lng, loc.latitude, loc.longitude);
      //if distance is less than radius
      if (distance < radius) {
        //add bike to list
        bikeList.add(Bike(bikeData["id"], bikeData["curUser"], bikeData["loc"],
            bikeData["status"], bikeData["lastUpdate"]));
      }
    });
    return bikeList;
  }

  getDistance(lat, lng, lat2, lng2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat) * p) / 2 +
        c(lat * p) * c(lat2 * p) * (1 - c((lng2 - lng) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static void setBikeStatus(String id, bool bool) {
    FirebaseFirestore.instance
        .collection("Bike")
        .doc(id)
        .update({"status": bool});

  }
}
