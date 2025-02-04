

import 'package:courier/Drawer/createaccount.dart';
import 'package:courier/Map/calculation.dart';
import 'package:courier/Map/searchmaaap.dart';
import 'package:courier/Provider/addressprovider.dart';
import 'package:courier/Provider/priceprovider.dart';
import 'package:courier/Provider/sammeryprovider.dart';
import 'package:courier/Screen/courier.dart';
import 'package:courier/Screen/email/login.dart';
import 'package:courier/Screen/package.dart';
import 'package:courier/Screen/schedule.dart';
import 'package:courier/Screen/splash/splash.dart';
import 'package:courier/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'COMMONVIEWMODEL/commonviewmodel.dart';
import 'commentcontents.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommonViewModel()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => SummaryProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Courier App',
      home: CreateProfilePage(),
    );
  }
}