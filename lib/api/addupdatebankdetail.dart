import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/models/common_models.dart';

import 'network_utils.dart';

class AddUpdateBankDetailApi{
  NetworkUtils _netUtil = new NetworkUtils();

  Future<CommonModels> search(String status,String bankid,String bankname,String bankholdername,String accountnumber



      ) {
    // ignore: non_constant_identifier_names
    String base_token_url = NetworkUtils.base_url + status;
    Map body;
    if(status=="addbank"){
      body={
        "bank_name":bankname.toString(),
        "account_holder_name":bankholdername.toString(),
        "account_no":accountnumber.toString(),

      };
    }
    else{
      body={
        "bankid":bankid.toString(),
        "bank_name":bankname.toString(),
        "account_holder_name":bankholdername.toString(),
        "account_no":accountnumber.toString(),

      };
    }

    return _netUtil.post(base_token_url,
      body: body, ).then((dynamic res) {
      CommonModels results = new CommonModels.map(res);
      //results.status = 200;
      return results;
    });
  }
}