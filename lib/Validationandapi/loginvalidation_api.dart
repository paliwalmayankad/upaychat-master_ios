import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/Pages/home_file.dart';
import 'package:upaychat/Pages/login_file.dart';
import 'package:upaychat/api/login_api.dart';
import 'package:upaychat/models/loginmodels.dart';

class LoginValidationApi{
  static login(BuildContext context, TextEditingController emailcontroller,TextEditingController passwordcontroller) async{
    if (true == await CommonUtills.checkNetworkStatus(context)) {
     // CommonUtills.successtoast(context, StringMessage.login_successfully);
         if(CommonUtills.isempty(context, emailcontroller, StringMessage.enter_correct_email, 3)){
           CommonUtills.errortoast(context, StringMessage.enter_correct_emailusrnamemobile);
         }

         else if(CommonUtills.isempty(context, passwordcontroller, StringMessage.enter_correct_password, 6)){
           CommonUtills.errortoast(context, StringMessage.enter_correct_password);
         }
         else{
           CommonUtills.showprogressdialogcomplete(context, true);
           LoginApi _loginapi = new LoginApi();
           LoginModels results = await _loginapi.search(emailcontroller.text,passwordcontroller.text);
        if(results.status=="true"){
          CommonUtills.showprogressdialogcomplete(context, false);
          CommonUtills.successtoast(context, results.message);
          _savemydata(results,context);
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

  static void _savemydata(LoginModels results, BuildContext context) {
    PrefrencesManager.setInt(StringMessage.id, results.id);
    PrefrencesManager.setBool(StringMessage.islogin, true);
    PrefrencesManager.setString(StringMessage.firstname, results.firstname);
    PrefrencesManager.setString(StringMessage.token, results.token);
    PrefrencesManager.setString(StringMessage.profileimage, results.profile_image);
    PrefrencesManager.setString(StringMessage.lastname, results.lastname);
    PrefrencesManager.setString(StringMessage.username, results.username);
    PrefrencesManager.setString(StringMessage.email, results.email);
   // PrefrencesManager.setString(StringMessage.email_verified_at, results.email_verified_at+"");
    PrefrencesManager.setString(StringMessage.mobile, results.mobile);
    PrefrencesManager.setString(StringMessage.created_at, results.created_at);
    PrefrencesManager.setString(StringMessage.updated_at, results.updated_at);
    PrefrencesManager.setString(StringMessage.defaultprivacy, 'public');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => HomeFile()),
            (route) => false);

  }
}