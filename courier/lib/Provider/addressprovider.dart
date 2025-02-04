import 'dart:developer';

import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  List<Map<String, String>> _savedAddresses = [];

  int pickupid = 0;

  List<Map<String, String>> get savedAddresses => _savedAddresses;
  int get getpickupid => pickupid;

  // Add a new address to the list
  void setPickupAddress(Map<String, String> newAddress) {
    _savedAddresses.add(newAddress);
    log("save address -------- provider ----- "+_savedAddresses.toString());
    notifyListeners();
  }

  // Remove an address from the list
  void removePickupAddress(int index, ) {
    _savedAddresses.removeAt(index);
    notifyListeners();
  }

  // Optionally: reset the addresses if needed
  void resetPickupAddress() {
    _savedAddresses.clear();
    notifyListeners();
  }

  void deletePickupAddress() {
    _savedAddresses.clear();
    notifyListeners();
  }

  List<Map<String, String>> _deliveryAddress = [];

  List<Map<String, String>> get deliveryaddress => _deliveryAddress;

  // Add a new address to the list
  void setDeliveryAddress(Map<String, String> newAddressee) {
   _deliveryAddress.add(newAddressee);
    notifyListeners();
  }

  // Remove an address from the list
  void removeDeliveryAddresse(int index) {
    _deliveryAddress.removeAt(index);
    notifyListeners();
  }

  // Optionally: reset the addresses if needed
  void resetDeliveryAddresse() {
    _deliveryAddress.clear();
    notifyListeners();
  }
   // Deletion Methods
  void deleteDeliveryAddress() {
    _deliveryAddress.clear();
    notifyListeners();
  }
}