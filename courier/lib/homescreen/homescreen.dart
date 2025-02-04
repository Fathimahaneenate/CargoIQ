import 'package:courier/Screen/courier.dart';
import 'package:courier/homescreen/drawer.dart';
import 'package:courier/homescreen/tabbar.dart';
import 'package:flutter/material.dart';
import 'entertrack.dart';
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Welcome..  ",
              style: TextStyle(
                  color: Color(0xfff071e30), fontWeight: FontWeight.bold),
            ),
            Icon(Icons.notifications_none_outlined, color: Colors.black,)
          ],
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawerr(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Entertrack(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    print("New Order clicked");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CourierPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1,
                    height: MediaQuery.of(context).size.height / 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,
                            color: Colors.black, size: 24), // Plus icon
                        SizedBox(width: 8), // Space between icon and text
                        Text(
                          "New Order",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Tabbar(),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "privacy & policy",
                  style: TextStyle(color: Color.fromARGB(255, 3, 117, 210)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
