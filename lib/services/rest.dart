import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RS {
  RS._();

  static Future clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("courts", null);
    prefs.setString("reservations", null);
  }

  static Future getCourts() async {
    List res = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('courts') == null) {
      res.addAll(List.from(defaultCourtsData()));
    } else {
      print("getReservations isnt null");
      res = List.from(jsonDecode(prefs.get('courts')));
    }
    return res;
  }

  static Future addCourt(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('courts') != null) {
      List court = json.decode(prefs.get('courts')) as List;
      court.add(data);
      prefs.setString('courts', jsonEncode(court));
    } else {
      prefs.setString('courts', jsonEncode(List.from([data])));
    }
  }

  static Future removeCourt(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('courts') != null) {
      List courts = List.from(jsonDecode(prefs.get('courts')));
      courts.remove(data);
      prefs.setString('courts', jsonEncode(courts));
    }
  }

  static Future getReservations() async {
    List res = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('reservations') != null) {
      print("getReservations isnt null");
      res = List.from(jsonDecode(prefs.get('reservations')));

      print("reservations in rest");
      print(res);
    }
    return res;
  }

  static Future addReservation(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('reservations') != null) {
      List reservations = json.decode(prefs.get('reservations')) as List;
      reservations.add(data);
      prefs.setString('reservations', jsonEncode(reservations));
    } else {
      prefs.setString('reservations', jsonEncode(List.from([data])));
    }
  }

  static Future removeReservation(i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('reservations') != null) {
      final List reservations =
          List.from(jsonDecode(prefs.get('reservations')));
      reservations.removeAt(i);
      print(reservations.length);
      prefs.setString('reservations', jsonEncode(reservations));
      // courtsProvider.set(courts)
    }
  }

  static defaultCourtsData() {
    List _courts = List.from([
      {
        "id": "A",
        "name": "Rod Laver Arena",
        "img":
            "https://lh5.googleusercontent.com/p/AF1QipPhrpFZUyDtI3oFMil1srGs_my8ml9GeRWlnT9g=w408-h271-k-no",
        "geo": [-37.8216161, 144.9785584]
      },
      {
        "id": "B",
        "name": "Arthur Ashe Stadium",
        "img": "https://www.liberty.edu/media/1617/tennis.jpg",
        "geo": [40.7498783, -73.847013]
      },
      {
        "id": "C",
        "name": "Indian Wells Tennis Garden",
        "img":
            "https://www.tenniscourtsurfaces.org.uk/uploads/images/1_(14).JPG",
        "geo": [33.7240398, -116.3045601]
      },
    ]);

    return _courts;
  }
}
