// import 'package:courier/Map/calculation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // For using ChangeNotifierProvider


// class DistanceDisplayPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<LocationProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text("Distance")),
//       body: Center(
//         child: provider.areBothLocationsSelected
//             ? Text(
//                 "Distance: ${provider.calculatedDistance.toStringAsFixed(2)} km",
//                 style: TextStyle(fontSize: 24),
//               )
//             : Text("Select both origin and destination."),
//       ),
//     );
//   }
// }
