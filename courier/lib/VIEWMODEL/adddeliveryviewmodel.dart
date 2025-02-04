


import '../MODEL/adddeliveryaddressmodel.dart';

class DeliveryaddressViewModel {
  final DeliveryaddressModel addDeliveryAddressdata;
  DeliveryaddressViewModel({required this.addDeliveryAddressdata});
  String? get message => addDeliveryAddressdata.message;
}