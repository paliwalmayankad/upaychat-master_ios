import 'package:upaychat/models/walletmodels.dart';

import 'network_utils.dart';

class WalletApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<WalletModels> search(



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.walletapi;
    return _netUtil.post(base_token_url,
      body: {


      }, ).then((dynamic res) {
      WalletModels results = new WalletModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}
