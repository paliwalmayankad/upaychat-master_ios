import 'package:upaychat/models/faqmodels.dart';

import 'network_utils.dart';

class FaqApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<FaqModels> search() {
    String base_token_url = NetworkUtils.base_url+NetworkUtils.faq;
    return _netUtil.get(base_token_url,
    ).then((dynamic res) {
      FaqModels results = new FaqModels.map(res);
      return results;
    });
  }


}