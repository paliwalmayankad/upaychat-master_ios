class CommonModels{
  String status;
  String message;
  CommonModels.map(dynamic obj){
    if(obj!=null)
    {
      this.status=obj["status"];
      this.message=obj["message"];

    }

  }
}