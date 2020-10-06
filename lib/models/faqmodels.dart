class FaqModels {
  String status;
  String message;
  List<FaqData> faqlist;

  FaqModels.map(dynamic obj){
    this.status = obj["status"];
    this.message = obj["message"];
    this.faqlist =
        (obj['data'] as List).map((i) => FaqData.fromJson(i)).toList();
  }

}
class FaqData{
   String id;
   String question;
   String answer;
  bool show=false;




  FaqData.fromJson(Map jsonMap)
      : id = jsonMap['id'],
        question = jsonMap['question'],
        answer = jsonMap['answer'];
}
