

import 'package:courier/COMMONVIEWMODEL/commonviewmodel.dart';
import 'package:courier/MODEL/getordermodel.dart';
import 'package:courier/Screen/qrpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  CommonViewModel? vm;

  @override
  void initState() {
    super.initState();
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.fetchNewOrderss(); // Fetch orders dynamically
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Order History',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              splashFactory: NoSplash.splashFactory,
              tabs: [
                Tab(
                  child: Text(
                    'Active Orders',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Tab(
                  child: Text(
                    'Past Orders',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Consumer<CommonViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.getorderlist == null || vm.getorderlist!.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }

            final activeOrders = vm.getorderlist!
                .where((order) => order.deliveryStatus == 0)
                .toList();
            final pastOrders = vm.getorderlist!
                .where((order) => order.deliveryStatus == 1)
                .toList();

            return TabBarView(
              children: [
                _buildOrderList(activeOrders, 'Active Orders'),
                _buildOrderList(pastOrders, 'Past Orders'),
              ],
            );
          },
        ),
      ),
    );
  }

  // Widget _buildOrderList(List<GetorderModel> orders, String type) {
  //   if (orders.isEmpty) {
  //     return Center(child: Text('No $type available.'));
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: ListView.builder(
  //       itemCount: orders.length,
  //       itemBuilder: (context, index) {
  //         final order = orders[index];
  //         return _buildOrderCard(
  //           title: ' ${order.content}',
  //           price: '₹${order.price}',
  //           status: type == 'Active Orders' ? 'Order In Progress' : 'Order Delivered',
  //           date: type == 'Active Orders'
  //               ? 'Expected: ${order.deliveryDate}'
  //               : 'Delivered: ${order.deliveryDate}',
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget _buildOrderList(List<GetorderModel> orders, String type) {
  if (orders.isEmpty) {
    return Center(child: Text('No $type available.'));
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(
          title: ' ${order.content}',
          price: '₹${order.price}',
          status: type == 'Active Orders' ? 'Order In Progress' : 'Order Delivered',
          order_id: 'Order ID: ${order.orderId}',
          // date: type == 'Active Orders'
          //     ? 'Expected: ${_formatDate(order.deliveryDate)}' // Show only the date
          //     : 'Delivered: ${_formatDate(order.deliveryDate)}', // Show only the date

        );
      },
    ),
  );
}

String _formatDate(DateTime? date) {
  if (date == null) return ''; // Return an empty string if the date is null
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd'); // Format the date as yyyy-MM-dd
  return dateFormat.format(date); // Return the formatted date
}


  Widget _buildOrderCard({
    required String title,
    required String price,
    required String status,
    required String order_id,
    // required String date,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: const TextStyle(color: Colors.green, fontSize: 14),
                ),
                const SizedBox(height: 4),
                // Text(
                //   date,
                //   style: const TextStyle(color: Colors.grey),
                // ),
                 Text(
                  order_id,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Positioned(top: 0,
            right: 0,
              child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> QrExample(orderId: order_id)));
              }, icon: Icon(Icons.qr_code)))
          ],
        ),
      ),
    );
  }
}
