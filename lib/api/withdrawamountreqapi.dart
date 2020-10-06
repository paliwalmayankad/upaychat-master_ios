import 'package:upaychat/models/common_models.dart';

import 'network_utils.dart';

class WithdrawAmountRequestApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<CommonModels> search(String amount,



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.withdrawrequest;
    return _netUtil.post(base_token_url,
      body: {
        "amount":amount,










      }, ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }

}