import 'package:upaychat/api/network_utils.dart';
import 'package:upaychat/models/common_models.dart';

class ChangePasswordApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<CommonModels> search(String newpassword, String confirmpassword,) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.changepassword;
    return _netUtil.post(base_token_url,
      body: {
        "new_password":newpassword,
        "confirm_password":confirmpassword,









      }, ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}
