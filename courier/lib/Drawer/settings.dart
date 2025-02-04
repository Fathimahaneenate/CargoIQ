import 'package:courier/Drawer/settings/account_settings.dart';
import 'package:courier/Drawer/settings/notification.dart';
import 'package:courier/Drawer/settings/savedaddress.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(color: Color(0xfff071e30)),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,
            color: Colors.black,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          ListTile(
            leading: Image.asset(
              "assets/images/location.png",
              height: 28,
            ),
            title: Text(
              "Saved Address",
              style: TextStyle(color: Color(0xfff071e30)),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xfff071e30),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedAddressPage(),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/images/notification.png",
              height: 28,
            ),
            title: Text(
              "Notification",
              style: TextStyle(color: Color(0xfff071e30)),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xfff071e30),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(),
                  ));
            },
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/images/setting.png",
              height: 28,
            ),
            title: Text(
              "Account Settings",
              style: TextStyle(color: Color(0xfff071e30)),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xfff071e30),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountSettings(),
                  ));
            },
          ),
        ]),
      ),
    );
  }
}
