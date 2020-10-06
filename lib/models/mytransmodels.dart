class MytranscationModels{
  String status;
  String message;

  List<MyTransData> mytransdata;

  MytranscationModels.map(dynamic obj){
    this.status=obj["status"];
    this.message=obj["message"];
    this.mytransdata=(obj['data']as List).map((i)=>MyTransData.fromJson(i)).toList();

  }
}
class MyTransData{
  String amount;
 String transaction_type;
 String touser_id;
 int id;
 int like;
 String caption;
 String privacy;
 String status;
  String created_at;
  String timestamp;
  String touser_name;
  String to_userimage;
  String trans_type;
  String message;
  bool showmycomment=false;
  List<MyComments> mycommentlist;



  MyTransData.fromJson(Map jsonMap)
      : amount = jsonMap['amount'],
        transaction_type = jsonMap['transaction_type'],
        touser_id = jsonMap['touser_id'],
        caption = jsonMap['caption'],
        privacy = jsonMap['privacy'],
        id = jsonMap['id'],
        like = jsonMap['like'],
        status = jsonMap['status'],
        created_at = jsonMap['created_at'],
        timestamp = jsonMap['timestamp'],
        touser_name = jsonMap['touser_name'],
        to_userimage = jsonMap['to_userimage'],
        message = jsonMap['message'],
        trans_type = jsonMap['trans_type'],
        this.mycommentlist=(jsonMap['comments']as List).map((i)=>MyComments.fromJson(i)).toList();


}

class MyComments{
  String comment;
  String date;
  MyComments();
  MyComments .fromJson(Map jsonMap)
      : comment = jsonMap['comment'],
        date = jsonMap['date']


  ;
}