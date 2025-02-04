import 'dart:developer';

import 'package:courier/COMMONVIEWMODEL/commonviewmodel.dart';
import 'package:courier/Map/calculation.dart';
import 'package:courier/Provider/addressprovider.dart';
import 'package:courier/Screen/deliveryaddress.dart';
import 'package:courier/Screen/package.dart';
import 'package:courier/Screen/pickupaddress.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../Map/mappage.dart';
import '../Map/searchmaaap.dart';

class CourierPage extends StatefulWidget {
  //   Map<String, String>? PickupAddress;
  //    Map<String, String>? DeliverAddress;
  //  CourierPage({super.key, this.PickupAddress, this.DeliverAddress});

  @override
  State<CourierPage> createState() => _CourierPageState();
}

class _CourierPageState extends State<CourierPage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Text(
          "Send a Package",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<AddressProvider>(
            builder: (context, addressProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    _buildProgressStep("ADDRESS",
                        isActive: currentStep >= 0,
                        isProcessed: currentStep > 0),
                    _buildProgressDivider(),
                    _buildProgressStep("PACKAGE", isActive: currentStep == 1),
                    _buildProgressDivider(),
                    _buildProgressStep("SCHEDULE", isActive: currentStep == 2),
                    _buildProgressDivider(),
                    _buildProgressStep("SUMMARY", isActive: currentStep == 3),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildAddressSection(
                title: "Pickup Address",
                addressDetails: addressProvider.savedAddresses.isNotEmpty
                    ? addressProvider.savedAddresses[0]
                    : null,
                onTap: () async {
                  log("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LocationPickerMap();
                    },
                  ));
                  // final updatedPickup = await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => PickupAddressPage(
                  //             address: '',
                  //             pincode: '',
                  //           )),
                  // );
                  // if (updatedPickup != null) {
                  //   setState(() {
                  //     addressProvider.setPickupAddress(updatedPickup);
                  //   });
                  // }
                },
              ),
              const SizedBox(height: 20),
              _buildAddressSection(
                title: "Delivery Address",
                addressDetails: addressProvider.deliveryaddress.isNotEmpty
                    ? addressProvider.deliveryaddress[0]
                    : null,
                onTap: () async {
                  final updatedDelivery = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationsearchMap()),
                  );
                  if (updatedDelivery != null) {
                    setState(() {
                      addressProvider.setDeliveryAddress(updatedDelivery);
                    });
                  }
                },
              ),
              const SizedBox(height: 40),
              if (addressProvider.savedAddresses.isNotEmpty &&
                  addressProvider.deliveryaddress.isNotEmpty)
                Center(
                  child: SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.9,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xfff071e30)),
                      child: TextButton(
                        onPressed: () {
                          final locationProvider =
                              Provider.of<LocationProvider>(context,
                                  listen: false);

                          LatLng pickupLocation =
                              locationProvider.selectedLocation;
                          LatLng deliveryLocation =
                              locationProvider.searchMapLocation;

                          if (pickupLocation.latitude != 0.0 &&
                              deliveryLocation.latitude != 0.0) {
                            double distance =
                                locationProvider.calculateDistance(
                                    pickupLocation, deliveryLocation);

                            log("Calculated distance: $distance km");

                            final vm = Provider.of<CommonViewModel>(context,
                                listen: false);
                            vm.fetchPricee(distance);

                            setState(() {
                              currentStep = 1;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PackagePage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Please select both pickup and delivery locations")),
                            );
                          }

                          // setState(() {
                          //   currentStep = 1;
                          // });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => PackagePage()),
                          // );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
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
                  ? Icon(
                      Icons.circle,
                      size: 10,
                      color: Colors.white,
                    )
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

  Widget _buildAddressSection({
    required String title,
    Map<String, String>? addressDetails,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: addressDetails == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/add.png",
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Add Address",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (addressDetails['name'] ?? "")
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    log("add address----------------------------------------------------");
                                    if (title == "Pickup Address") {
                                      final updateAddress =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PickupAddressPage(
                                                        existingDetails:
                                                            addressDetails,
                                                        area: '',
                                                        pincode: '',
                                                      )));

                                      if (updateAddress != null) {
                                        context
                                            .read<AddressProvider>()
                                            .setPickupAddress(updateAddress);
                                        // setState(() {
                                        //  widget. PickupAddress = updateAddress;
                                        // });
                                      }
                                    } else if (title == "Delivery Address") {
                                      final updateAddress =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DeliveryAddressPage(
                                                        existingDetails:
                                                            addressDetails,
                                                        area: '',
                                                        pincode: '',
                                                      )));

                                      if (updateAddress != null) {
                                        context
                                            .read<AddressProvider>()
                                            .setDeliveryAddress(updateAddress);
                                        // setState(() {
                                        //   widget.DeliverAddress = updateAddress;
                                        // });
                                      }
                                    }
                                    // final updatedAddress = await Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         DeliveryAddressPage(existingDetails: addressDetails),
                                    //   ),
                                    // );

                                    // if (updatedAddress != null) {
                                    //   setState(() {
                                    //     addressDetails = updatedAddress;
                                    //   });
                                    // }
                                  },
                                  child: Icon(Icons.edit, color: Colors.grey),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    log("Add address tapped!");

                                    if (title == "Pickup Address") {
                                      context
                                          .read<AddressProvider>()
                                          .deletePickupAddress();
                                    } else if (title == "Delivery Address") {
                                      context
                                          .read<AddressProvider>()
                                          .deleteDeliveryAddress();
                                    }
                                  },
                                  child: Icon(Icons.delete, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${(addressDetails?['address'] ?? "").split(' ').map((str) => str.isNotEmpty ? str[0].toUpperCase() + str.substring(1).toLowerCase() : '').join(' ')}, ${(addressDetails?['pincode'] ?? "").split(' ').map((str) => str.isNotEmpty ? str[0].toUpperCase() + str.substring(1).toLowerCase() : '').join(' ')}",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone,
                                size: 18, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Text(
                              addressDetails?['phone'] ?? "",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
