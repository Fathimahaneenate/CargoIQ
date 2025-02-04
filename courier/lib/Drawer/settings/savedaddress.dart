import 'package:courier/Provider/addressprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the saved addresses from the provider
    var savedAddresses = Provider.of<AddressProvider>(context).savedAddresses;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Saved Addresses",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color:Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: savedAddresses.isEmpty
          ? Center(
              child: Text(
                "No saved addresses",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: savedAddresses.length,
              itemBuilder: (context, index) {
                final address = savedAddresses[index];
                return _buildAddressCard(context, address, index);
              },
              
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle adding a new address
            print("Add New Address Pressed");
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Color(0xfff071e30),
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Add New Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, Map<String, String> address, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.deepPurple[50],
                  child: Icon(Icons.home, color: Color(0xfff071e30), size: 28),
                ),
                SizedBox(width: 12),
                Text(
                 ( address['name'] ?? '').toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff071e30),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "${address['address']}, ${address['area']}, ${address['pincode']}",
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
            SizedBox(height: 12),
            Divider(color: Colors.grey.shade300),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      address['phone'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle edit functionality
                        print('Edit pressed');
                      },
                      child: Text(
                        'EDIT',
                        style: TextStyle(
                          color: Color(0xfff071e30),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    TextButton(
                      onPressed: () {
                        // Remove the address from the list
                        Provider.of<AddressProvider>(context, listen: false)
                            .removePickupAddress(index);
                      },
                      child: Text(
                        'DELETE',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
