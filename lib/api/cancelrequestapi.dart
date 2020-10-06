import 'package:upaychat/models/common_models.dart';

import 'network_utils.dart';

class cancelRequestApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<CommonModels> search(String requestid



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.cancelrequest;
    return _netUtil.post(base_token_url,
      body: {
"requestId":requestid

      }, ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}