

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

class DataHandler{

  //get geolocation of bike in a specific area circle
  //return list of bike
  Future<List<Bike>> getBikeInArea(double lat,double lng,double radius) async{
    List<Bike> bikeList = [];
    //get ""Bike"" collection
    var dbRef = FirebaseFirestore.instance.collection("Bike");
    //get all bike
    var bikeSnapshot = await dbRef.get();
    //get all bike
    bikeSnapshot.docs.forEach((bike){
      //get bike data
      var bikeData = bike.data();
      //loc is a geoPoint
      GeoPoint loc = bikeData["loc"];
      //calculate distance
      var distance = getDistance(lat,lng,loc.latitude,loc.longitude);
      //if distance is less than radius
      if(distance<radius){
        //add bike to list
        bikeList.add(Bike(bikeData["id"],bikeData["curUser"],bikeData["loc"],bikeData["status"],bikeData["lastUpdate"]));
      }
    });
    return bikeList;
  }

  getDistance(lat, lng, lat2, lng2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat) * p)/2 +
        c(lat * p) * c(lat2 * p) *
            (1 - c((lng2 - lng) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}

class Bike {
  String id;
  String curUser;
  GeoPoint loc;
  DateTime lastUpdate;
  bool status;
  Bike(this.id,this.curUser,this.loc,this.status,this.lastUpdate);

}
