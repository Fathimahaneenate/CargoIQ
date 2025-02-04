class GetpackagedetailModel {
    int? pkId;
    String? icon;
    String? packageName;
    String? iconUrl;

    GetpackagedetailModel({
        this.pkId,
        this.icon,
        this.packageName,
        this.iconUrl,
    });

    factory GetpackagedetailModel.fromJson(Map<String, dynamic> json) => GetpackagedetailModel(
        pkId: json["pk_id"],
        icon: json["icon"],
        packageName: json["package_name"],
        iconUrl: json["icon_url"],
    );

    Map<String, dynamic> toJson() => {
        "pk_id": pkId,
        "icon": icon,
        "package_name": packageName,
        "icon_url": iconUrl,
    };
}
