
import 'dart:convert';
import 'dart:developer';
import 'package:courier/MODEL/calendermodel.dart';
import 'package:courier/MODEL/distancemodel.dart';
import 'package:courier/MODEL/feedbackmodel.dart';
import 'package:courier/MODEL/getordermodel.dart';
import 'package:courier/MODEL/ordermodel.dart';
import 'package:courier/MODEL/packagecontentmodel.dart';
import 'package:courier/MODEL/packagesizemodel.dart';
import 'package:courier/MODEL/pakagemodel.dart';
import 'package:courier/MODEL/trackingmodel.dart';
import 'package:courier/Provider/priceprovider.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../MODEL/adddeliveryaddressmodel.dart';
import '../MODEL/registermodel.dart';
import '../Model/addpickupaddressmodel.dart';


class ApiService {
  final String _baseUrl = 'https://courierservice.cyralearnings.com/';

/////////////pickup/////////////////////////////

Future<PickupaddressModel?> addPickupAddress(
  String name,
  String phone,
   String address,
   String area,
   String pincode,
) async {
  log('Inside Insert and Update Subject function');

  // Prepare data to send in the POST request
  final Map<String, dynamic> data = {
    'orderid': 1,
    'name': name,
    'username': 1,
    'mobile_no': phone,
    'address': address,
    'area': area,
    'pincode': pincode,
    
    
    
  };
  log("addpickup map data == $data");

  try {
    // Sending POST request using http
    final response = await http.post(
      Uri.parse('${_baseUrl}addpickup.php'),
      headers: {'Content-Type': 'application/json'}, // Set JSON content type
      body: jsonEncode(data), // Encode data to JSON format
    );

    // Log response
    log('addpickup response.statusCode : ${response.statusCode}');
    if (response.statusCode == 200) {
      // Parse the response into UpdateInsertSubjectModel
      final responseData = jsonDecode(response.body);
      log("responsebody==="+response.body.toString());

      // Check if the response contains the required fields
      if (responseData['message'] != null ) {
        return PickupaddressModel.fromJson(responseData);
      } else {
        throw Exception('Invalid response format: $responseData');
      }
    } else {
      throw Exception(
          'Failed to update category status: ${response.reasonPhrase}');
    }
  } catch (e) {
    log('Error in addpickup.php: $e');
    return null; // Return null in case of an error
  }
}
////////////////////////////////////////////////////////////////////

//////////////delivery/////////////////////


Future<DeliveryaddressModel?> addDeliveryAddress(
  String name,
  String phone,
   String address,
   String area,
   String pincode,
) async {
  log('Inside delivery function');

  // Prepare data to send in the POST request
  final Map<String, dynamic> data = {
    'orderid': 1,
    'name': name,
    'username': 1,
    'mobile_no': phone,
    'address': address,
    'area': area,
    'pincode': pincode,
    
    
    
  };
  log("delivery map data == $data");

  try {
    // Sending POST request using http
    final response = await http.post(
      Uri.parse('${_baseUrl}adddelivery.php'),
      headers: {'Content-Type': 'application/json'}, // Set JSON content type
      body: jsonEncode(data), // Encode data to JSON format
    );

    // Log response
    log('delivery response.statusCode : ${response.statusCode}');
    if (response.statusCode == 200) {
      // Parse the response into UpdateInsertSubjectModel
      final responseData = jsonDecode(response.body);
      log("responsebody==="+response.body.toString());

      // Check if the response contains the required fields
      if (responseData['message'] != null ) {
        return DeliveryaddressModel.fromJson(responseData);
      } else {
        throw Exception('Invalid response format: $responseData');
      }
    } else {
      throw Exception(
          'Failed to update category status: ${response.reasonPhrase}');
    }
  } catch (e) {
    log('Error in adddelivery.php: $e');
    return null; // Return null in case of an error
  }
}

////////////////////////////////////////////////////////////////////

//////////////register/////////////////////

Future<ResponseModel?> registration(
 
  String first_name,
 String last_name,
  String email,) 
  async {
     log('inside function');
  Map<String, dynamic> data = {
    
    'first_name' : first_name,
    'last_name' : last_name,
    'email' : email,
   
  };
  log('Register data ==' +data.toString());

  try{
    final response = await http.post(
     Uri.parse('${_baseUrl}register.php'),
       headers: {'Content-Type': 'application/json'}, 
   // "http://bootcamp.cyralearnings.com/ecom.registration.php",
    body:  jsonEncode(data),
  );
  
  log("statuscode==="+response.statusCode.toString());
  if(response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    log("user === ${response.body}");
    // print(response.body);  // Log the raw response body

     if (responseData['msg'] != null ) {
        return ResponseModel.fromJson(responseData);
      } else {
        throw Exception('Invalid response format: $responseData');
      }
    } 
    else {
      throw Exception('Failed to load Registration:${response.reasonPhrase}');
    }
  } catch (e) {
    log('Error: $e');
    // throw Exception('An unexpected error occurred: $e');
    return null;
  }
}


////////////////////////////////////////////////////////////////////

//////////////Package//////////////////////////////////////

Future<List<GetpackagedetailModel>> fetchProducts() async {
  try {
    final response = await http.get(
      Uri.parse('${_baseUrl}get_packagedetails.php'),
    );

    if (response.statusCode == 200) {
      // Log status for debugging
      print(response.statusCode.toString());
      
      List<GetpackagedetailModel> package = [];
      
      // Assuming the response is in a JSON format
      List<dynamic> responseData = jsonDecode(response.body);
      
      for (var productData in responseData) {
        package.add(GetpackagedetailModel.fromJson(productData));
      }
      
      return package;
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print("Error fetching products: $e");
    return [];
  }
}

////////////////////////////////////////////////////////////////////////

//////////////////////PackageSize//////////////////////////////////////////

Future<List<GetpackagesizeModel>> fetchPackageSizes() async {
  try {
    final response = await http.get(
       Uri.parse('${_baseUrl}get_packagesize.php'), // Make sure this is correct
    );

    print("Response Status Code: ${response.statusCode}"); // Log the status code

    if (response.statusCode == 200) {
      print("Response Body: ${response.body}");  // Log the full response body

      // Try to decode the response body into a list
      List<dynamic> responseData = jsonDecode(response.body);
      print("Decoded Response: $responseData");  // Log the decoded response

      // If data is empty, log this
      if (responseData.isEmpty) {
        print("No package sizes found.");
        return [];
      }

      // Map the response data to your model
      List<GetpackagesizeModel> packageSizes = responseData.map((item) {
        return GetpackagesizeModel.fromJson(item);
      }).toList();

      print("Package Sizes: $packageSizes");  // Log the final mapped list

      return packageSizes;
    } else {
      print("Failed to load package sizes, Status Code: ${response.statusCode}");
      throw Exception('Failed to load package sizes');
    }
  } catch (e) {
    print("Error fetching package sizes: $e");
    return [];
  }
}

////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////PackageContent/////////////////////////////////////////////

Future<List<Contentmodel>> fetchPackageContents() async {
    try {
      final response = await http.get(Uri.parse('${_baseUrl}get_packagecontent.php')); // Adjust path accordingly

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);

        // Check for an empty response
        if (responseData.isEmpty) {
          return [];
        }

        // Parse the response into a list of models
        return responseData.map((data) => Contentmodel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load package contents');
      }
    } catch (e) {
      print("Error fetching package contents: $e");
      return [];
    }
  }

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////Calender/////////////////////////////////////
  
   Future<List<Calendermodel>> fetchcalender() async {
  try {
    final response = await http.get(
      Uri.parse('${_baseUrl}get_calender.php'),
    );

    if (response.statusCode == 200) {
      // Log status for debugging
      print(response.statusCode.toString());
      
      List<Calendermodel> calender = [];
      
      // Assuming the response is in a JSON format
      List<dynamic> responseData = jsonDecode(response.body);
      
      for (var productData in responseData) {
        calender.add(Calendermodel.fromJson(productData));
      }
      
      return calender;
    } else {
      throw Exception('Failed to load calender');
    }
  } catch (e) {
    print("Error fetching calender: $e");
    return [];
  }
}



Future<Map<String, dynamic>> fetchAddressDetails(int orderId) async {
    final response = await http.get(Uri.parse("$_baseUrl?orderid=$orderId"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data["status"] == "success") {
        return {
          "pickup_address": data["pickup_address"],
          "delivery_address": data["delivery_address"],
        };
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

////////////////////////////////////////////////////////////
//////////////////////////insertorder///////////////////////


Future<Ordermodel?> orders(
 
  String username,
  int package_id,
  int size_id,
  String content_id,
  String price,
  String pickup_date,
  String delivery_date,
  String amount_safety,
  String is_safe,
  int delivery_status,
  int payment,
  String pickup_name,
  String pickup_mobile_no,
  String pickup_address,
  String pickup_area,
  String pickup_pincode,
  String delivery_name,
  String delivery_mobile_no,
  String delivery_address,
  String delivery_area,
  String delivery_pincode
  ) 
  async {
     log('inside function');
  Map<String, dynamic> data = {
    
  //  'orderid' : orderid,
    'username' : username,
    'package_id' : package_id,
    'size_id' : size_id,
    'content_id' : content_id,
    'price' : price,
    'pickup_date' : pickup_date,
    'delivery_date' : delivery_date,
    'amount_safety' : amount_safety,
    'is_safe' : is_safe,
    'delivery_status' : delivery_status,
    'pickup_name' :pickup_name,
    'pickup_mobile_no' : pickup_mobile_no,
    'pickup_address' : pickup_address,
    'pickup_area' : pickup_area,
    'pickup_pincode' : pickup_pincode,
     'delivery_name' :delivery_name,
    'delivery_mobile_no' : delivery_mobile_no,
    'delivery_address' : delivery_address,
    'delivery_area' : delivery_area,
    'delivery_pincode' : delivery_pincode,


    // 'deliverytype_id' : deliverytype_id,
    // 'delivery_id' : delivery_id,
    // 'pickup_id' : pickup_id,
    'payment' : payment,

    
   
  };
    log('order data ==' +data.toString());

  try{
    final response = await http.post(
     Uri.parse('${_baseUrl}insertorder.php'),
       headers: {'Content-Type': 'application/json'}, 
    body:  jsonEncode(data),
  );
  
  log("statuscode==="+response.statusCode.toString());
  if(response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    log("user === ${response.body}");
    // print(response.body);  // Log the raw response body

     if (responseData['msg'] != null ) {
        return Ordermodel.fromJson(responseData);
      } else {
        throw Exception('Invalid response format: $responseData');
      }
    } 
    else {
      throw Exception('Failed to load order:${response.reasonPhrase}');
    }
  } catch (e) {
    log('Error: $e');
    // throw Exception('An unexpected error occurred: $e');
    return null;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////getorder////////////////////////////////////////////////

Future<List<GetorderModel>> fetchNewOrders() async {
  try {
    // Retrieve the username from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('email'); // Assuming 'email' is used to store the username

    if (username == null || username.isEmpty) {
      throw Exception('Username not found in SharedPreferences');
    }

    final response = await http.post(
      Uri.parse("${_baseUrl}get_order_details.php"),
      body: {'username': username}, // Use the retrieved username
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("user = ${response.body}");
      List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((data) => GetorderModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  } catch (e) {
    log('Error during API call: $e');
    throw e; // Propagate error
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////Feedback//////////////////////////////////////////////////////

Future<FeedbackModel?> submitfeedbacks(String username, String comments) async {
  final url = "${_baseUrl}feedback.php";
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "comments": comments}),
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        // Handle success
      } else {
        throw Exception(jsonResponse['msg']);
      }
    } else {
      throw Exception("Failed to submit feedback: ${response.statusCode}");
    }
  } catch (error) {
    rethrow;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////Tracking///////////////////////////////////////////////////

Future<TrackingModel> fetchTrackingData(int orderId) async {
  try {
    final response = await http.post(
      Uri.parse("${_baseUrl}get_tracking.php"),
      body: {'order_id': orderId.toString()},
    );

    log("Response status code: ${response.statusCode}");
    log("Response body: ${response.body}"); // Log the raw response

    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = jsonDecode(response.body);
      } catch (e) {
        log('Error parsing response body as JSON: $e');
        throw Exception('Failed to parse response body');
      }

      // Check for error message in response
      if (jsonResponse.containsKey('error')) {
        throw Exception(jsonResponse['error']);
      }

      return TrackingModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to fetch tracking data');
    }
  } catch (e) {
    log('Error during API call: $e');
    throw e;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////distancePrice////////////////////////////////////////////////


Future<DistanceModel?> fetchPrice(double km) async {
    final Uri url = Uri.parse('${_baseUrl}get_distanceprice.php?Km=$km');

    try {
      final response = await http.get(url);

      // Log the response body to debug
      log("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Log the parsed JSON response
        log("Parsed Response Data: $responseData");

        // If price is available, return a DistanceModel
        if (responseData.containsKey('price')) {
          return DistanceModel.fromJson(responseData); // Return parsed data
        } else {
          throw Exception('No price found in response');
        }
      } else {
        throw Exception('Failed to load price: ${response.statusCode}');
      }
    } catch (e) {
      log("Error in fetching price: $e");
      throw Exception('Error fetching price: $e');
    }
  }



}


























