// notification.dart
class AppNotification {
  int? id;
  int? notificationTokenId;
  String? title;
  String? body;
  String? createdBy;
  String? status;

  AppNotification({
    this.id,
    this.notificationTokenId,
    this.title,
    this.body,
    this.createdBy,
    this.status,
  });

  AppNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationTokenId = json['notification_token_id'];
    title = json['title'];
    body = json['body'];
    createdBy = json['created_by'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = this.id;
    data['notification_token_id'] = this.notificationTokenId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    return data;
  }
}
