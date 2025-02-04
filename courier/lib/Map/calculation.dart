
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider with ChangeNotifier {
  LatLng _selectedLocation = LatLng(0.0, 0.0);
  String _selectedLocationAddress = "";

  LatLng _searchMapLocation = LatLng(0.0, 0.0);
  String _searchMapAddress = "";

  LatLng get selectedLocation => _selectedLocation;
  String get selectedLocationAddress => _selectedLocationAddress;

  LatLng get searchMapLocation => _searchMapLocation;
  String get searchMapAddress => _searchMapAddress;

  /// Update selected location (used in LocationPickerMap)
  void updateSelectedLocation(LatLng location, String address) {
    _selectedLocation = location;
    _selectedLocationAddress = address;
    notifyListeners();
  }

  /// Update location in LocationsearchMap
  void updateLocationSearchMap(LatLng location, String address) {
    _searchMapLocation = location;
    _searchMapAddress = address;
    notifyListeners();
  }

  /// Calculate distance between two locations
  double calculateDistance(LatLng start, LatLng end) {
    final Distance distance = Distance();
    return distance.as(LengthUnit.Kilometer, start, end);
  }
}
