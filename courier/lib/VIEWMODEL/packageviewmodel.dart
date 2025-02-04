


import 'package:courier/MODEL/pakagemodel.dart';

class PackageViewModel {
  final GetpackagedetailModel data;

  PackageViewModel({required this.data});

  int? get pkId {
    return data.pkId;
  }

  String? get icon {
    return data.icon;
  }

  String? get packageName {
    return data.packageName;
  }

  String? get iconUrl {
    return data.iconUrl;
  }
}
