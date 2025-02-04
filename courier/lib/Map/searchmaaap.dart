

import 'package:courier/Map/calculation.dart';
import 'package:courier/Screen/deliveryaddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class LocationsearchMap extends StatefulWidget {
  @override
  _LocationsearchMapState createState() => _LocationsearchMapState();
}

class _LocationsearchMapState extends State<LocationsearchMap> {
  LatLng _currentLatLng = LatLng(0.0, 0.0); // Default coordinates
  String _currentAddress = "Fetching address...";
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  bool _isDraggingMap = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  // Fetch the current location of the user
  Future<void> _fetchCurrentLocation() async {
    try {
      // Ensure location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled. Please enable them.");
      }

      // Request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            "Location permissions are permanently denied. Please allow access in settings.");
      }

      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });
      context
          .read<LocationProvider>()
          .updateLocationSearchMap(_currentLatLng, "");
      _mapController.move(_currentLatLng, 16.0);
      await _getAddressFromLatLngUsingNominatim(_currentLatLng);
    } catch (e) {
      print("Error fetching location: $e");
      setState(() {
        _currentAddress = "Failed to fetch location.";
      });
    }
  }

  // Reverse geocode the coordinates to get the address
  Future<void> _getAddressFromLatLngUsingNominatim(LatLng latLng) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${latLng.latitude}&lon=${latLng.longitude}";

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _currentAddress = data['display_name'] ?? "Address not found";
        });
      } else {
        setState(() {
          _currentAddress = "Failed to fetch address (API error).";
        });
      }
    } catch (e) {
      print("Error fetching address using Nominatim: $e");
      setState(() {
        _currentAddress = "Failed to fetch address.";
      });
    }
  }

  // Search for a place and update the map and address
  Future<void> _searchAndMoveMap(String query) async {
    final url =
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=1";

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          LatLng newLatLng = LatLng(lat, lon);
          setState(() {
            _currentLatLng = newLatLng;
          });
          _mapController.move(newLatLng, 16.0);
          await _getAddressFromLatLngUsingNominatim(newLatLng);
        } else {
          _showErrorDialog("No results found for the search query.");
        }
      } else {
        _showErrorDialog("Failed to fetch search results.");
      }
    } catch (e) {
      print("Error during search: $e");
      _showErrorDialog(
          "An error occurred during the search. Please try again.");
    }
  }

  // Show an error dialog if the search fails
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Search Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Extract pincode from address using regex
  String extractPincode(String address) {
    final RegExp pincodeRegExp = RegExp(r'\b\d{5,6}\b');
    final match = pincodeRegExp.firstMatch(address);
    return match?.group(0) ?? 'N/A';
  }

  // Extract the area (address without pincode)
  String extractArea(String address, String pincode) {
    return address.replaceAll(pincode, '').trim();
  }

  // Handle saving the selected location
  void _onSaveLocationPressed() {
    final provider = context.read<LocationProvider>();
    String pincode = extractPincode(_currentAddress);
    String area = extractArea(_currentAddress, pincode);

 // Calculate the distance between two points (if needed)
    double distance = provider.calculateDistance(
    provider.selectedLocation, // Pickup location
    provider.searchMapLocation, // Destination location
  );

  print("Distance between origin and destination: $distance km");

    // Log the current location details
    print(
        "Saving Location: Latitude = ${_currentLatLng.latitude}, Longitude = ${_currentLatLng.longitude}");
    print("Address: $_currentAddress");
    print("Area: $area, Pincode: $pincode");

    // Navigate to the next page with the location details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryAddressPage(
          existingDetails: {
            'pincode': pincode,
            'area': area,
            'distance': distance.toString(),
            
          },
          area: area,
          pincode: pincode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Map widget
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _currentLatLng,
                zoom: 16.0,
                onPositionChanged: (position, hasGesture) {
                  if (hasGesture) {
                    setState(() {
                      _isDraggingMap = true;
                      _currentLatLng = position.center!;
                    });
                    context.read<LocationProvider>().updateLocationSearchMap(
                          _currentLatLng,
                          "",
                        );
                  } else {
                    setState(() {
                      _isDraggingMap = false;
                    });
                    _getAddressFromLatLngUsingNominatim(_currentLatLng);
                    context.read<LocationProvider>().updateLocationSearchMap(
              _currentLatLng,
              _currentAddress,
            );
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLatLng,
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Search bar at the top
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for a place",
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    _searchAndMoveMap(query);
                  }
                },
              ),
            ),
          ),

          // Address information and action buttons at the bottom
          Positioned(
            bottom: keyboardHeight > 0 ? keyboardHeight : 0,
            left: 1,
            right: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display current address
                  Text(
                    _currentAddress,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "*Autoselected based on dropped pin",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  // Save Location button
                  ElevatedButton(
                    onPressed: _onSaveLocationPressed,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Color(0xfff071e30)),
                    child: const Text("Save Location"),
                  ),
                  const SizedBox(height: 8),
                  // Add Address Manually button
                  OutlinedButton(
                    onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeliveryAddressPage(area: '', pincode: ''),
                      ),
                     );
                    },
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text("Add address manually",
                    style: TextStyle(color: Color(0xfff071e30)),),
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
