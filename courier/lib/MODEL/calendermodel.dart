

import 'dart:convert';


class Calendermodel {
    int? calenderId;
    DateTime? date;
    int? isAvailable;

    Calendermodel({
        this.calenderId,
        this.date,
        this.isAvailable,
    });

    factory Calendermodel.fromJson(Map<String, dynamic> json) => Calendermodel(
        calenderId: json["calender_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        isAvailable: json["is_available"],
    );

    Map<String, dynamic> toJson() => {
        "calender_id": calenderId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "is_available": isAvailable,
    };
}
