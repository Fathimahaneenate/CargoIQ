import 'dart:convert';
import 'dart:developer';

import 'package:courier/MODEL/distancemodel.dart';
import 'package:courier/MODEL/getordermodel.dart';
import 'package:courier/MODEL/trackingmodel.dart';
import 'package:courier/VIEWMODEL/calenderviewmodel.dart';
import 'package:courier/VIEWMODEL/feedbackviewmodel.dart';
import 'package:courier/VIEWMODEL/getorderviewmodel.dart';
import 'package:courier/VIEWMODEL/orderviewmodel.dart';
import 'package:courier/VIEWMODEL/packagecontentviewmodel.dart';
import 'package:courier/VIEWMODEL/packagesizeviewmodel.dart';
import 'package:courier/VIEWMODEL/packageviewmodel.dart';
import 'package:flutter/material.dart';


import '../VIEWMODEL/adddeliveryviewmodel.dart';
import '../VIEWMODEL/addpickupviewmodel.dart';
import '../VIEWMODEL/registerviewmodel.dart';
import '../webservice/webservice.dart';



class CommonViewModel extends ChangeNotifier {
 ResponseViewmodel? response;
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  List<GetorderModel> getorderlist=[];
   double? _totalPrice;
 

  

  //===================================================================================
///////addpickup////////

bool _addpickupaddressLoading = false;

  bool get addpickupaddressLoading => _addpickupaddressLoading;

  PickupaddressViewModel? addpickup;
  Future<void> addpickupaddress(
    String name,
     String phone,
   String address,
   String area,
   String pincode,
  ) async {
    _addpickupaddressLoading = true;
    notifyListeners();

    try {
      final result = await ApiService().addPickupAddress(
          name,phone,address,area,pincode);
      if (result != null) {
        addpickup =
            PickupaddressViewModel(addPickupAddressdata: result);
       
      }
    } catch (e) {
      log("Error updating review: $e");
    } finally {
      _addpickupaddressLoading = false;
      notifyListeners(); // Notify that the update is complete
    }
  }
////////////////////////////////////////////////////////

////adddeliveryaddresss////


bool _adddeliveryaddressLoading = false;

  bool get adddeliveryaddressLoading => _adddeliveryaddressLoading;

  DeliveryaddressViewModel? adddelivery;
  Future<void> adddeliveryaddress(
    String name,
     String phone,
   String address,
   String area,
   String pincode,
  ) async {
    _adddeliveryaddressLoading = true;
    notifyListeners();

    try {
      final result = await ApiService().addDeliveryAddress(
          name,phone,address,area,pincode);
      if (result != null) {
        adddelivery =
            DeliveryaddressViewModel(addDeliveryAddressdata: result);
        // if (type == 'insert' || type == 'update') {
        //   log("courseId_batchId====$courseId   $batchId");
        //   await getCategory(courseId!,
        //       batchId!); // You might want to pass the batchId or relevant parameter to update the list
        // }
      }
    } catch (e) {
      log("Error updating review: $e");
    } finally {
      _adddeliveryaddressLoading = false;
      notifyListeners(); // Notify that the update is complete
    }
  }
/////////////////////////////////////////////////////////

////register////////////
bool _registerload = false;
  bool get registerload => _registerload;

 
  Future<bool> registration(String firstName, String lastName, String email) async {
  try {
    _registerload = true;
    notifyListeners(); // Notify UI that loading has started

    final results = await ApiService().registration(firstName, lastName, email);

    if (results == null) {
      throw Exception('Registration failed: No data returned');
    }

    response = ResponseViewmodel(data: results);
    log('Registration response === ${response!.msg}');

    _registerload = false;
    notifyListeners(); // Notify UI that loading has stopped

    return true; // Registration successful
  } catch (e) {
    log('Registration error: $e');

    _registerload = false;
    notifyListeners(); // Notify UI that loading has stopped

    return false; // Registration failed
  }
}

  //////////////////////////////////////////////////////////////////////////////////////////////////////
  
    /////////////////////////////Package//////////////////////////
    

    List<PackageViewModel> packagelist = [];
      bool _productload = false;
      bool get productload => _productload;

  Future<List<PackageViewModel>> getpackage() async {
    _productload = true;
    final results = await ApiService().fetchProducts();
    packagelist = results.map((item) => PackageViewModel(data: item)).toList();
    log('productslist == $packagelist');
    _productload = false;
    notifyListeners();
    return packagelist;
  }

  
  ////////////////////////////packageSize//////////////////////////////////////////////////////

List<PackageSizeViewModel> packageSizeList = [];
bool _isLoading = false;

bool get isLoading => _isLoading;

Future<List<PackageSizeViewModel>> getPackageSizes() async {
  _isLoading = true;
  notifyListeners();

  final results = await ApiService().fetchPackageSizes();  // Call the fetch method
  if (results.isEmpty) {
    print("No package sizes found.");
    _isLoading = false;
    notifyListeners();
    return [];
  }

  packageSizeList = results.map((item) {
    return PackageSizeViewModel(data: item);
  }).toList();

  log('PackageSizeList == $packageSizeList');
  _isLoading = false;
  notifyListeners();

  return packageSizeList;
}

//////////////////////////////////PackageContent////////////////////////////////////////////


List<ContentViewModel> packagecontent = [];
  bool _contentLoading = false;

  bool get contentLoading => _isLoading;

  Future<List<ContentViewModel>> getPackageContent() async {
    _isLoading = true;
    notifyListeners();  // Notify listeners to show loading state

    try {
      final results = await ApiService().fetchPackageContents();  // Fetch package contents from API

      if (results.isEmpty) {
        print("No package sizes found.");
        _isLoading = false;
        notifyListeners();  // Notify listeners to hide loading state
        return [];
      }

      // Map fetched data to ContentViewModel
      packagecontent = results.map((item) {
        return ContentViewModel(data: item);  // Assuming `item` is a model that matches `ContentViewModel`
      }).toList();

      log('PackageContent == $packagecontent');  // Log the package content for debugging

    } catch (e) {
      print("Error fetching package contents: $e");
      packagecontent = [];  // Reset to empty list in case of error
    }

    _isLoading = false;  // Set loading to false after processing
    notifyListeners();  // Notify listeners after fetching is complete

    return packagecontent;  // Return the mapped list
  }

   /////////////////////////////////////////////////////////////////////////////
   ////////////////////////////Calender///////////////////////////////////
   
DateTime _orderDate = DateTime.now(); // Example initialization

  DateTime get orderDate => _orderDate;

  void setOrderDate(DateTime date) {
    _orderDate = date;
    notifyListeners();
  }


    List<CalendarViewModel> calenderlist = [];
bool _calenderload = false;
bool get calenderload => _calenderload;

  Future<List<CalendarViewModel>> getdates() async {
    _calenderload = true;
    final results = await ApiService().fetchcalender();
    calenderlist = results.map((item) => CalendarViewModel(data: item)).toList();
    log('calenderlist == $calenderlist');
    _calenderload = false;
    notifyListeners();
    return calenderlist;
  }



///////////////////////////////////////////////order///////////////////////////////////////



bool _orderLoad = false;
bool get orderLoad => _orderLoad;

OrderViewmodel? responsee;

Future<OrderViewmodel?> ordersss(
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
) async {
  log("inside commonviewmodel in ordersss===================================");

  try {
    _orderLoad = true;
    notifyListeners(); // Notify listeners when loading starts.

    // Call the API service and pass the additional parameters
    final results = await ApiService().orders(
      username,
      package_id,
      size_id,
      content_id,
      price,
      pickup_date,
      delivery_date,
      amount_safety,
      is_safe,
      delivery_status,
      payment,
      pickup_name,
      pickup_mobile_no,
      pickup_address,
      pickup_area,
      pickup_pincode,
      delivery_name,
      delivery_mobile_no,
      delivery_address,
      delivery_area,
      delivery_pincode,
    );

    if (results == null) {
      throw Exception('Order placement failed: No data returned');
    }

    responsee = OrderViewmodel(data: results); // Assuming your response has `data` and `msg`.
    log('Order response === ${responsee!.msg}');
    notifyListeners(); // Notify listeners when order data is updated.

    _orderLoad = false; // Set loading to false after receiving data.
    return responsee;
  } catch (e) {
    log('Error: $e');
    _orderLoad = false; // Handle error and stop loading.
    notifyListeners(); // Notify listeners that loading has ended.
    return null; // Return null in case of an error.
  }
}



//////////////////////////////////////////////getorder///////////////////////////////////
Future<void> fetchNewOrderss() async {
    try {
      _isLoading = true;
      // Fetching data from the API
      final result = await ApiService().fetchNewOrders();

      if (result == null) {
        _errorMessage = 'Failed to fetch new orders: No data returned';
      } else {
        getorderlist = result;

        // Check if data is empty (if applicable based on your model structure)
        if (getorderlist == null) {
          _errorMessage = 'No orders found.';
        } else {
           log("New Orders fetched successfully: ${getorderlist}");
        }
      }

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error fetching new orders: $e';
      log(_errorMessage);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
////////////////////////////////////////////////////////////////////feedback///////////////////////////////////////////////////////////
bool _feedbackload = false;
  bool get feedbackload => _feedbackload;
   FeedbackViewmodel? responses;

  Future<FeedbackViewmodel?> fetchfeedback(
    
  String username,

  String comments,
  ) async {
    try {
      _feedbackload = true;
    final results = await ApiService().submitfeedbacks(username, comments);
    
    if(results == null) {
      throw Exception('Registration failed : No data returned');
    }
    final feedbackResponse = FeedbackViewmodel(data: results);
    responses = feedbackResponse as FeedbackViewmodel;
    log('feedback response === ${feedbackResponse.msg}');
    notifyListeners();
    _feedbackload = false;
    return null;

    } catch(e){}
    
    
  }
//////////////////////////////////////////tracking/////////////////////////////////////////////////////////


TrackingModel? _trackdata;
  TrackingModel? get trackdata => _trackdata;
  bool _istrackingLoading = false;
  bool get istrackingLoading => _istrackingLoading;

  Future<void> fetchtrackorders(int orderId) async {
    try {
      _istrackingLoading = true;
      notifyListeners();
      final result = await ApiService().fetchTrackingData(orderId);

      // if (result == null) {
      //   throw Exception('No data returned');
      // }

      _trackdata = result;
      notifyListeners();
    } catch (e) {
      _trackdata = null;
      notifyListeners();
      log('Error fetching tracking data: $e');
    } finally {
      _istrackingLoading = false;
      notifyListeners();
    }
  }


  /////////////////////////////////////////////////Distanceprice///////////////////////////////////////////////////////////////////
  
  bool isdisLoading = false;
  String? distanceErrorMessage;
  DistanceModel? distanceModel;

 
 Future<DistanceModel?> fetchPricee(double km) async {
  isdisLoading = true;
  distanceErrorMessage = null; // Reset any previous error message
  notifyListeners();

  try {
    log("Fetching price for distance: $km");

    // Fetch data from the API
    distanceModel = await ApiService().fetchPrice(km);

    // Log the distance model to see if it's being populated correctly
    log("Received distance model: ${distanceModel.toString()}");

  } catch (e) {
    distanceErrorMessage = e.toString();
    distanceModel = null;
    log("Error fetching distance price: $e");
  } finally {
    isdisLoading = false;
    notifyListeners();
  }
}



/////////////////////////////////////////////////////////////////////////////////////////////

  int? selectedPackageSizeWeightPrice; // Define the variable
double? get totalPrice => _totalPrice;

  /////calculation
  // Assuming you're in DistanceProvider and you want to access weightPrice
void calculateTotalPrice(double? selectedPackageSizeWeightPrice) {
  // Ensure you have both distance price and package weight price

   log("distancemodel======================="+distanceModel!.price.toString());
  double? distancePrice = double.parse(distanceModel!.price.toString());
 

  log("distancemoweightprice======================="+selectedPackageSizeWeightPrice.toString());
  double? weightPrice = selectedPackageSizeWeightPrice;

  if (weightPrice != null) {
   _totalPrice = distancePrice + weightPrice;
    print('Total Price: \$${totalPrice}');  // You can update your state/UI here with the total price.
  } else {
    print('Missing distance or weight price');
  }
}

}

