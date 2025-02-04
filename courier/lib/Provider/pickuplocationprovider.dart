import 'package:flutter/material.dart';

class PickupLocationProvider with ChangeNotifier {
  double? _pickupLat;
  double? _pickupLon;

  double? get pickupLat => _pickupLat;
  double? get pickupLon => _pickupLon;

  // Set pickup location
  void setPickupLocation(double lat, double lon) {
    _pickupLat = lat;
    _pickupLon = lon;
    notifyListeners(); // Notify listeners to update UI
  }
}