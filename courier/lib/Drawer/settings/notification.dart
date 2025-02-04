import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isOrderAndSupportEnabled = true;
  bool isMarketingOffersEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Order and Support",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Receive notifications related to your order status, payments and support communications"),
            trailing: Switch(
              value: isOrderAndSupportEnabled,
               activeColor: Color(0xfff071e30),
              onChanged: (value) {
                setState(() {
                  isOrderAndSupportEnabled = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              "Marketing and Promotional Offers",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Receive notifications related to offers around CargoIQ Direct"),
            trailing: Switch(
              value: isMarketingOffersEnabled,
              activeColor: Color(0xfff071e30),
              onChanged: (value) {
                setState(() {
                  isMarketingOffersEnabled = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}