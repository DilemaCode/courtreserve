import 'package:courtreserve/components/court_cart.dart';
import 'package:courtreserve/providers/courts.dart';
import 'package:courtreserve/providers/reservations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double width;
  double height;

  @override
  void initState() {
    super.initState();
    // Rest.getWeather(
    //   lat: "18.481522",
    //   lon: "-69.7972878",
    // ).then((value) => print(value));
    // clear();
  }

  void clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("courts", null);
    prefs.setString("reservations", null);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final cp = Provider.of<CourtsProvider>(context);

    return Consumer<ReservationsProvider>(builder: (context, res, child) {
      return res.reservations.isEmpty
          ? Center(
              child: Text("No reservation yet"),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: res.reservations.length,
              itemBuilder: (BuildContext context, int i) {
                Map data = res.reservations[i];

                data = {
                  ...data,
                  ...cp.courts.firstWhere((e) => data['courtId'] == e['id'])
                };
                return CourtCart(type: 1, index: i, data: data);
              },
            );
    });
  }
}
