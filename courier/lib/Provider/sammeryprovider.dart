// import 'package:flutter/material.dart';

// class SummaryProvider with ChangeNotifier {
//   String selectedPackageType = '';
//   String selectedPackageSize = '';
//   List<String> selectedPackageContents = [];
//   DateTime? _scheduleDate;

//   // Getters
//   String get packageType => selectedPackageType;
//   String get packageSize => selectedPackageSize;
//   List<String> get packageContents => selectedPackageContents;
//   DateTime? get scheduleDate => _scheduleDate;

//   // Setters
//   void setSelectedPackageType(String type) {
//     selectedPackageType = type;
//     notifyListeners();
//   }

//   void setSelectedPackageSize(String size) {
//     selectedPackageSize = size;
//     notifyListeners();
//   }

//   void setSelectedPackageContents(List<String> contents) {
//     selectedPackageContents = contents;
//     notifyListeners();
//   }

//   void setScheduleDate(DateTime date) {
//     _scheduleDate = date;
//     notifyListeners();
//   }

//   void resetData() {
//     // _pickupAddress = {};
//     // _deliveryAddress = {};
//     selectedPackageType = '';
//     selectedPackageSize = '';
//     selectedPackageContents = [];
//     _scheduleDate = null;
//     notifyListeners();
//   }
// }


import 'dart:developer';

import 'package:flutter/material.dart';

class SummaryProvider with ChangeNotifier {
  String selectedPackageType = '';
  String selectedPackageSize = '';
  List<String> selectedPackageContents = [];
  int packageTypeIds = 0;
  int packageSizeIds = 0;
  int selectedWeightPrice = 0;
  double selectedPackageSizeWeightPrice = 0.0;
  List<int> packageContentIds = [];
  DateTime? _scheduleDate;

  // Getters
  String get packageType => selectedPackageType;
  String get packageSize => selectedPackageSize;
  List<String> get packageContents => selectedPackageContents;
  int get getPackageTypeIds => packageTypeIds;
  int get getPackageSizeIds => packageSizeIds;
  // Inside SummaryProvider
  double get getPackageSizeWeightPrice => selectedPackageSizeWeightPrice;
  List<int> get getPackageContentIds => packageContentIds;
  DateTime? get scheduleDate => _scheduleDate;

  // Setters
  void setSelectedPackageType(String type, int ids) {
    selectedPackageType = type;
    packageTypeIds = ids; // Store package type IDs
    notifyListeners();
  }

  // void setSelectedPackageSize(String size, int ids, int weightPrice) {
  //   selectedPackageSize = size;
  //   packageSizeIds = ids; // Store package size IDs
  //   selectedWeightPrice = weightPrice;
  //   notifyListeners();
  // }
 void setSelectedPackageSize(String size, int ids, double weightPrice) {
  log("weight price in summary provider -------------------------------------- "+weightPrice.toString());
  selectedPackageSize = size;
  packageSizeIds = ids;
  selectedPackageSizeWeightPrice = weightPrice;
  notifyListeners();
}



//  void setSelectedWeightPrice(int price) {
//     selectedWeightPrice = price; // Store weight price
//     notifyListeners();
//   }

  void setSelectedPackageContents(List<String> contents, List<int> ids) {
    selectedPackageContents = contents;
    packageContentIds = ids; // Store package content IDs
    notifyListeners();
  }

  void setScheduleDate(DateTime date) {
    _scheduleDate = date;
    notifyListeners();
  }
  

  void resetData() {
    selectedPackageType = '';
    selectedPackageSize = '';
    selectedPackageContents = [];
    packageTypeIds = 0;
    packageSizeIds = 0;
    selectedWeightPrice = 0;
    packageContentIds = [];
    _scheduleDate = null;
    notifyListeners();
  }
}
