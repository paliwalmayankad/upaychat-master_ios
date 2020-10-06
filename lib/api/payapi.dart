import 'package:upaychat/api/network_utils.dart';
import 'package:upaychat/models/common_models.dart';

class PayApirequest{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<CommonModels> search(String amount, String privacy,String caption,String touserid,String transcationtype



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.addtransaction;
    return _netUtil.post(base_token_url,
      body: {
        "amount":amount,
        "privacy":privacy,
        "caption":caption,
        "touser_id":touserid,
        "transaction_type":transcationtype,









      }, ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}