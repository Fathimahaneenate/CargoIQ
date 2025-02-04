

import 'dart:convert';


class PickupaddressModel {
    String? message;

    PickupaddressModel({
        this.message,
    });

    factory PickupaddressModel.fromJson(Map<String, dynamic> json) => PickupaddressModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
