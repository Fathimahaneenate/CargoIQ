// import 'package:courier/Map/calculation.dart';
// import 'package:courier/Provider/priceprovider.dart';
// import 'package:courier/Provider/sammeryprovider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void updatePrice(BuildContext context) {
//   final locationProvider = context.read<LocationProvider>();
//   final priceProvider = context.read<PriceProvider>();
//   final summaryProvider = context.read<SummaryProvider>();

//   final distance = locationProvider.calculateDistance(
//     locationProvider.selectedLocation,
//     locationProvider.searchMapLocation,
//   );

//   final weightPrice = summaryProvider.getPackageSizeWeightPrice;

//   // Call calculateTotalPrice to update the price based on distance and weight
//   priceProvider.calculateTotalPrice(distance, weightPrice);
// }
