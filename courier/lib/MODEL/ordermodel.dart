
class Ordermodel {
    String? status;
    String? msg;

    Ordermodel({
        this.status,
        this.msg,
    });

    factory Ordermodel.fromJson(Map<String, dynamic> json) => Ordermodel(
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
    };
}