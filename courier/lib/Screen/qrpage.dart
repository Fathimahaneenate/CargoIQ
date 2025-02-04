import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrExample extends StatefulWidget {
  final String orderId;

  const QrExample({super.key, required this.orderId});

  @override
  State<QrExample> createState() => _QrExampleState();
}

class _QrExampleState extends State<QrExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
      ),
      body: Center(
        child: QrImageView(
          data: widget.orderId, // Use the passed order ID
          version: QrVersions.auto,
          size: 280,
          gapless: false,
        ),
      ),
    );
  }
}
