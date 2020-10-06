class transcationsModels{
  String status;
  String message;
  List<Transcationdata> transcationdata;
  transcationsModels.map(dynamic obj){
    this.status=obj["status"];
    this.message=obj["message"];
    this.transcationdata=(obj['data']as List).map((i)=>Transcationdata.fromJson(i)).toList();
  }
}
class Transcationdata{
  String amount;
  String timestamp;
  String transaction_type;
  String touser_id;
  String touser_name;
  String to_userimage;
  String message;
  String privacy;
  int id;

  Transcationdata.fromJson(dynamic jsonMap)
      : amount = jsonMap['amount'],
        timestamp = jsonMap['timestamp'],
        transaction_type = jsonMap['transaction_type'],
        touser_id = jsonMap['touser_id'],
        touser_name = jsonMap['touser_name'],
        to_userimage = jsonMap['to_userimage'],
        message = jsonMap['message'],
        id = jsonMap['id'],
        privacy = jsonMap['privacy']

  ;
}