

import 'package:courier/MODEL/getordermodel.dart';

class GetorderViewModel {
  final GetorderModel data;

  GetorderViewModel({required this.data});

  int? get orderId {
    return data.orderId;
  }

  int? get packageId {
    return data.packageId;
  }

  int? get sizeId {
    return data.sizeId;
  }

  int? get contentId {
    return data.contentId;
  }

  int? get price {
    return data.price;
  }

  DateTime? get pickupDate {
    return data.pickupDate;
  }

  DateTime? get deliveryDate {
    return data.deliveryDate;
  }

  int? get deliveryStatus {
    return data.deliveryStatus;
  }
  String? get content {
    return data.content;
  }

  int? get payment {
    return data.payment;
  }

  String? get formattedPickupDate {
    return data.pickupDate != null
        ? "${data.pickupDate!.year.toString().padLeft(4, '0')}-${data.pickupDate!.month.toString().padLeft(2, '0')}-${data.pickupDate!.day.toString().padLeft(2, '0')}"
        : null;
  }

  String? get formattedDeliveryDate {
    return data.deliveryDate != null
        ? "${data.deliveryDate!.year.toString().padLeft(4, '0')}-${data.deliveryDate!.month.toString().padLeft(2, '0')}-${data.deliveryDate!.day.toString().padLeft(2, '0')}"
        : null;
  }

  String get deliveryStatusText {
    switch (data.deliveryStatus) {
      case 0:
        return 'Pending';
      case 1:
        return 'Delivered';
      default:
        return 'Unknown';
    }
  }
}
