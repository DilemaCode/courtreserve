import 'package:courtreserve/providers/courts_provider.dart';
import 'package:courtreserve/services/rest.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("court provider", () {
    final cp = CourtsProvider();
    test('init: load defaul data and set to list', () async {
      await cp.init();
      expect(cp.courts.length, greaterThan(0));
    });

    test('add court ', () async {
      // await cp.init();
      cp.add({
        "id": "TEST",
        "name": "Test",
        "img":
            "https://lh5.googleusercontent.com/p/AF1QipPhrpFZUyDtI3oFMil1srGs_my8ml9GeRWlnT9g=w408-h271-k-no",
        "geo": [-37.8216161, 144.9785584]
      });
      expect(cp.courts.length, greaterThan(3));
    });
  });
}
