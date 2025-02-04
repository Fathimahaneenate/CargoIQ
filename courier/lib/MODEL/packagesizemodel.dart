
class GetpackagesizeModel {
    int? sId;
    String? size;
    String? range;
    int? packageId;
    int? weight_price;

    GetpackagesizeModel({
        this.sId,
        this.size,
        this.range,
        this.packageId,
        this.weight_price,
    });

    factory GetpackagesizeModel.fromJson(Map<String, dynamic> json) => GetpackagesizeModel(
        sId: json["s_id"],
        size: json["size"],
        range: json["range"],
        packageId: json["package_id"],
        weight_price: json["weight_price"],
    );

    Map<String, dynamic> toJson() => {
        "s_id": sId,
        "size": size,
        "range": range,
        "package_id": packageId,
        "weight_price": weight_price,
    };
}
