import 'package:flutter/material.dart';
import 'screens/bus_list_screen.dart';

void main() {
  runApp(const SmartBusTrackerApp());
}

class SmartBusTrackerApp extends StatelessWidget {
  const SmartBusTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Bus Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF3F5FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: const BusListScreen(),
    );
  }
}