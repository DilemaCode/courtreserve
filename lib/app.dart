import 'package:courtreserve/pages/courts/courts.dart';
import 'package:courtreserve/pages/home/home.dart';
import 'package:courtreserve/providers/courts.dart';
import 'package:courtreserve/providers/reservations.dart';
import 'package:courtreserve/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  double width;
  double height;
  int _pageIndex = 0;
  List<Widget> _pages = <Widget>[
    Home(),
    Courts(),
  ];

  @override
  void initState() {
    super.initState();
  }

  pageChange(i) {
    setState(() {
      _pageIndex = i;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final rp = Provider.of<ReservationsProvider>(context);
    final cp = Provider.of<CourtsProvider>(context);
    if (!rp.loaded) {
      rp.init();
    }

    if (!cp.loaded) {
      cp.init();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Court Reserve"),
      ),
      body: _pages.elementAt(_pageIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/AddCourt');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.green,
        currentIndex: _pageIndex,
        onTap: pageChange,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("Reservation"),
            icon: Icon(Icons.featured_play_list),
          ),
          BottomNavigationBarItem(
            title: Text("Courts"),
            icon: Icon(Icons.outlined_flag),
          ),
        ],
      ),
    );
  }
}
