class WalletModels
{
  String status;
  String message;
  int id;
  String user_id;
  String balance;
  WalletModels.map(dynamic obj){
    if(obj!=null)
    {
      this.status=obj["status"];
      this.message=obj["message"];
      this.id=obj["data"]["id"];
      this.user_id=obj["data"]["user_id"];
      this.balance=obj["data"]["balance"];

    }

  }
}