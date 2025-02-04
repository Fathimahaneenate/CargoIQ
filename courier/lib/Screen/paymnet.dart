import 'dart:developer';
import 'package:courier/COMMONVIEWMODEL/commonviewmodel.dart';
import 'package:courier/Screen/confirmation.dart';
import 'package:courier/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/addressprovider.dart';
import '../Provider/sammeryprovider.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod = ''; // To hold the selected payment method

  CommonViewModel? vm;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // title: Text('Choose Payment Method', style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Method Selection
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            // Radio button for Online Payment
            ListTile(
              title: Text('Online Payment'),
              leading: Radio<String>(
                activeColor: Color(0xfff071e30),
                value: 'Online Payment',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            // Radio button for Cash on Delivery
            ListTile(
              title: Text('Cash on Delivery'),
              leading: Radio<String>(
                activeColor: Color(0xfff071e30),
                value: 'Cash on Delivery',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
              ),
            ),
            SizedBox(height: 32),
            // Confirm button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xfff071e30),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                 onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (selectedPaymentMethod != null &&
                      selectedPaymentMethod!.isNotEmpty) {
                    final addressProvider =
                        Provider.of<AddressProvider>(context, listen: false);
                    final summaryProvider =
                        Provider.of<SummaryProvider>(context, listen: false);

                    try {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String? email = prefs.getString('email');

                      if (email == null || email.isEmpty) {
                        log('Email not found in SharedPreferences');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Email not found. Please log in again.')),
                        );
                        return;
                      }

                      final vm =
                          Provider.of<CommonViewModel>(context, listen: false);

                      // Get pickup and delivery addresses
                      final pickupAddress = addressProvider.savedAddresses.first;
                      final deliveryAddress = addressProvider.deliveryaddress.first;

                      // Create order data including pickup and delivery information
                      final Map<String, dynamic> orderse = {
                        'username': email,
                        'package_id': summaryProvider.packageTypeIds,
                        'size_id': summaryProvider.packageSizeIds,
                        'content_id':
                            summaryProvider.packageContentIds.join(','),
                        'price': vm.totalPrice.toString(),
                        'pickup_date':
                            summaryProvider.scheduleDate?.toIso8601String() ??
                                '',
                        'delivery_date':
                            summaryProvider.scheduleDate?.toIso8601String() ??
                                '',
                        'amount_safety': 50.0,
                        'is_safe': 1,
                        'delivery_status': 0,
                        'payment': selectedPaymentMethod == 'Online Payment' ? 1 : 0,
                        'pickup_name': pickupAddress['name'],
                        'pickup_mobile_no': pickupAddress['phone'],
                        'pickup_address': pickupAddress['address'],
                        'pickup_area': pickupAddress['area'],
                        'pickup_pincode': pickupAddress['pincode'],
                        'delivery_name': deliveryAddress['name'],
                        'delivery_mobile_no': deliveryAddress['phone'],
                        'delivery_address': deliveryAddress['address'],
                        'delivery_area': deliveryAddress['area'],
                        'delivery_pincode': deliveryAddress['pincode'],
                      };

                      log("Order Data: $orderse");

                      // Call the API to place the order
                      await vm
                          .ordersss(
                        orderse['username'],
                        orderse['package_id'],
                        orderse['size_id'],
                        orderse['content_id'].toString(),
                        orderse['price'].toString(),
                        orderse['pickup_date'].toString(),
                        orderse['delivery_date'].toString(),
                        orderse['amount_safety'].toString(),
                        orderse['is_safe'].toString(),
                        orderse['delivery_status'],
                        orderse['payment'],
                        orderse['pickup_name'],
                        orderse['pickup_mobile_no'],
                        orderse['pickup_address'],
                        orderse['pickup_area'],
                        orderse['pickup_pincode'],
                        orderse['delivery_name'],
                        orderse['delivery_mobile_no'],
                        orderse['delivery_address'],
                        orderse['delivery_area'],
                        orderse['delivery_pincode'],
                      )
                          .then((value) {
                        if (vm.responsee?.status == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(vm.responsee!.msg.toString())),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmationPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Error: ${vm.responsee?.msg ?? 'Unknown error'}')),
                          );
                        }
                      }).catchError((error) {
                        log('Error placing order: $error');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('An error occurred: $error')),
                        );
                      });
                    } catch (e) {
                      log('Error: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occurred: $e')),
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a payment method')),
                    );
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                :
                Text('Confirm',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
