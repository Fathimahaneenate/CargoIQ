

// class TrackingModel {
//     int? orderId;
//     int? deliveryStatus;

//     TrackingModel({
//         this.orderId,
//         this.deliveryStatus,
//     });

//     factory TrackingModel.fromJson(Map<String, dynamic> json) => TrackingModel(
//         orderId: json["order_id"] as int,
//         deliveryStatus: json["delivery_status"] as int,
//     );

//     Map<String, dynamic> toJson() => {
//         "order_id": orderId,
//         "delivery_status": deliveryStatus,
//     };
// }


class TrackingModel {
  int? orderId;
  int? deliveryStatus;

  TrackingModel({this.orderId, this.deliveryStatus});

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      orderId: _parseInt(json["order_id"]),
      deliveryStatus: _parseInt(json["delivery_status"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "delivery_status": deliveryStatus,
      };

  // Helper function to safely parse an integer, even if it's a string
  static int? _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value);
    } else if (value is int) {
      return value;
    }
    return null;
  }
}
