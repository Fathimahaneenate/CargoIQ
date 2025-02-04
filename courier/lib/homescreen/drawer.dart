import 'dart:developer';

import 'package:courier/Drawer/feedback.dart';
import 'package:courier/Drawer/settings.dart';
import 'package:courier/Map/showmap.dart';
import 'package:courier/Screen/courier.dart';
import 'package:courier/Screen/order.dart';
import 'package:courier/homescreen/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawerr extends StatefulWidget {
  const Drawerr({
    super.key,
  });

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  String? firstName;
  String? lastName;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }
 Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? 'N/A';
      lastName = prefs.getString('lastName') ?? 'N/A';
      email = prefs.getString('email') ?? 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xfff031f34),
              ),
              accountName: Text(
                "$firstName $lastName",
                style: TextStyle(color: Colors.white),
              ),
              // Text("yy", style: TextStyle(color: Colors.white)),
              accountEmail: Text(
                email ?? "",
                style: TextStyle(color: Colors.white),
              ),
              // Text("yyy@example.com",
              //     style: TextStyle(color: Colors.white)),
              currentAccountPicture: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CircleAvatar(
                    radius: 30, 
                    backgroundColor: Colors.grey[700],
                    child: Text(
                      firstName != null && firstName!.isNotEmpty
                          ? firstName![0].toUpperCase()
                          : "A", 
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    left: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20, 
                      ),
                      onPressed: () {
                        print('Edit icon pressed');
                      },
                    ),
                  ),
                ],
              )

              // CircleAvatar(),
              ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/home.png",
              height: 26,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/delivery-truck.png",
              height: 35,
            ),
            title: Text('Courier'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CourierPage()));
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/box (1).png",
              height: 28,
            ),
            title: Text('My Orders'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyOrderPage()));
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/settings.png",
              height: 26,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ));
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/feedback.png",
              height: 28,
            ),
            title: Text('Feedback'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedBackPage()));
            },
          ),

          SizedBox(
            height: 10,
          ),
          //  ListTile(
          //   leading: Image.asset(
          //     "assets/images/feedback.png",
          //     height: 28,
          //   ),
          //   title: Text('disply'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => DistanceDisplayPage()));
          //   },
          // ),
        ],
      ),
    );
  }
}
