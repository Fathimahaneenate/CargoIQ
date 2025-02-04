import 'package:courier/MODEL/trackingmodel.dart';


class TrackingViewModel {
  final TrackingModel datas;

  TrackingViewModel({required this.datas});

  int? get orderId {
    return datas.orderId;
  }

  int? get deliveryStatus {
    return datas.deliveryStatus;
  }

  // Add any computed properties or helper methods if needed.
}