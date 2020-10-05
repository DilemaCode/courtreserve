import 'package:courtreserve/app.dart';
import 'package:courtreserve/pages/add_reservation/add_reservation.dart';
import 'package:courtreserve/providers/courts.dart';
import 'package:courtreserve/providers/reservations.dart';
import 'package:courtreserve/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CourtsProvider>(create: (_) => CourtsProvider()),
        ChangeNotifierProvider<ReservationsProvider>(
            create: (_) => ReservationsProvider())
      ],
      child: MaterialApp(
        title: 'Court Reservation',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: AppColors.green,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(elevation: 0, centerTitle: true),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          "/": (BuildContext context) => App(),
          "/AddCourt": (BuildContext context) => AddCourt(),
        },
      ),
    );
  }
}
