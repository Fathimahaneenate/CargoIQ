import 'package:courier/MODEL/packagecontentmodel.dart';


class ContentViewModel {
  final Contentmodel data;

  ContentViewModel({required this.data});

  int? get cId {
    return data.cId;
  }

  String? get icon {
    return data.icon;
  }

  String? get content {
    return data.content;
  }

  int? get packageId {
    return data.packageId;
  }

  int? get sizeId {
    return data.sizeId;
  }
String? get iconUrl {
    return data.iconUrl;
  }

}
