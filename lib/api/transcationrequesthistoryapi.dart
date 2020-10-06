import 'dart:developer';

import 'package:upaychat/models/transcationmodels.dart';

import 'network_utils.dart';

class TransactionHistoryRequestApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<transcationsModels> search() {
    String base_token_url = NetworkUtils.base_url+NetworkUtils.transactionshistory;
    return _netUtil.get(base_token_url,
    ).then((dynamic res) {
      transcationsModels results = new transcationsModels.map(res);
      return results;
    });
  }






}