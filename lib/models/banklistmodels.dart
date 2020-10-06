class BankListModels{
  String status;
  String message;
  List<BankDetailData> banklist;
  BankListModels.map(dynamic obj){
    this.status=obj["status"];
    this.message=obj["message"];
    this.banklist=(obj['data']as List).map((i)=>BankDetailData.fromJson(i)).toList();
  }

}
class BankDetailData{
  final int id;
  final String bank_name;
  final String account_holder_name;
  final String account_no;


  BankDetailData(this.id,this.bank_name,this.account_holder_name,this.account_no);
  BankDetailData.fromJson(Map jsonMap)
      : id = jsonMap['id'],
        bank_name = jsonMap['bank_name'],
        account_holder_name = jsonMap['account_holder_name'],

        account_no = jsonMap['account_no'];
}