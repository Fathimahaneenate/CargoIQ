
class Contentmodel {
    int? cId;
    String? icon;
    String? content;
    int? packageId;
    int? sizeId;
    String? iconUrl;

    Contentmodel({
        this.cId,
        this.icon,
        this.content,
        this.packageId,
        this.sizeId,
        this.iconUrl,
    });

    factory Contentmodel.fromJson(Map<String, dynamic> json) => Contentmodel(
        cId: json["c_id"],
        icon: json["icon"],
        content: json["content"],
        packageId: json["package_id"],
        sizeId: json["size_id"],
        iconUrl: json["icon_url"],
    );

    Map<String, dynamic> toJson() => {
        "c_id": cId,
        "icon": icon,
        "content": content,
        "package_id": packageId,
        "size_id": sizeId,
        "icon_url": iconUrl,
    };
}