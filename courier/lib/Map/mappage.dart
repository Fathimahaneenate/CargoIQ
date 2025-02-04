import 'package:courier/Map/calculation.dart';
import 'package:courier/Screen/pickupaddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class LocationPickerMap extends StatefulWidget {
  @override
  _LocationPickerMapState createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  String _currentAddress = "Fetching address...";
  bool _isLoadingLocation = true;
  

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  /// Fetch the user's current location
  Future<void> _fetchCurrentLocation() async {
    try {
      if (mounted) {
        setState(() {
          _isLoadingLocation = true;
        });
      }

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

      // Fetch current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      String address = await _getAddressFromLatLngUsingNominatim(currentLatLng);

      // Update provider with location and address
      if (mounted) {
        Provider.of<LocationProvider>(context, listen: false)
            .updateSelectedLocation(currentLatLng, address);

        setState(() {
          _isLoadingLocation = false;
          _currentAddress = address;
        });
      }
    } catch (e) {
      print("Error fetching location: $e");
      if (mounted) {
        setState(() {
          _currentAddress = "Failed to fetch location.";
          _isLoadingLocation = false;
        });
      }
    }
  }

  /// Reverse geocode using Nominatim API
  Future<String> _getAddressFromLatLngUsingNominatim(LatLng latLng) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${latLng.latitude}&lon=${latLng.longitude}";

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'] ?? "Address not found";
      } else {
        return "Failed to fetch address (API error).";
      }
    } catch (e) {
      print("Error fetching address using Nominatim: $e");
      return "Failed to fetch address.";
    }
  }

  /// Handle saving location
  void _onSaveLocationPressed() {
    final provider = context.read<LocationProvider>();
    // Log the current location details
    LatLng latLng = provider.selectedLocation;
  String address = provider.selectedLocationAddress;
  String pincode = extractPincode(address);
  String area = extractArea(address, pincode);

   // Log location and navigate
  print("Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}");
  print("Area: $area, Pincode: $pincode");

    // Navigate to the next page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickupAddressPage(
          existingDetails: {
            'latitude': latLng.latitude.toString(),
            'longitude': latLng.longitude.toString(),
            'pincode': pincode,
            'area': area,
          },
          area: area,
          pincode: pincode,
        ),
      ),
    );
  }

  /// Extract pincode from the address
  String extractPincode(String address) {
    final RegExp pincodeRegExp = RegExp(r'\b\d{5,6}\b');
    final match = pincodeRegExp.firstMatch(address);
    return match?.group(0) ?? 'N/A';
  }

  /// Get area (address without pincode)
  String extractArea(String address, String pincode) {
    return address.replaceAll(pincode, '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Location Picker Map")),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                    return FlutterMap(
                      options: MapOptions(
                        center: context.watch<LocationProvider>().selectedLocation,
                        zoom: 16.0,
                        onPositionChanged: (position, hasGesture) async {
                          if (hasGesture) {
                            String address = await _getAddressFromLatLngUsingNominatim(position.center!);
                            context.read<LocationProvider>().updateSelectedLocation(position.center!, address);
                            setState(() {
                              _currentAddress = address;
                            });
                          }
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: locationProvider.selectedLocation,
                              builder: (ctx) => const Icon(
                                Icons.location_on,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                if (_isLoadingLocation)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                ElevatedButton(
                  onPressed:
                      !_isLoadingLocation ? _onSaveLocationPressed : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Color(0xfff071e30)
                  ),
                  child: const Text("Save Location"),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                    onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PickupAddressPage(area: '', pincode: ''),
                      )
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
          
        ],
      ),
    );
  }
}

