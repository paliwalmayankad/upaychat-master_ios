class AddMoneytoWalletModels{
  String status;
  String message;
  dynamic balance;

  AddMoneytoWalletModels.map(dynamic obj){

      if(obj!=null)
      {
        this.status=obj["status"];
        this.message=obj["message"];
        if(status=="true"){
          this.balance=obj['data']['balance'];
        }



    }
  }
}