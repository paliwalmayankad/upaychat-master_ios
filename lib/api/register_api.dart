import 'package:upaychat/models/loginmodels.dart';

import 'network_utils.dart';

class RegisterApi{

  NetworkUtils _netUtil = new NetworkUtils();

  Future<LoginModels> search(String firstname,String lastname,String username,String mobile,String email, String password,



  ) {
  // ignore: non_constant_identifier_names
  String base_token_url = NetworkUtils.base_url +  NetworkUtils.register;
  return _netUtil.post(base_token_url,
  body: {
  "firstname":firstname,
  "lastname":lastname,
  "username":username,
  "mobile":mobile,
  "email":email,
  "password":password,
  "c_password":password,









  }, ).then((dynamic res) {
  LoginModels results = new LoginModels.map(res);
  //results.status = 200;
  return results;
  });
  }
  }
