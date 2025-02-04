import 'dart:developer';

import 'package:courier/Provider/addressprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../COMMONVIEWMODEL/commonviewmodel.dart';
import 'courier.dart';

class PickupAddressPage extends StatefulWidget {
  final Map<String, String>? existingDetails;

  PickupAddressPage({this.existingDetails, required String area, required String pincode});

  @override
  State<PickupAddressPage> createState() => _PickupAddressPageState();
}

class _PickupAddressPageState extends State<PickupAddressPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  String? name, phone, address, area, pincode, city, district;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  CommonViewModel? vm;

  @override
  void initState() {
    super.initState();
    if (widget.existingDetails != null) {
      nameController.text = widget.existingDetails!['name'] ?? '';
      phoneController.text = widget.existingDetails!['phone'] ?? '';
      addressController.text = widget.existingDetails!['address'] ?? '';
      areaController.text = widget.existingDetails!['area'] ?? '';
      pincodeController.text = widget.existingDetails!['pincode'] ?? '';
    }
  }
// addpickup(String name, String phone, String address, String area, String pincode) async {
//   try {
//     final Map<String, dynamic> data = {
//       // 'orderid': , // Replace with actual order ID if required
//       'name': name,
//       'username': 'email', // Replace with actual username if required
//       'mobile_no': phone,
//       'address': address,
//       'area': area,
//       'pincode': pincode,
//     };

//     final response = await http.post(
//       Uri.parse("http://192.168.29.62/courierservicephp/addpickup.php"),
//       body: data,
//     );

//     if (response.statusCode == 200) {
//       final responseBody = response.body;

//       if (responseBody.contains("success")) {
//         log("pickup address successfully added.");
//         Navigator.push(context, MaterialPageRoute(builder: (context) => CourierPage()));
//       } else {
//         log("Failed to add pickup address. Response: $responseBody");
//       }
//     } else {
//       log("Server error: ${response.statusCode}");
//     }
//   } catch (e) {
//     log("Error: ${e.toString()}");
//   }
// }
  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text("Add Pickup Address"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: TextFormField(
                      onChanged: (String value) {
                        setState(() {
                          name = value;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your Name";
                        }
                        return null;
                      },
                      controller: nameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintText: "Enter Name",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Mobile number",
                  style: TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the Mobile Number";
                        } else if (value.length != 10) {
                          return 'Please enter a valid 10-digit Mobile Number';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter only numeric digits';
                        }
                        return null;
                      },
                      controller: phoneController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintText: "Enter Mobile number",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Address",
                  style: TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: TextFormField(
                      onChanged: (String value) {
                        setState(() {
                          address = value;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your Address";
                        }
                        return null;
                      },
                      controller: addressController,
                      cursorColor: Colors.black,
                      maxLines: 2,
                      decoration: InputDecoration(
                          hintText: "Enter Address",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Area, street,sector",
                  style: TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: TextFormField(
                      onChanged: (String value) {
                        setState(() {
                          area = value;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your Area, Street, Sector";
                        }
                        return null;
                      },
                      controller: areaController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintText: "Enter area, street, sector",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Pincode",
                  style: TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: TextFormField(
                      onChanged: (String value) {
                        setState(() {
                          pincode = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the Mobile Number";
                        } else if (value.length != 6) {
                          return 'Please enter a valid 6-digit Mobile Number';
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter only numeric digits';
                        }
                        return null;
                      },
                      controller: pincodeController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintText: "Enter Pincode",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black38))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xfff071e30)),
                    child: TextButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          // Save address using provider
                          Map<String, String> newAddress = {
                            'name': nameController.text.trim(),
                            // 'phone': phoneController.text.trim(),
                            'address': addressController.text.trim(),
                            'area': areaController.text.trim(),
                            'phone': phoneController.text.trim(),
                            'pincode': pincodeController.text.trim(),
                          };

                          // Save the address to the AddressProvider
                          Provider.of<AddressProvider>(context, listen: false)
                              .setPickupAddress(newAddress);

                          // Navigate back to SavedAddressPage
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return CourierPage();
                          },));
                          // Navigator.pop(context, newAddress);
                        }},
                      child: Text(
                        "Add Pickup Address",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
