import 'package:upaychat/api/network_utils.dart';
import 'package:upaychat/models/loginmodels.dart';

class LoginApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<LoginModels> search(String email, String password,



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.login;
    return _netUtil.post(base_token_url,
      body: {
        "login_user":email,
        "password":password,









      }, ).then((dynamic res) {
      LoginModels results = new LoginModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}