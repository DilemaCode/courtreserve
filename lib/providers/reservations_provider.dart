import 'package:courtreserve/services/rest.dart';
import 'package:flutter/material.dart';

class ReservationsProvider extends ChangeNotifier {
  final List reservations = [];
  bool _loaded = false;

  get loaded {
    return _loaded;
  }

  init() async {
    await RS.getReservations().then((value) => reservations.addAll(value));
    sort();
    _loaded = true;
    notifyListeners();
  }

  sort() {
    reservations.sort((a, b) {
      var adate = a['date'];
      var bdate = b['date'];
      return bdate.compareTo(adate);
    });
  }

  void add(data) {
    reservations.add(data);
    sort();
    RS.addReservation(data);
    notifyListeners();
  }

  Future remove(Map data) async {
    reservations.remove(data);
    await RS.removeReservation(data);
    notifyListeners();
    return "ok";
  }
}
