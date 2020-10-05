import 'package:courtreserve/components/court_cart.dart';
import 'package:courtreserve/providers/courts_provider.dart';
import 'package:courtreserve/providers/reservations_provider.dart';
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
                Map realData = res.reservations[i];
                Map data = {
                  ...cp.courts
                      .firstWhere((e) => realData['courtId'] == e['id']),
                  ...realData,
                };
                return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(realData['id']),
                    confirmDismiss: (d) async {
                      return await _showConfirmation(context, "Delete", i) ==
                          true;
                    },
                    child: CourtCart(type: 1, index: i, data: data));
              },
            );
    });
  }

  Future<bool> _showConfirmation(BuildContext context, String action, int i) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          final rp = Provider.of<ReservationsProvider>(context);
          return AlertDialog(
            title: Text("Delete"),
            content: Text("Are you sure?"),
            actions: [
              RaisedButton(
                onPressed: () async {
                  rp.remove(i);
                  Navigator.pop(context, true);
                },
                child: Text("Delete"),
              ),
              RaisedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel"),
              )
            ],
          );
        });
  }
}
