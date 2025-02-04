
///// Courier page /////

// import 'package:courier/Screen/deliveryaddress.dart';
// import 'package:courier/Screen/pickupaddress.dart';
// import 'package:flutter/material.dart';

// class CourierPage extends StatefulWidget {
//   const CourierPage({super.key});

//   @override
//   State<CourierPage> createState() => _CourierPageState();
// }

// class _CourierPageState extends State<CourierPage> {
//   Map<String, String>? PickupAddress;
//   Map<String, String>? DeliverAddress;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         surfaceTintColor: Colors.white,
//         leading: Icon(
//           Icons.arrow_back_ios,
//           color: Colors.black,
//         ),
//         title: Text("Send a Package"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(left: 16, right: 16, top: 50),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Pickup Address
//               Text(
//                 "Pickup Address",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 15),
//               GestureDetector(
//                 onTap: () async {
//                   final updatedPickup = await Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PickupAddressPage()),
//                   );
//                   if (updatedPickup != null) {
//                     setState(() {
//                       PickupAddress = updatedPickup;
//                     });
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(10),
//                   margin: EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: PickupAddress == null
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.location_on, color: Colors.black),
//                             SizedBox(width: 10),
//                             Text(
//                               "Add Pickup Address",
//                               style: TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Name: ${PickupAddress!['name']}"),
//                             Text("Phone: ${PickupAddress!['phone']}"),
//                             Text("Address: ${PickupAddress!['address']}"),
//                             Text("Area: ${PickupAddress!['area']}"),
//                             Text("Pincode: ${PickupAddress!['pincode']}"),
//                           ],
//                         ),
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Delivery Address
//               Text(
//                 "Delivery Address",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 15),
//               GestureDetector(
//                 onTap: () async {
//                   final updatedDelivery = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DeliveryAddressPage(
//                         existingDetails: DeliverAddress,
//                       ),
//                     ),
//                   );
//                   if (updatedDelivery != null) {
//                     setState(() {
//                       DeliverAddress = updatedDelivery;
//                     });
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(10),
//                   margin: EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: DeliverAddress == null
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.location_on, color: Colors.black),
//                             SizedBox(width: 10),
//                             Text(
//                               "Add Delivery Address",
//                               style: TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Name: ${DeliverAddress!['name']}"),
//                             Text("Phone: ${DeliverAddress!['phone']}"),
//                             Text("Address: ${DeliverAddress!['address']}"),
//                             Text("Area: ${DeliverAddress!['area']}"),
//                             Text("Pincode: ${DeliverAddress!['pincode']}"),
//                           ],
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



///////////// Two types of content /////////////


///// 1//////

//      return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: isSelected ? Colors.black : Colors.grey,
//       ),
//       borderRadius: BorderRadius.circular(8),
//     ),
//     child: Row(
//       children: [
//         Checkbox(
//           value: isSelected,
//           checkColor: Colors.white,
//           activeColor: Colors.black,
//           onChanged: (bool? value) {
//             setState(() {
//               if (value == true) {
//                 selectedPackageContents.add(content);
//               } else {
//                 selectedPackageContents.remove(content);
//               }
//             });
//           },
//         ),
//         const SizedBox(width: 10),
//         Icon(icon, size: 30, color: Colors.black),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Text(
//             content,
//             style: const TextStyle(fontSize: 16),
//           ),
//         ),
//       ],
//     ),
//   );
// }

////// 2 ///////

    //  GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       selectedPackageContent = content;
    //     });
    //   },
    //   child: Card(
    //     color: selectedPackageContent == content ? Color.fromARGB(255, 10, 39, 61) : Colors.white,
    //     elevation: selectedPackageContent == content ? 4 : 1,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         children: [
    //           Text(
    //             content,
    //             style: TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: selectedPackageContent == content ? Colors.white : Colors.black,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );


/////////////////////// Create Profile ////////////
// import 'package:flutter/material.dart';

// class CreateProfilePage extends StatefulWidget {
//   @override
//   _CreateProfilePageState createState() => _CreateProfilePageState();
// }

// class _CreateProfilePageState extends State<CreateProfilePage> {
//   bool isAccepted = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SafeArea(
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Create Your Profile",
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           "Track your packages and much more.",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: "First name",
//                             hintStyle: TextStyle(color: Colors.grey),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: "Last name",
//                             hintStyle: TextStyle(color: Colors.grey),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: "you@example.com",
//                             hintStyle: TextStyle(color: Colors.grey),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Spacer(),
//                         RichText(
//                           text: TextSpan(
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 11,
//                             ),
//                             children: [
//                               TextSpan(text: "Our "),
//                               TextSpan(
//                                 text: "Privacy Policy",
//                                 style: TextStyle(color: Colors.blue),
//                               ),
//                               TextSpan(
//                                   text:
//                                       " outlines what personal data we collect, why we collect it, and how we use it. Our "),
//                               TextSpan(
//                                 text: "Conditions of Use",
//                                 style: TextStyle(color: Colors.blue),
//                               ),
//                               TextSpan(
//                                   text:
//                                       " govern your access and use of this application."),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         Row(
//                           children: [
//                             Checkbox(
//                               value: isAccepted,
//                               onChanged: (value) {
//                                 setState(() {
//                                   isAccepted = value!;
//                                 });
//                               },
//                             ),
//                             Expanded(
//                               child: Text(
//                                 "I have read and I accept the Privacy Policy and Conditions of Use",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: isAccepted
//                                 ? () {
//                                     // Replace this with navigation to your home screen
//                                     Navigator.pop(context);
//                                   }
//                                 : null,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   isAccepted ? Colors.blue : Colors.grey[400],
//                               padding: EdgeInsets.symmetric(vertical: 15),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: Text(
//                               "Create Your Account",
//                               style: TextStyle(fontSize: 16, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:courier/homescreen/homescreen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CreateProfilePage extends StatefulWidget {
//   @override
//   _CreateProfilePageState createState() => _CreateProfilePageState();
// }

// class _CreateProfilePageState extends State<CreateProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   Future<void> _saveUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('firstName', firstNameController.text);
//     await prefs.setString('lastName', lastNameController.text);
//     await prefs.setString('email', emailController.text);
//   }

//   bool isAccepted = false;

//   @override
//   Widget build(BuildContext context) {
//     final bottomInset = MediaQuery.of(context).viewInsets.bottom;

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Create Your Profile",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "Track your packages and much more.",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "First name",
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "Last name",
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: "you@example.com",
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: bottomInset > 0 ? 20 : 220),
//                 RichText(
//                   text: TextSpan(
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 12,
//                     ),
//                     children: [
//                       TextSpan(text: "Our "),
//                       TextSpan(
//                         text: "Privacy Policy",
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                       TextSpan(
//                           text:
//                               " outlines what personal data we collect, why we collect it, and how we use it. Our "),
//                       TextSpan(
//                         text: "Conditions of Use",
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                       TextSpan(
//                           text:
//                               " govern your access and use of this application."),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Row(
//                   children: [
//                     Checkbox(
//                       activeColor: Colors.black,
//                       value: isAccepted,
//                       onChanged: (value) {
//                         setState(() {
//                           isAccepted = value!;
//                         });
//                       },
//                     ),
//                     Expanded(
//                       child: Container(
//                         child: Text(
//                           "I have read and I accept the Privacy Policy and Conditions of Use",
//                           style: TextStyle(fontSize: 13.5),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: bottomInset > 0 ? 20 : 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: isAccepted
//                         ? () async {
//                             if (_formKey.currentState!.validate()) {
//                               // Save user data to SharedPreferences
//                               await _saveUserData();

//                               // Navigate to the Home Page
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => MyHomePage()));
//                             }
//                           }
//                         : null, // Disable button if not accepted
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           isAccepted ? Color(0xfff071e30) : Colors.grey[400],
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),

//                     child: Text(
//                       "Create Your Account",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
  

  ///////////////////////////Pickupaddresss///////////////////
  // import 'package:flutter/material.dart';

// class PickupAddressPage extends StatefulWidget {
//   final Map<String, String>? existingDetails;

//   PickupAddressPage({this.existingDetails});

//   @override
//   State<PickupAddressPage> createState() => _PickupAddressPageState();
// }

// class _PickupAddressPageState extends State<PickupAddressPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController areaController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController districtController = TextEditingController();
//   String? name, phone, address, area, pincode, city, district;
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.existingDetails != null) {
//       nameController.text = widget.existingDetails!['name'] ?? '';
//       phoneController.text = widget.existingDetails!['phone'] ?? '';
//       addressController.text = widget.existingDetails!['address'] ?? '';
//       areaController.text = widget.existingDetails!['area'] ?? '';
//       pincodeController.text = widget.existingDetails!['pincode'] ?? '';
//       cityController.text = widget.existingDetails!['city'] ?? '';
//       districtController.text = widget.existingDetails!['district'] ?? '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         surfaceTintColor: Colors.white,
//         backgroundColor: Colors.white,
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             )),
//         title: Text("Add Pickup Address"),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formkey,
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Name",
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Container(
//                     child: TextFormField(
//                       onChanged: (String value) {
//                         setState(() {
//                           name = value;
//                         });
//                       },
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return "Please enter your Name";
//                         }
//                         return null;
//                       },
//                       controller: nameController,
//                       cursorColor: Colors.black,
//                       decoration: InputDecoration(
//                           hintText: "Enter Name",
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38))),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Mobile number",
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Container(
//                     child: TextFormField(
//                       onChanged: (value) {
//                         setState(() {
//                           phone = value;
//                         });
//                       },
//                       keyboardType: TextInputType.phone,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter the Mobile Number";
//                         } else if (value.length != 10) {
//                           return 'Please enter a valid 10-digit Mobile Number';
//                         } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//                           return 'Please enter only numeric digits';
//                         }
//                         return null;
//                       },
//                       controller: phoneController,
//                       cursorColor: Colors.black,
//                       decoration: InputDecoration(
//                           hintText: "Enter Mobile number",
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38))),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Address",
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Container(
//                     child: TextFormField(
//                       onChanged: (String value) {
//                         setState(() {
//                           address = value;
//                         });
//                       },
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return "Please enter your Address";
//                         }
//                         return null;
//                       },
//                       controller: addressController,
//                       cursorColor: Colors.black,
//                       maxLines: 1,
//                       decoration: InputDecoration(
//                           hintText: "Enter Address",
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38))),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Area, street,sector",
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Container(
//                     child: TextFormField(
//                       onChanged: (String value) {
//                         setState(() {
//                           area = value;
//                         });
//                       },
//                       validator: (String? value) {
//                         if (value!.isEmpty) {
//                           return "Please enter your Area, Street, Sector";
//                         }
//                         return null;
//                       },
//                       controller: areaController,
//                       cursorColor: Colors.black,
//                       decoration: InputDecoration(
//                           hintText: "Enter area, street, sector",
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38))),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Pincode",
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Container(
//                     child: TextFormField(
//                       onChanged: (String value) {
//                         setState(() {
//                           pincode = value;
//                         });
//                       },
//                       keyboardType: TextInputType.phone,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter the Mobile Number";
//                         } else if (value.length != 6) {
//                           return 'Please enter a valid 6-digit Mobile Number';
//                         } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//                           return 'Please enter only numeric digits';
//                         }
//                         return null;
//                       },
//                       controller: pincodeController,
//                       cursorColor: Colors.black,
//                       decoration: InputDecoration(
//                           hintText: "Enter Pincode",
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(color: Colors.black38))),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 60,
//                 ),
//                 Center(
//                   child: Container(
//                     height: MediaQuery.of(context).size.height / 15,
//                     width: MediaQuery.of(context).size.width / 1.1,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Color(0xfff071e30)),
//                     child: TextButton(
//                         onPressed: () {
//                           if(_formkey.currentState!.validate()){
//                             Navigator.pop(context, {
//                             'name': nameController.text,
//                             'phone': phoneController.text,
//                             'address': addressController.text,
//                             'area': areaController.text,
//                             'pincode': pincodeController.text
//                           });
//                           }

//                         },
//                         child: Text(
//                           "Add Pickup Address",
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         )),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';

// class DistanceCalculation extends StatefulWidget {
//   @override
//   _DistanceCalculationState createState() => _DistanceCalculationState();
// }

// class _DistanceCalculationState extends State<DistanceCalculation> {
//   // Current location coordinates
//   LatLng _currentLatLng = LatLng(0.0, 0.0); // Default value
//   // Target location coordinates (can be hardcoded or obtained dynamically)
//   LatLng _targetLatLng = LatLng(10.0, 76.0); // Example target (change as required)
//   String _distance = '';  // String to store the calculated distance

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   // Fetch the current location
//   Future<void> _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         _currentLatLng = LatLng(position.latitude, position.longitude);
//       });

//       // After fetching the current location, calculate the distance
//       _calculateDistance();
//     } catch (e) {
//       print('Error fetching location: $e');
//     }
//   }

//   // Calculate distance between current location and target location
//   void _calculateDistance() {
//     double distanceInMeters = Geolocator.distanceBetween(
//       _currentLatLng.latitude,
//       _currentLatLng.longitude,
//       _targetLatLng.latitude,
//       _targetLatLng.longitude,
//     );
    
//     // Convert to kilometers and update the state
//     setState(() {
//       _distance = "${(distanceInMeters / 1000).toStringAsFixed(2)} km";  // Convert to kilometers
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Distance Calculation")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Current Location: ${_currentLatLng.latitude}, ${_currentLatLng.longitude}"),
//             SizedBox(height: 16),
//             Text("Target Location: ${_targetLatLng.latitude}, ${_targetLatLng.longitude}"),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _calculateDistance,
//               child: Text("Calculate Distance"),
//             ),
//             SizedBox(height: 16),
//             Text(
//               "Distance: $_distance",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













////////////////////////////////////paymentpage onpress//////////////////////////////


// onPressed: () async {
                //   log("button clicked ----------------------------------------------");
                //   if (selectedPaymentMethod != null &&
                //       selectedPaymentMethod!.isNotEmpty) {
                //     final addressProvider =
                //         Provider.of<AddressProvider>(context, listen: false);
                //     final summaryProvider =
                //         Provider.of<SummaryProvider>(context, listen: false);

                //     // Fetch user-provided data from the provider or state
                //     final pickupAddress =
                //         addressProvider.savedAddresses.isNotEmpty
                //             ? addressProvider.savedAddresses.first
                //             : null;
                //     final deliveryAddress =
                //         addressProvider.deliveryaddress.isNotEmpty
                //             ? addressProvider.deliveryaddress.first
                //             : null;
                //     final packageType = summaryProvider.packageType;
                //     final packageSize = summaryProvider.packageSize;
                //     final packageContents = summaryProvider.packageContents;
                //     final scheduleDate =
                //         summaryProvider.scheduleDate?.toIso8601String();
                //     log("summaryProvider.scheduleDate?.toIso8601String() ----------------------" +
                //         (summaryProvider.scheduleDate?.toIso8601String() ??
                //             'null'));
                //     log("summaryProvider.packageType ----------------------" +
                //         (summaryProvider.packageTypeIds.toString()));
                //     log("summeryProvider.packageSize ----------------------" +
                //         (summaryProvider.packageSizeIds.toString()));
                //     log("summeryProvider.packagecontent ----------------------" +
                //         (summaryProvider.packageContentIds.toString()));
                //     log("addressProvider.savedAddresses.first ----------------------" +
                //         (addressProvider.savedAddresses.first.toString()));
                //     log("addressProvider.deliveryaddress.first ----------------------" +
                //         (addressProvider.deliveryaddress.first.toString()));

                //     // Validation for required fields
                //     // if (pickupAddress == null ||
                //     //     deliveryAddress == null ||
                //     //     packageType == null ||
                //     //     packageSize == null) {
                //     //   ScaffoldMessenger.of(context).showSnackBar(
                //     //     SnackBar(
                //     //         content:
                //     //             Text('Please provide all required details')),
                //     //   );
                //     //   return;
                //     // }

                //     // final vm = Provider.of<CommonViewModel>(context, listen: false);

                //     try {
                //       SharedPreferences prefs =
                //           await SharedPreferences.getInstance();
                //       String? email = prefs.getString('email');

                //       if (email == null || email.isEmpty) {
                //         log('Email not found in SharedPreferences');
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //               content: Text(
                //                   'Email not found. Please log in again.')),
                //         );
                //         return;
                //       }
                //       final Map<String, dynamic> orderse = {
                //         'username': email,
                //         'package_id': summaryProvider.packageTypeIds,
                //         'size_id': summaryProvider.packageSizeIds,
                //         'content_id':
                //             summaryProvider.packageContentIds.join(','),
                //         'pickup_date':
                //             summaryProvider.scheduleDate?.toIso8601String() ??
                //                 '',
                //         'delivery_date':
                //             summaryProvider.scheduleDate?.toIso8601String() ??
                //                 '',
                //         'amount_safety': 50.0,
                //         'is_safe': 1,
                //         'delivery_status': 0,
                //         // 'deliverytype_id': 1,
                //         // 'delivery_id':
                //         //     addressProvider.deliveryaddress.first['address'] ??
                //         //         '',
                //         // 'pickup_id':
                //         //     addressProvider.savedAddresses.first['address'] ??
                //         //         '',
                //         'payment': 1,
                //       };
                //       log("ordersssss ====== " + orderse.toString());
                //       final vm =
                //           Provider.of<CommonViewModel>(context, listen: false);
                //       await vm
                //           .ordersss(
                //             orderse['username'],
                //             orderse['package_id'],
                //             orderse['size_id'],
                //             orderse['content_id'].toString(),
                //             "20000",
                //             // orderse['price'].toString(),
                //             orderse['pickup_date'].toString(),
                //             orderse['delivery_date'].toString(),
                //             orderse['amount_safety'].toString(),
                //             orderse['is_safe'].toString(),
                //             orderse['delivery_status'],
                //             // orderse['deliverytype_id'].toString(),
                //             orderse['payment'],
                //             // orderse['delivery_id'],

                //             // orderse['pickup_id'],
                //           )
                //           .then((value) => (value) {
                //                 if (vm.responsee!.status != null &&
                //                     vm.responsee!.status == 'success') {
                //                   ScaffoldMessenger.of(context).showSnackBar(
                //                     SnackBar(
                //                         content:
                //                             Text(vm.responsee!.msg.toString())),

                //                   );
                //                   Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                       builder: (context) => MyHomePage(),
                //                     ),
                //                   );
                //                 } else {
                //                   ScaffoldMessenger.of(context).showSnackBar(
                //                     SnackBar(
                //                         content: Text(
                //                             'Error: ${vm.responsee!.msg ?? 'Unknown error'}')),
                //                   );
                //                 }
                //               });
                //     } catch (e) {
                //       log('Error placing order in payment screen : $e');
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('An error occurred: $e')),
                //       );
                //     }
                //   }
                // },




       /////////////////////////////summerypage//////////////////////////////////////////////////         
       
       // import 'package:courier/Screen/deliveryaddress.dart';
// import 'package:courier/Screen/package.dart';
// import 'package:courier/Screen/pickupaddress.dart';
// import 'package:courier/Screen/schedule.dart';
// import 'package:courier/Screen/schedule2.dart';
// import 'package:flutter/material.dart';

// class SummaryPage extends StatefulWidget {
//   @override
//   State<SummaryPage> createState() => _SummaryPageState();
// }

// class _SummaryPageState extends State<SummaryPage> {
//   int currentStep = 3;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 1,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Send a Package",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: false,
//       ),
//       body: Column(
//         children: [
//           // Progress Bar
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 _buildProgressStep("ADDRESS", isActive: currentStep >= 0, isProcessed: currentStep > 0),
//                 _buildProgressDivider(),
//                 _buildProgressStep("PACKAGE", isActive: currentStep >= 1, isProcessed: currentStep > 1),
//                 _buildProgressDivider(),
//                 _buildProgressStep("SCHEDULE", isActive: currentStep >= 2, isProcessed: currentStep > 2),
//                 _buildProgressDivider(),
//                 _buildProgressStep("SUMMARY", isActive: currentStep == 3),
//               ],
//             ),
//           ),
//           // TabBar and TabBarView
//           Expanded(
//             child: DefaultTabController(
//               length: 3,
//               child: Column(
//                 children: [
//                   // TabBar for navigation
//                   TabBar(
//                     tabs: [
//                       Tab(text: "Address Details"),
//                       Tab(text: "Package Details"),
//                       Tab(text: "Schedule Details"),
//                     ],
//                     indicatorColor: Color(0xfff071e30),
//                   ),
//                   // TabBarView for the actual content of each tab
//                   Expanded(
//                     child: TabBarView(
//                       children: [
//                         _buildAddressDetails(),
//                         _buildPackageDetails(),
//                         _buildScheduleDetails(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xfff071e30),
//             minimumSize: Size(double.infinity, 50),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//           onPressed: () {
//             // Proceed to Payment Logic
//           },
//           child: Text(
//             "Proceed to Pay",
//             style: TextStyle(color: Colors.white, fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressStep(String title, {bool isActive = false, bool isProcessed = false}) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 15,
//           backgroundColor: isActive ? Color(0xfff071e30) : Colors.grey[300],
//           child: isProcessed
//               ? Icon(Icons.check, size: 15, color: Colors.white)
//               : isActive
//               ? Icon(Icons.circle, size: 10, color: Colors.white)
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

//   Widget _buildAddressDetails() {
//     return Card(
//       color: Colors.white,
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         children: [
//           // Pickup address
//           ListTile(
//             leading: Icon(Icons.home, color: Colors.green),
//             title: Text("Home (Pickup)"),
//             subtitle: Text("Kerala - 676101"),
//             trailing: TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => PickupAddressPage()));
//               },
//               child: Text("Update"),
//             ),
//           ),
//           // Delivery address
//           ListTile(
//             leading: Icon(Icons.local_shipping, color: Colors.blue),
//             title: Text("Delivery Address"),
//             subtitle: Text("Mumbai - 400001"),
//             trailing: TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryAddressPage()));
//               },
//               child: Text("Update"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPackageDetails() {
//     return Card(
//       color: Colors.white,
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         leading: Icon(Icons.inventory, color: Colors.blue),
//         title: Text("Clothes & Personal Items"),
//         subtitle: Text("Size: Small\nValue: ₹200"),
//         trailing: TextButton(
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => PackagePage()));
//           },
//           child: Text("Update"),
//         ),
//       ),
//     );
//   }

//   Widget _buildScheduleDetails() {
//     return Card(
//       color: Colors.white,
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         leading: Icon(Icons.calendar_today, color: Colors.orange),
//         title: Text("Date: 05 Dec"),
//         subtitle: Text("Time Slot: 07:00 AM - 7:00 PM"),
//         trailing: TextButton(
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => SchedulePage()));
//           },
//           child: Text("Update"),
//         ),
//       ),
//     );
//   }
// }


//////////////////////////////////////////////////////////delivery addressss////////////////////////////

// import 'package:courier/Drawer/settings/savedaddress.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DeliveryAddressPage extends StatefulWidget {
//   final Map<String, String>? existingDetails;

//   DeliveryAddressPage({this.existingDetails});

//   @override
//   State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
// }

// class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController areaController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController districtController = TextEditingController();
  
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.existingDetails != null) {
//       nameController.text = widget.existingDetails!['name'] ?? '';
//       phoneController.text = widget.existingDetails!['phone'] ?? '';
//       addressController.text = widget.existingDetails!['address'] ?? '';
//       areaController.text = widget.existingDetails!['area'] ?? '';
//       pincodeController.text = widget.existingDetails!['pincode'] ?? '';
//       cityController.text = widget.existingDetails!['city'] ?? '';
//       districtController.text = widget.existingDetails!['district'] ?? '';
//     }
//     _loadSavedAddress();
//   }

//   // Load saved address details from SharedPreferences
//   Future<void> _loadSavedAddress() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       nameController.text = prefs.getString('name') ?? '';
//       phoneController.text = prefs.getString('phone') ?? '';
//       addressController.text = prefs.getString('address') ?? '';
//       areaController.text = prefs.getString('area') ?? '';
//       pincodeController.text = prefs.getString('pincode') ?? '';
//       cityController.text = prefs.getString('city') ?? '';
//       districtController.text = prefs.getString('district') ?? '';
//     });
//   }

//   // Save address to SharedPreferences
//   Future<void> _saveAddressToPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('name', nameController.text);
//     prefs.setString('phone', phoneController.text);
//     prefs.setString('address', addressController.text);
//     prefs.setString('area', areaController.text);
//     prefs.setString('pincode', pincodeController.text);
//     prefs.setString('city', cityController.text);
//     prefs.setString('district', districtController.text);
//   }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         surfaceTintColor: Colors.white,
//         backgroundColor: Colors.white,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         title: Text("Add Delivery Address"),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formkey,
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Name field
//                 _buildTextField("Name", nameController),
//                 // Mobile number field
//                 _buildTextField("Mobile number", phoneController, keyboardType: TextInputType.phone, maxLength: 10),
//                 // Address field
//                 _buildTextField("Address", addressController),
//                 // Area field
//                 _buildTextField("Area, street, sector", areaController),
//                 // Pincode field
//                 _buildTextField("Pincode", pincodeController, keyboardType: TextInputType.phone, maxLength: 6),
//                 // City field
//                 _buildTextField("City", cityController),
//                 // District field
//                 _buildTextField("District", districtController),
//                 SizedBox(height: 60),
//                 _buildSaveButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Common method to build text fields
//   Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text, int? maxLength}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(fontSize: 17)),
//         Padding(
//           padding: const EdgeInsets.all(5),
//           child: TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             maxLength: maxLength,
//             onChanged: (value) {
//               setState(() {
//                 // No need for setState here as we already handle text editing through controller
//               });
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return "Please enter your $label";
//               }
//               return null;
//             },
//             cursorColor: Colors.black,
//             decoration: InputDecoration(
//               hintText: "Enter $label",
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Colors.black38),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Colors.black38),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Save button to submit the form
//   Widget _buildSaveButton() {
//     return Center(
//       child: Container(
//         height: MediaQuery.of(context).size.height / 15,
//         width: MediaQuery.of(context).size.width / 1.1,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: Color(0xfff071e30),
//         ),
//         child: TextButton(
//           onPressed: () {
//   if (_formkey.currentState!.validate()) {
//     _saveAddressToPrefs();

//     // Navigate to the Saved Address page after saving the address
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SavedAddressPage(),
//       ),
//     );
//   }
// },

//           child: Text(
//             "Add Delivery Address",
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }

//   // Save address details to SharedPreferences
//   Future<void> _saveAddressToPrefss() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('name', nameController.text);
//   await prefs.setString('phone', phoneController.text);
//   await prefs.setString('address', addressController.text);
//   await prefs.setString('area', areaController.text);
//   await prefs.setString('pincode', pincodeController.text);
//   await prefs.setString('city', cityController.text);
//   await prefs.setString('district', districtController.text);

//   print("Address saved to prefs: ${nameController.text}, ${phoneController.text}"); // Debug print
// }

// }


///////////////////////////////////////////feedback with emoji////////////////////////////////////

// import 'package:courier/homescreen/homescreen.dart';
// import 'package:flutter/material.dart';

// class FeedBackPage extends StatefulWidget {
//   const FeedBackPage({super.key});

//   @override
//   State<FeedBackPage> createState() => _FeedBackPageState();
// }

// class _FeedBackPageState extends State<FeedBackPage> {
//   int? selectedEmojiIndex;
//   final TextEditingController feedbackController = TextEditingController();

//   final List<IconData> icons = [
//     Icons.sentiment_very_dissatisfied,
//     Icons.sentiment_dissatisfied,
//     Icons.sentiment_neutral,
//     Icons.sentiment_satisfied,
//     Icons.sentiment_very_satisfied,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//         appBar: AppBar(
//                backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         elevation: 0,
//              leading: IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: Icon(Icons.arrow_back_ios,
//         color: Colors.black,))
//         ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "How was your experience?",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(icons.length, (index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedEmojiIndex = index;
//                     });
//                   },
//                   child: Column(
//                     children: [
//                       Icon(
//                         icons[index],
//                         size: 36,
//                         color: selectedEmojiIndex == index
//                             ? Color(0xfff071e30)
//                             : Colors.black54,
//                       ),
//                       if (selectedEmojiIndex == index)
//                         const Icon(Icons.check,
//                             color: Color(0xfff071e30), size: 16),
//                     ],
//                   ),
//                 );
//               }),
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: feedbackController,
//               cursorColor: Colors.black,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey)
//                     ),
//                 labelText: "Additional Feedback",
//                 labelStyle: TextStyle(color: Colors.grey)
//               ),
//               maxLines: 4,
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
//                     final feedback = feedbackController.text;
//                     final selectedIcon = selectedEmojiIndex != null
//                         ? icons[selectedEmojiIndex!]
//                         : null;

//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return Dialog(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.check_circle_outline,
//                                   color: Colors.green,
//                                   size: 60,
//                                 ),
//                                 const SizedBox(height: 16),
//                                 const Text(
//                                   "Thank You!",
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Text(
//                                   selectedIcon != null
//                                       ? "You selected feedback option ${selectedEmojiIndex! + 1}.\nFeedback: $feedback"
//                                       : "Please select an option and provide feedback.",
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                       fontSize: 16, color: Colors.black54),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.blueGrey[700],
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                   ),
//                                   onPressed: () => Navigator.push(
//                                     context, MaterialPageRoute(builder: (context)=> MyHomePage())),
//                                   child: const Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 24.0, vertical: 12.0),
//                                     child: Text(
//                                       "Close",
//                                       style: TextStyle(fontSize: 16, color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: const Text(
//                     "Submit",
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
// }


////////////////////////////////////////////////Entertrack/////////////////////////////////////////////
// import 'package:courier/Screen/orderstatus.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Entertrack extends StatefulWidget {
//   const Entertrack({super.key});

//   @override
//   State<Entertrack> createState() => _EntertrackState();
// }

// class _EntertrackState extends State<Entertrack> {
//   TextEditingController trackingController = TextEditingController();

//    @override
//   void initState() {
//     super.initState();
//     trackingController = TextEditingController(); // Initialize the controller
//   }

//    @override
//   void dispose() {
//     trackingController.dispose(); // Dispose of the controller to free resources
//     super.dispose();
//   }

//   Future<void> _saveTrackingID(BuildContext context, String trackingID) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('trackingID', trackingID);

//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => TrackOrder()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//      return Container(
//       decoration: BoxDecoration(
//         color: Color(0xfff031f34),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 25.0, left: 8.0, right: 8.0),
//             child: Text(
//               "Track your Shipment",
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(left: 10, right: 10),
//             child: Text(
//               "Please enter your Order ID",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Container(
//               height: 45,
//               padding: EdgeInsets.only(left: 10, right: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: Color.fromARGB(255, 226, 223, 223),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black,
//                     spreadRadius: 2,
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: trackingController,
//                 decoration: InputDecoration(
//                   hintText: "Enter Order ID",
//                   border: InputBorder.none,
//                   prefixIcon: Icon(Icons.search),
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.send,),
//                     onPressed: () {
//                       String trackingID = trackingController.text.trim();
//                       if (trackingID.isNotEmpty) {
//                         _saveTrackingID(context, trackingID);
//                       } else {
//                         print("Order ID is empty");
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 250,
//             child: Stack(
//               children: [
//                 Positioned(
//                   left: 5,
//                   right: 5,
//                   top: 20,
//                   bottom: 10,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xff071e30),
//                       borderRadius: BorderRadius.circular(20),
//                       // gradient: LinearGradient(
//                       //   colors: [
//                       //     const Color(0xff071e30), // Start color
//                       //     const Color(0xff071e30).withOpacity(0.6), // End color with some transparency
//                       //   ],
//                       //   begin: Alignment.topCenter,
//                       //   end: Alignment.bottomCenter,
//                       // ),
//                     ),
//                     child: Image.asset(
//                       'assets/images/trackkk.png',
//                       height: 250,
//                       width: 300,
//                     ),
//                   ),
//                 ),
//                 // Positioned(
//                 //   left: 0,
//                 //   child: Image.asset(
//                 //     'assets/images/1stpic.png',
//                 //     height: 450,
//                 //     fit: BoxFit.contain,
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


/////////////////////////////////////////////////////////Tabbar///////////////////////////////////////

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Tabbar extends StatelessWidget {
//   const Tabbar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Color.fromARGB(255, 245, 239, 239),
//             borderRadius: BorderRadius.circular(10)),
//         child: Column(
//           children: [
//             TabBar(
//               indicatorColor: Color(0xfff071e30),
//               indicatorSize: TabBarIndicatorSize.label,
//               labelColor: Colors.black,
//               tabs: [
//                 Tab(
//                   text: "From me",
//                 ),
//                 Tab(
//                   text: "To me",
//                 ),
//               ],
//             ),
//             Container(
//               height: 150,
//               child: TabBarView(
//                 children: [
//                   Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min, // Reduce extra space
//                       children: [
//                         Image(
//                           image: AssetImage(
//                               "assets/images/Untitled_design-removebg-preview.png"),
//                           height: 100,
//                           width: 200, // Optional: Adjust the size of the image
//                           fit: BoxFit.contain,
//                         ),
//                         Text(
//                           "You haven't sent any package yet!!!",
//                           textAlign: TextAlign.center, // Center the text
//                         ),
//                       ],
//                     ),
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min, // Reduce extra space
//                       children: [
//                         Image(
//                           image: AssetImage(
//                               "assets/images/Untitled_design-removebg-preview.png"),
//                           height: 100,
//                           fit: BoxFit.contain,
//                         ),
//                         Text(
//                           "There are no active orders right now!!!",
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }