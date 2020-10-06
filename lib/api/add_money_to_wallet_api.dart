import 'package:upaychat/models/addmoneytowalletmodels.dart';
import 'package:upaychat/models/walletmodels.dart';

import 'network_utils.dart';

class AddMoneyWalletApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<AddMoneytoWalletModels> search(double totalamount,double amount,String gatewayname,String refranceID ,String senderID,String receiverID



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url +  NetworkUtils.addmoneytowallet;
    return _netUtil.post(base_token_url,
      body: {
        "amount":amount.toString(),
        "totalamount":totalamount.toString(),
        "gatewayName":gatewayname.toString(),
        "refranceID":refranceID.toString(),
        "senderID":"",
        "receiverID":"",

      }, ).then((dynamic res) {
      AddMoneytoWalletModels results = new AddMoneytoWalletModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}

