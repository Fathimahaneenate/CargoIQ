// import 'package:flutter/material.dart';

// class ProcessBar extends StatelessWidget {
//    final int currentStep;
//   const ProcessBar({Key? key, required this.currentStep}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//       padding: EdgeInsets.all(16),
//       child: Row(
//         children: [
//                   _buildProgressStep("ADDRESS", isActive: currentStep >= 0, isProcessed: currentStep > 0),
//                   _buildProgressDivider(),
//                   _buildProgressStep("PACKAGE", isActive: currentStep == 1, isProcessed: currentStep > 1),
//                   _buildProgressDivider(),
//                   _buildProgressStep("SCHEDULE", isActive: currentStep == 2, isProcessed: currentStep >2),
//                   _buildProgressDivider(),
//                   _buildProgressStep("SUMMARY", isActive:  currentStep == 3),
//         ],
//       ),
//     );
//   }
// }
//  Widget _buildProgressStep(String title, {bool isActive = false, bool isProcessed = false}) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 15,
//           backgroundColor: isActive ?Color(0xfff071e30) : Colors.grey[300],
//           child: isProcessed
//               ? Icon(Icons.check, size: 15, color: Colors.white)
//               : isActive
//               ? Icon(Icons.circle, size: 10, color: Colors.white,)
//               : SizedBox(),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 12,
//             color: isActive || isProcessed ? Color(0xfff071e30) : Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProgressDivider() {
//     return Expanded(
//       child: Divider(
//         thickness: 2,
//         color: Colors.grey[300],
//       ),
//     );
//   }