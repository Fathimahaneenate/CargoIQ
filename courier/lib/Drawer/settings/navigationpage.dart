import 'package:courier/Drawer/settings/savedaddress.dart';
import 'package:courier/Screen/pickupaddress.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Map<String, String>> savedAddresses = [];

  void _navigateToAddAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickupAddressPage(area: '', pincode: '',),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        savedAddresses.add(result);
      });
    }
  }

  void _navigateToSavedAddresses() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedAddressPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Manager"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _navigateToAddAddress,
              child: Text("Add Pickup Address"),
            ),
            ElevatedButton(
              onPressed: _navigateToSavedAddresses,
              child: Text("View Saved Addresses"),
            ),
          ],
        ),
      ),
    );
  }
}
