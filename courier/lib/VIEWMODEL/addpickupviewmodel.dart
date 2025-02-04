

import '../Model/addpickupaddressmodel.dart';

class PickupaddressViewModel {
  final PickupaddressModel addPickupAddressdata;
  PickupaddressViewModel({required this.addPickupAddressdata});
  String? get message => addPickupAddressdata.message;
}