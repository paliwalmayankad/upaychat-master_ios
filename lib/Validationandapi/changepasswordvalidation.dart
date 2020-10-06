import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/api/changepasswordapi.dart';
import 'package:upaychat/api/login_api.dart';
import 'package:upaychat/models/common_models.dart';
import 'package:upaychat/models/loginmodels.dart';

class ChangePasswordValidation{
  static changepassword(BuildContext context, TextEditingController oldpassword,TextEditingController newpassword,TextEditingController confirmpassword) async{
    if (true == await CommonUtills.checkNetworkStatus(context)) {
      // CommonUtills.successtoast(context, StringMessage.login_successfully);
      if(CommonUtills.isempty(context, oldpassword, StringMessage.enteroldpassword, 6)){
        CommonUtills.errortoast(context, StringMessage.enteroldpassword);
      }
      else if(CommonUtills.isempty(context, newpassword, StringMessage.enter_correnctnew_password, 6)){
        CommonUtills.errortoast(context, StringMessage.enter_correnctnew_password);
      }

     else if(newpassword.text.toString()!=confirmpassword.text.toString()){
        CommonUtills.errortoast(context, StringMessage.enter_correctconfirmpassword);
      }
      else{
        CommonUtills.showprogressdialogcomplete(context, true);
        ChangePasswordApi _loginapi = new ChangePasswordApi();
        CommonModels results = await _loginapi.search(newpassword.text,confirmpassword.text);
        if(results.status=="true"){
          CommonUtills.showprogressdialogcomplete(context, false);
          CommonUtills.successtoast(context, results.message);
      Navigator.of(context).pop();
        }
        else{
          CommonUtills.showprogressdialogcomplete(context, false);
          CommonUtills.errortoast(context,results.message);
        }
      }



    }
    else {
      CommonUtills.errortoast(context, StringMessage.network_error);
    }

  }
}