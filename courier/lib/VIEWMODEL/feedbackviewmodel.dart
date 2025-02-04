import 'package:courier/MODEL/feedbackmodel.dart';




class FeedbackViewmodel {
  final FeedbackModel data;

  FeedbackViewmodel({required this.data});
  String? get msg {
    return data.msg;
}

  String? get status {
    return data.status;
}
}