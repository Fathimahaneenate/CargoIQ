class GetorderModel {
    int? orderId;
    int? packageId;
    int? sizeId;
    int? contentId;
    int? price;
    DateTime? pickupDate;
    DateTime? deliveryDate;
    int? deliveryStatus;
    String? content;
    int? payment;

    GetorderModel({
        this.orderId,
        this.packageId,
        this.sizeId,
        this.contentId,
        this.price,
        this.pickupDate,
        this.deliveryDate,
        this.deliveryStatus,
        this.content,
        this.payment,
    });

    factory GetorderModel.fromJson(Map<String, dynamic> json) => GetorderModel(
        orderId: json["order_id"],
        packageId: json["package_id"],
        sizeId: json["size_id"],
        contentId: json["content_id"],
        price: json["price"],
        pickupDate: json["pickup_date"] == null ? null : DateTime.parse(json["pickup_date"]),
        deliveryDate: json["delivery_date"] == null ? null : DateTime.parse(json["delivery_date"]),
        deliveryStatus: json["delivery_status"],
        content: json["package_content"],
        payment: json["payment"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "package_id": packageId,
        "size_id": sizeId,
        "content_id": contentId,
        "price": price,
        "pickup_date": "${pickupDate!.year.toString().padLeft(4, '0')}-${pickupDate!.month.toString().padLeft(2, '0')}-${pickupDate!.day.toString().padLeft(2, '0')}",
        "delivery_date": "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "delivery_status": deliveryStatus,
        "package_content" : content,
        "payment": payment,
    };
}
