import 'package:courtreserve/components/court_cart.dart';
import 'package:courtreserve/providers/courts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Courts extends StatefulWidget {
  Courts({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Courts> with TickerProviderStateMixin {
  double width;
  double height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Consumer<CourtsProvider>(builder: (context, res, child) {
      return res.courts.isEmpty
          ? Center(
              child: Text("No courts yet"),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: res.courts.length,
              itemBuilder: (BuildContext context, int i) {
                return CourtCart(type: 0, index: i, data: res.courts[i]);
              },
            );
    });
  }
}
