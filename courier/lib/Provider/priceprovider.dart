// import 'package:courier/MODEL/distancemodel.dart';
// import 'package:flutter/material.dart';


// class DistanceProvider with ChangeNotifier {
//   DistanceModel _distance = DistanceModel();
  
//   // Variables to store selected package size and weight price
//   String? selectedPackageSize;
//   int? packageSizeIds;
//   int? selectedPackageSizeWeightPrice;

//   DistanceModel get distance => _distance;

//   // Method to update the price based on distance
//   void updatePrice(int? newPrice) {
//     _distance = DistanceModel(price: newPrice);
//     notifyListeners();
//   }

//   // Method to calculate the total price
//   int calculateTotalPrice() {
//     // If both distance price and weight price are set
//     if (_distance.price != null && selectedPackageSizeWeightPrice != null) {
//       return (_distance.price ?? 0) + selectedPackageSizeWeightPrice!;
//     }
//     return 0; // Return 0 if either price is not available
//   }
// }
