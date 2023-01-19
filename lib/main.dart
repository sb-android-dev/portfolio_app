import 'package:flutter/material.dart';
import 'package:portfolio_app/models/Portfolio.dart';
import 'package:portfolio_app/shared_prefs/shared_pref.dart';

import 'details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkIfDataSavedLocally();
    
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Portfolio App",
      home: Details(),
    );
  }

  checkIfDataSavedLocally() async {
    final portfolioPref = PortfolioPref();
    bool isNamePresent = await portfolioPref.isAvailable('name');
    if(!isNamePresent) {
      Portfolio portfolio = Portfolio(
          'Smit Bhanvadia',
          'smit.mobilefirst@gmail.com',
          'I am Android developer having experience of developing Android apps in Java & Kotlin. And now I am learning Flutter & Dart for developing cross platform apps.');

      portfolioPref.savePortfolio(portfolio);
    }
  }
}

