import 'package:upaychat/models/common_models.dart';

import 'network_utils.dart';

class RequestforPayapi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<CommonModels> search(String requestid,String privacy,String caption



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.acceptrequest;
    return _netUtil.post(base_token_url,
      body: {
        "transactionId":requestid,
        "privacy":requestid,
        "caption":requestid

      }, ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}