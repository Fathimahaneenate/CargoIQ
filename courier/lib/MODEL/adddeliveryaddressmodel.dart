// To parse this JSON data, do
//
//     final pickupaddressModel = pickupaddressModelFromJson(jsonString);

import 'dart:convert';


class DeliveryaddressModel {
    String? message;

    DeliveryaddressModel({
        this.message,
    });

    factory DeliveryaddressModel.fromJson(Map<String, dynamic> json) => DeliveryaddressModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}