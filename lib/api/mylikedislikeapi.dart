import 'package:upaychat/api/network_utils.dart';
import 'package:upaychat/models/common_models.dart';

class MyLikedislikeApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<CommonModels> search(String transactionid,String like



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.addlike;
    return _netUtil.post(base_token_url,
      body: {
        "post_id":transactionid,


      }, ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}
