import 'package:courtreserve/providers/reservations_provider.dart';
import 'package:courtreserve/services/rest.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final rp = ReservationsProvider();
  List testData = [
    {
      "courtId": "A",
      "player": "Court A",
      "date": DateTime.now().millisecondsSinceEpoch
    },
    {
      "courtId": "B",
      "player": "Court A",
      "date": DateTime.now().millisecondsSinceEpoch
    },
  ];

  group("Reservation provider: without local data", () {
    test('init: load local empty ', () async {
      await rp.init();
      expect(rp.loaded, true);
    });

    test('add Reservation ', () async {
      rp.add(testData[0]);
      expect(rp.reservations.length, greaterThan(0));
    });
    test('delete Reservation', () async {
      var initLength = rp.reservations.length;
      await rp.remove(testData[0]);
      expect(rp.reservations.length, initLength - 1);
    });
  });
  group("Reservation provider: clear local data", () {
    test('clear', () async {
      RS.clear();
    });
  });

  group("Reservation provider: with local data", () {
    test('set load local', () async {
      List _list = [];
      await RS.addReservation(testData[1]);
      await RS.getReservations().then((value) => _list = value);
      expect(_list.length, greaterThan(0));
    });
    test('init:get load local', () async {
      await rp.init();
      expect(rp.loaded, true);
      expect(rp.reservations.length, greaterThan(0));
    });
  });
}
