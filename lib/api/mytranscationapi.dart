import 'package:upaychat/api/network_utils.dart';
import 'package:upaychat/models/mytransmodels.dart';

class MytranscationApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<MytranscationModels> search() {
    // ignore: non_constant_identifier_names
    String base_token_ural = 'http://abstractsoftweb.com/upaychat2/api/mytransactions?privacy=friends';
    String base_token_url = NetworkUtils.base_url+NetworkUtils.transcation;
    http://abstractsoftweb.com/upaychat2/api/mytransactions?privacy=friends
    return _netUtil.get(base_token_url,
     ).then((dynamic res) {
      MytranscationModels results = new MytranscationModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}