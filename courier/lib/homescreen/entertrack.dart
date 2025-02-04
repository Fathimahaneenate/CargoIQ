

import 'package:courier/COMMONVIEWMODEL/commonviewmodel.dart';
import 'package:courier/Screen/orderstatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Entertrack extends StatefulWidget {
  const Entertrack({super.key});

  @override
  State<Entertrack> createState() => _EntertrackState();
}

class _EntertrackState extends State<Entertrack> {
  TextEditingController trackingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    trackingController = TextEditingController(); // Initialize the controller
  }

  @override
  void dispose() {
    trackingController.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  // Save the tracking ID and navigate to TrackOrder page
  Future<void> _saveTrackingID(BuildContext context, String trackingID) async {
    if (trackingID.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid Order ID'),
      ));
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('trackingID', trackingID); // Save tracking ID

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              TrackOrder()), // Navigate to the tracking screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff031f34),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 8.0, right: 8.0),
            child: Text(
              "Track your Shipment",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Please enter your Order ID",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 45,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromARGB(255, 226, 223, 223),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: trackingController,
                decoration: InputDecoration(
                  hintText: "Enter Order ID",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final orderId = int.tryParse(trackingController.text);
                      if (orderId != null) {
                        Provider.of<CommonViewModel>(context, listen: false)
                            .fetchtrackorders(orderId);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please enter a valid order ID'),
                        ));
                      }
                      String trackingID = trackingController.text.trim();
                      _saveTrackingID(context,
                          trackingID); // Call the function to save the ID
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  left: 5,
                  right: 5,
                  top: 20,
                  bottom: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff071e30),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/trackkk.png',
                      height: 250,
                      width: 300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
