

import 'package:courier/MODEL/packagesizemodel.dart';

class PackageSizeViewModel {
  final GetpackagesizeModel data;

  PackageSizeViewModel({required this.data});

  int? get sId => data.sId;
  String? get size => data.size;
  String? get range => data.range;
  int? get packageId => data.packageId;
  // ignore: non_constant_identifier_names
  int? get weight_price => data.weight_price;
}
