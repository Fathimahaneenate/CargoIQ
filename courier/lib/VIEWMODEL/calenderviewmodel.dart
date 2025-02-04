import 'package:courier/MODEL/calendermodel.dart';

class CalendarViewModel {
  final Calendermodel data; // The model instance being wrapped

  CalendarViewModel({required this.data});

  int? get calendarId {
    return data.calenderId;
  }

  DateTime? get date {
    return data.date;
  }

  bool get isAvailable {
    return data.isAvailable == 1; // Convert to a boolean for easier usage in the UI
  }

  String get formattedDate {
    return "${data.date?.year.toString().padLeft(4, '0')}-${data.date?.month.toString().padLeft(2, '0')}-${data.date?.day.toString().padLeft(2, '0')}";
  }
}
