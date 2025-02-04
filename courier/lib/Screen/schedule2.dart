
// import 'package:courier/Screen/summery.dart';
// import 'package:flutter/material.dart';

// class SchedulePage2 extends StatefulWidget {
//   final DateTime selectedDate; 

//   const SchedulePage2({super.key, required this.selectedDate});

//   @override
//   State<SchedulePage2> createState() => _SchedulePage2State();
// }

// class _SchedulePage2State extends State<SchedulePage2> {
//   int currentStep = 2; 
//   bool isScheduleCompleted = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: const Icon(Icons.arrow_back_ios, color: Colors.black),
//         ),
//         title: const Text(
//           "Schedule Delivery",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   _buildProgressStep("ADDRESS",
//                       isActive: currentStep >= 0, isProcessed: currentStep > 0),
//                   _buildProgressDivider(),
//                   _buildProgressStep("PACKAGE",
//                       isActive: currentStep == 1, isProcessed: currentStep > 1),
//                   _buildProgressDivider(),
//                   _buildProgressStep("SCHEDULE",
//                       isActive: currentStep == 2, isProcessed: currentStep > 2),
//                   _buildProgressDivider(),
//                   _buildProgressStep("SUMMARY", isActive: currentStep == 3),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: const Text(
//                 "Selected Pickup Date",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height/10,
//                 decoration:BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(color: Colors.grey),
//                     color: Colors.white
//                   ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Text(
//                         "Selected Date: ${widget.selectedDate.day}-${widget.selectedDate.month}-${widget.selectedDate.year}",
//                         style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 height: MediaQuery.of(context).size.height / 20,
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Color(0xfff071e30)),
//                 child: TextButton(
//                   onPressed: () {
//                     setState(() {
//                       currentStep += 1;
//                       isScheduleCompleted = true;
//                     });
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SummaryPage()),
//                     );
//                   },
//                   child: Text(
//                     "Next",
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressStep(String title,
//       {bool isActive = false, bool isProcessed = false}) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 15,
//           backgroundColor: isProcessed
//               ? const Color(0xfff071e30)
//               : isActive
//                   ? Color(0xfff071e30)
//                   : Colors.grey[300],
//           child: isProcessed
//               ? Icon(Icons.check, size: 15, color: Colors.white)
//               : isActive
//                   ? Icon(
//                       Icons.circle,
//                       size: 10,
//                       color: Colors.white,
//                     )
//                   : SizedBox(),
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
// }

