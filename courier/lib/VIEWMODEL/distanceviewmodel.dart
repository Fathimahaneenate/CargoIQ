import 'package:courier/MODEL/distancemodel.dart';



class DistanceViewModel {
  final DistanceModel data;

  DistanceViewModel({required this.data});

  // Getter for price
  double? get price {
    return data.price;
  }
  
  // Getter for error or success message if needed
  String get message {
    if (data.price == null || data.price == 0) {
      return "No price available";
    }
    return "Price: \$${data.price}";
  }
}
