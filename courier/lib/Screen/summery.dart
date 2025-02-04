import 'dart:developer';
import 'package:courier/Map/calculation.dart';
import 'package:courier/Provider/priceprovider.dart';
import 'package:courier/Screen/deliveryaddress.dart';
import 'package:courier/Screen/package.dart';
import 'package:courier/Screen/confirmation.dart';
import 'package:courier/Screen/paymnet.dart';
import 'package:courier/Screen/pickupaddress.dart';
import 'package:courier/Screen/schedule.dart';
import 'package:courier/Screen/schedule2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../COMMONVIEWMODEL/commonviewmodel.dart';
import '../Provider/addressprovider.dart';
import '../Provider/sammeryprovider.dart';

class SummaryPage extends StatefulWidget {
  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  int currentStep = 3;

  late final List<String> selectedPackageContents;
  late final String selectedPackageSize;
  double? sizeprice;
  late final String selectedPackageType;
  DateTime? selectedScheduleDate;
  late final List<Map<String, String>> _savedAddresses;
  late final Map<String, String> _deliveryAddress;

  bool _isInitialized = false;

  CommonViewModel? vm;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    var commonViewModel = Provider.of<CommonViewModel>(context, listen: false);
    final summaryProvider = context.read<SummaryProvider>();
    double sizeprice123 =
        double.parse(summaryProvider.getPackageSizeWeightPrice.toString());
    log("selectedPackageSize888888888888888888888888888888888888 " +
        sizeprice123.toString());
    commonViewModel.calculateTotalPrice(double.parse(sizeprice123.toString()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final summaryProvider = context.read<SummaryProvider>();
      selectedPackageContents = summaryProvider.selectedPackageContents;
      selectedPackageType = summaryProvider.selectedPackageType;
      selectedPackageSize = summaryProvider.selectedPackageSize;
      // sizeprice=double.parse(summaryProvider.getPackageSizeWeightPrice.toString());
      selectedScheduleDate = summaryProvider.scheduleDate;

      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Send a Package",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildProgressStep("ADDRESS",
                    isActive: currentStep >= 0, isProcessed: currentStep > 0),
                _buildProgressDivider(),
                _buildProgressStep("PACKAGE",
                    isActive: currentStep >= 1, isProcessed: currentStep > 1),
                _buildProgressDivider(),
                _buildProgressStep("SCHEDULE",
                    isActive: currentStep >= 2, isProcessed: currentStep > 2),
                _buildProgressDivider(),
                _buildProgressStep("SUMMARY", isActive: currentStep == 3),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("ADDRESS DETAILS"),
                    _buildAddressDetails(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildSectionHeader("PACKAGE DETAILS"),
                    _buildPackageDetails(),
                    SizedBox(
                      height: 3,
                    ),
                    _buildSectionHeader("PICKUP SCHEDULE"),
                    _buildScheduleDetails(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Inside the widget where you want to display the price
                Consumer<CommonViewModel>(
                  builder: (context, CommonViewModel, child) {
                    return Column(
                      children: [
                        // Display total price in Text widget
                        Text(
                          '    ₹${CommonViewModel.totalPrice.toString()}', // Prefix the rupee symbol
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 25,
                              fontWeight: FontWeight
                                  .bold), // Optional: Customize the style
                        ),
                      ],
                    );
                  },
                ),
                // Text(CommonViewModel.),

                ElevatedButton(
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

                    try {
                      // Access the CommonViewModel
                      vm = Provider.of<CommonViewModel>(context, listen: false);

                      await Future.delayed(Duration(seconds: 2));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Something went wrong. Please try again!")),
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                    "Proceed to Pay",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(String title,
      {bool isActive = false, bool isProcessed = false}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? Color(0xfff071e30) : Colors.grey[300],
          child: isProcessed
              ? Icon(Icons.check, size: 15, color: Colors.white)
              : isActive
                  ? Icon(Icons.circle, size: 10, color: Colors.white)
                  : SizedBox(),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isActive || isProcessed ? Color(0xfff071e30) : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressDivider() {
    return Expanded(
      child: Divider(
        thickness: 2,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildAddressDetails() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.home, color: Color(0xfff071e30)),
            title: Text(
              "Pickup Address",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // subtitle: Text(context
            //     .watch<AddressProvider>()
            //     .savedAddresses
            //     .map((address) => address.values.join(', '))
            //     .join('; ')),
            subtitle: Text(
              context
                  .watch<AddressProvider>()
                  .savedAddresses
                  .map((address) => address.values.map((value) {
                        return value[0].toUpperCase() + value.substring(1);
                      }).join(', '))
                  .join('; '),
            ),

            trailing: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PickupAddressPage(
                              area: '',
                              pincode: '',
                            )));
              },
              child: Text(
                "Update",
                style: TextStyle(color: Color.fromARGB(255, 195, 130, 77)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.local_shipping, color: Color(0xfff071e30)),
            title: Text(
              "Delivery Address",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              context.watch<AddressProvider>().deliveryaddress.isNotEmpty
                  ? context
                      .watch<AddressProvider>()
                      .deliveryaddress
                      .map((addresse) => addresse.values.map((value) {
                            return value[0].toUpperCase() + value.substring(1);
                          }).join(', '))
                      .join('; ')
                  : 'No delivery address added',
            ),
            trailing: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeliveryAddressPage(
                              area: '',
                              pincode: '',
                            )));
              },
              child: Text(
                "Update",
                style: TextStyle(color: Color.fromARGB(255, 195, 130, 77)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<LocationProvider>(
            builder: (context, provider, child) {
              if (provider.selectedLocation.latitude != 0.0 &&
                  provider.searchMapLocation.latitude != 0.0) {
                double distance = provider.calculateDistance(
                  provider.selectedLocation,
                  provider.searchMapLocation,
                );
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 210),
                    child: Text(
                      "Distance: ${distance.toStringAsFixed(2)} km",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              } else {
                return Text(
                  "Select both locations to calculate distance.",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPackageDetails() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.inventory, color: Color(0xfff071e30)),
        title: Text(
          '${selectedPackageContents.join(', ')}'.replaceFirst(
            '${selectedPackageContents.join(', ')}'[0],
            '${selectedPackageContents.join(', ')}'[0].toUpperCase(),
          ),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        // title: Text(' ${selectedPackageContents.join(', ')}', style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(' Size: $selectedPackageSize'),
        trailing: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PackagePage()));
          },
          child: Text(
            "Update",
            style: TextStyle(color: Color.fromARGB(255, 195, 130, 77)),
          ),
        ),
      ),
    );
  }

  // Widget _buildScheduleDetails() {
  //   return Container(
  //     color: Colors.white,
  //     margin: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: ListTile(
  //       leading: Icon(Icons.calendar_today, color: Color(0xfff071e30)),
  //       title: Text(
  //         "Date:  ${selectedScheduleDate != null ? selectedScheduleDate!.toLocal().toString().split(' ')[0] : 'Not selected'}",
  //         style: TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //       // subtitle: Text("Time Slot: 07:00 AM - 7:00 PM"),
  //       trailing: TextButton(
  //         onPressed: () async {
  //           final selectedDate = await Navigator.push<DateTime>(
  //             context,
  //             MaterialPageRoute(builder: (context) => SchedulePage()),
  //           );
  //           if (selectedDate != null) {
  //             context.read<SummaryProvider>().setScheduleDate(selectedDate);
  //           }
  //         },
  //         child: Text(
  //           "Update",
  //           style: TextStyle(color: Color.fromARGB(255, 195, 130, 77)),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildScheduleDetails() {
    return Consumer<SummaryProvider>(
      builder: (context, summaryProvider, child) {
        return Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(Icons.calendar_today, color: Color(0xfff071e30)),
            title: Text(
              "Date:  ${summaryProvider.scheduleDate != null ? summaryProvider.scheduleDate!.toLocal().toString().split(' ')[0] : 'Not selected'}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: TextButton(
              onPressed: () async {
                final selectedDate = await Navigator.push<DateTime>(
                  context,
                  MaterialPageRoute(builder: (context) => SchedulePage()),
                );
                if (selectedDate != null) {
                  summaryProvider.setScheduleDate(selectedDate);
                }
              },
              child: Text(
                "Update",
                style: TextStyle(color: Color.fromARGB(255, 195, 130, 77)),
              ),
            ),
          ),
        );
      },
    );
  }
}

