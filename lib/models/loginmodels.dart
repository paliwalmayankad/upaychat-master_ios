class LoginModels{
  String status;
  String message;

  int id ;


  String token;
  String firstname  ;
  String profile_image  ;
  String lastname  ;
  String username  ;
  String email  ;
  String email_verified_at  ;
  String mobile  ;
  String created_at  ;
  String updated_at  ;


  LoginModels.map(dynamic obj){
    if(obj!=null)
    {
      this.status=obj["status"];
      this.message=obj["message"];
      this.token=obj["token"];
      if(status=="true") {
        //this.data=obj['data'];
        this.id = obj['data']["id"];
        this.profile_image = obj['data']['profile_image'];
        this.firstname = obj['data']["firstname"];
        this.lastname = obj['data']["lastname"];
        this.username = obj['data']["username"];
        this.email = obj['data']["email"];
        this.email_verified_at = obj['data']["email_verified_at"];
        this.mobile = obj['data']["mobile"];
        this.created_at = obj['data']["created_at"];
        this.updated_at = obj['data']["updated_at"];


      }
    }

  }

}

class Data {

}
