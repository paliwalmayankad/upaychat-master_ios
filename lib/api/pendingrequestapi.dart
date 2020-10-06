import 'dart:developer';

import 'package:upaychat/models/pendingrequestmodels.dart';
import 'package:upaychat/models/transcationmodels.dart';

import 'network_utils.dart';

class PendingRequestApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<PendingRequestModels> search() {
    // ignore: non_constant_identifier_names

    String base_token_url = NetworkUtils.base_url+NetworkUtils.requeststome;

    return _netUtil.get(base_token_url,
    ).then((dynamic res) {
      PendingRequestModels results = new PendingRequestModels.map(res);
      //results.status = 200;
      return results;
    });
  }

}

