import '../MODEL/ordermodel.dart';

class OrderViewmodel {
  final Ordermodel data;

  OrderViewmodel({required this.data});

  String? get status {
    return data.status;
  }

  String? get msg {
    return data.msg;
  }
}
