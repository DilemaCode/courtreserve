import 'package:courtreserve/services/rest.dart';
import 'package:flutter/material.dart';

class CourtsProvider extends ChangeNotifier {
  final List courts = [];
  bool _loaded = false;

  get loaded {
    return _loaded;
  }

  init() async {
    RS.getCourts().then((value) => courts.addAll(value));
    _loaded = true;
    // notifyListeners();
  }

  void add(data) {
    courts.add(data);
    RS.addCourt(data);
    notifyListeners();
  }

  void addAll(data) {
    courts.addAll(data);
    for (var item in data) {
      RS.addCourt(item);
    }
    notifyListeners();
  }

  void remove(Map data) {
    courts.remove(data);
    notifyListeners();
  }

  void removeAt(int i) {
    courts.removeAt(i);
    notifyListeners();
  }

  void clear() {
    courts.clear();
    notifyListeners();
  }
}
