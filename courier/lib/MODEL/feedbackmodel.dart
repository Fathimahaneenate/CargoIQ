class FeedbackModel {
    String? status;
    String? msg;

    FeedbackModel({
        this.status,
        this.msg,
    });

    factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
    };
}