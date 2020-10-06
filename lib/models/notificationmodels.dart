class NotificationModels{
  String status;
  String message;
  List<NotificationData> banklist;
  NotificationModels.map(dynamic obj){
    this.status=obj["status"];
    this.message=obj["message"];
    this.banklist=(obj['data']as List).map((i)=>NotificationData.fromJson(i)).toList();
  }

}
class NotificationData{
  final int id;
  final String notification;
  final String timestamp;
   String account_no;


  NotificationData(this.id,this.notification,this.timestamp);
  NotificationData.fromJson(Map jsonMap)
      : id = jsonMap['id'],
        notification = jsonMap['notification'],
        timestamp = jsonMap['created_at'];
}
