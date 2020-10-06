import 'package:upaychat/models/banklistmodels.dart';

import 'network_utils.dart';

class BankListApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<BankListModels> search() {
    // ignore: non_constant_identifier_names

    String base_token_url = NetworkUtils.base_url+NetworkUtils.bankdetails;

    return _netUtil.get(base_token_url,
    ).then((dynamic res) {
      BankListModels results = new BankListModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}
