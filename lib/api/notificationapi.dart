import 'package:upaychat/models/notificationmodels.dart';

import 'network_utils.dart';

class Notificationapi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<NotificationModels> search() {
    // ignore: non_constant_identifier_names

    String base_token_url = NetworkUtils.base_url+NetworkUtils.mynotification;
    http://abstractsoftweb.com/upaychat2/api/mytransactions?privacy=friends
    return _netUtil.get(base_token_url,
    ).then((dynamic res) {
      NotificationModels results = new NotificationModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}
