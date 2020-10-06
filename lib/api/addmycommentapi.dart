import 'package:upaychat/api/network_utils.dart';
import 'package:upaychat/models/common_models.dart';

class AddMyCommentApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<CommonModels> search(String transactionid,String comment



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.addcomment;
    return _netUtil.post(base_token_url,
      body: {
        "transactionid":transactionid,
        "comment":comment,

      }, ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}
