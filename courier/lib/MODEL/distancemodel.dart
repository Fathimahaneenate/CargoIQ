// import 'dart:developer';

// class DistanceModel {
//     double? price;

//     DistanceModel({
//         this.price,
//     });
  
//     factory DistanceModel.fromJson(Map<String, dynamic> json) {
//  log("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy" + json["price"].toString());
       
//       return DistanceModel(
        
//         price: json["price"],
        
//     );

//     } 
//     Map<String, dynamic> toJson() => {
//         "price": price,
//     };
// }


import 'dart:developer';

class DistanceModel {
  double? price;

  DistanceModel({this.price});

  factory DistanceModel.fromJson(Map<String, dynamic> json) {
    log("Parsing JSON response: $json");

    // Check if 'price' exists in the response and parse it
    return DistanceModel(
      price: json['price'] != null ? json['price'].toDouble() : 0.0, // Use 0.0 if price is null
    );
  }

  Map<String, dynamic> toJson() => {
        "price": price,
      };
}
