
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Bike {
  String id;
  String curUser;
  GeoPoint loc;
  Timestamp lastUpdate;
  int status;

  Bike(this.id, this.curUser, this.loc, this.status, this.lastUpdate);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "curUser": curUser,
      "loc": loc,
      "status": status,
      "lastUpdate": lastUpdate,
    };
  }

  static Bike? fromDocumentSnapshot( String id ,Object? Function() data) {
    if (data == null) {
      return null;
    }

    // convert to Map<String, dynamic>
    var dataMap = data() as Map<String, dynamic>;
    return Bike(
      id,
      dataMap["curUser"] as String,
      dataMap["loc"] as GeoPoint,
      dataMap["status"] as int,
      dataMap["lastUpdate"] as Timestamp,
    );





  }
}
