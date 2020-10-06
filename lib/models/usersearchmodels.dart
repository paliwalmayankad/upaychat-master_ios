class UserSearchModels{
  String status;
  String message;
  List<UserList> userlist;
  UserSearchModels.map(dynamic obj){
    this.status=obj["status"];
    this.message=obj["message"];
    this.userlist=(obj['data']as List).map((i)=>UserList.fromJson(i)).toList();

  }
}
class UserList{
  final int user_id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String mobile;
  final String profile_image;
  const UserList(this.user_id,
      this.firstname ,
      this.lastname,
      this.username ,
      this.email,
      this.mobile ,
      this.profile_image,


      );

  UserList.fromJson(Map jsonMap)
      : user_id = jsonMap['user_id'],
        firstname = jsonMap['firstname'],
        lastname = jsonMap['lastname'],
        username = jsonMap['username'],
        email = jsonMap['email'],
        mobile = jsonMap['mobile'],
        profile_image = jsonMap['profile_image']

  ;
}