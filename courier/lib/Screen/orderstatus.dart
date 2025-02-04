import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:courier/COMMONVIEWMODEL/commonviewmodel.dart'; // Add your CommonViewModel import

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  String trackingID = "";

  @override
  void initState() {
    super.initState();
    _loadTrackingID();
  }

  Future<void> _loadTrackingID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      trackingID = prefs.getString('trackingID') ?? "No tracking ID found";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/traaaacking.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Order ID :",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    trackingID,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Padding(
            //   padding: EdgeInsets.only(left: 30),
            //   child: Text(
            //     "Order Status",
            //     style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Color(0xfff071e30)),
            //   ),
            // ),

            // Consumer to display dynamic tracking data
            Consumer<CommonViewModel>(
              builder: (context, viewModel, child) {
                // Show loading indicator while fetching tracking data
                if (viewModel.istrackingLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                // Show message if no tracking data is available
                if (viewModel.trackdata == null) {
                  return Center(child: Text('No tracking data available.'));
                }
                
                // Display tracking details once data is fetched
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Order ID: ${viewModel.trackdata?.orderId}'),
                    // SizedBox(height: 10),
                    Center(
                      child: Text(
                          ' ${_getStatusText(viewModel.trackdata?.deliveryStatus)}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ),

                    // Display dynamic timeline based on delivery status
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Order Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          _buildTimelineTile("Pending..", viewModel.trackdata!.deliveryStatus! >= 0,0),
                          _buildTimelineTile("Order Disptached", viewModel.trackdata!.deliveryStatus! >= 1,0),
                          _buildTimelineTile("Delivered", viewModel.trackdata!.deliveryStatus! >= 2,0),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to map deliveryStatus to text
  // Modify the _getStatusText to return both the status and the color
String _getStatusText(int? status) {
  if (status == null) {
    return 'Unknown';
  }
  switch (status) {
    case 0:
      return 'Pending..'; // Default color is black or any color you want
    case 1:
      return 'Order Dispatched'; // Red color
    case 2:
      return 'Delivered'; // Green color
    default:
      return 'Unknown Status';
  }
}

// Modify _buildTimelineTile to use different colors for each status
Widget _buildTimelineTile(String text, bool isActive, int status) {

  print('Status: $status, isActive: $isActive');
  // Get the status text and associated color
  Color textColor;
  switch (status) {
    case 0:
      textColor = Colors.black; // Pending
      break;
    case 1:
      textColor = Colors.red; // Dispatched
      break;
    case 2:
      textColor = Colors.green; // Delivered
      break;
    default:
      textColor = Colors.grey; // Unknown
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(
            isActive ? Icons.check : Icons.circle,
            color: isActive ? Color(0xff071e30) : Colors.grey,
            size: 20,
          ),
          if (isActive)
            Container(
              height: 80,
              width: 2,
              color: Color(0xff071e30),
            ),
        ],
      ),
      SizedBox(width: 10),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: textColor, // Apply dynamic color based on status
            ),
          ),
        ),
      ),
    ],
  );
}

}
