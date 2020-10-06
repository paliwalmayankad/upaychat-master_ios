import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:http/http.dart' as http;
import 'package:upaychat/api/network_utils.dart';

class EditProfileValidation{
  static checkemailorusernameempty(BuildContext context, TextEditingController firstnamecontroller,TextEditingController lastnamecontroller,File images) async{
    if (true == await CommonUtills.checkNetworkStatus(context)) {
      // CommonUtills.successtoast(context, StringMessage.login_successfully);
      if(CommonUtills.isempty(context, firstnamecontroller, StringMessage.firstname_error, 3)){
        CommonUtills.errortoast(context, StringMessage.firstname_error);
      }
      else if(CommonUtills.isempty(context, lastnamecontroller, StringMessage.lastname_error, 3)){
        CommonUtills.errortoast(context, StringMessage.lastname_error);
      }

      else{
        CommonUtills.showprogressdialogcomplete(context, true);
        try {
          var stream = new http.ByteStream(
              DelegatingStream.typed(images.openRead()));

          var length = await images.length();
          String token=PrefrencesManager.getString(StringMessage.token);
          Map<String, String> headers = {'Accept': 'application/json',
            'Authorization':'Bearer $token'
          };
          var uri = Uri.parse(NetworkUtils.base_url+'updateprofile');
          var request = new http.MultipartRequest("POST", uri);

          // multipart that takes file
          var multipartFileSign = new http.MultipartFile(
              'profile_image', stream, length,
              filename: images.path);

          // add file to multipart
          request.files.add(multipartFileSign);

          request.headers.addAll(headers);

          request.fields['firstname'] = firstnamecontroller.text.toString();
          request.fields['lastname'] = lastnamecontroller.text.toString();


          // send
          var response = await request.send();

          print(response.statusCode);


          // listen for response
          response.stream.transform(utf8.decoder).listen((value) {
            try {
              print(value);
              final body = json.decode(value);

              String status=body['status'];
              String msg=body['message'];

              if(status=="true"){
                setState(){};
               PrefrencesManager.setString(StringMessage.firstname, firstnamecontroller.text.toString());
               PrefrencesManager.setString(StringMessage.lastname, lastnamecontroller.text.toString());
               PrefrencesManager.setString(StringMessage.profileimage, body['profile_image']);
               CommonUtills.showprogressdialogcomplete(context, false);
               CommonUtills.successtoast(context, "Saved");
              }
              else{
                CommonUtills.showprogressdialogcomplete(context, false);
                CommonUtills.errortoast(context, msg);
              }

            } catch (e) {
              print(e);
              CommonUtills.showprogressdialogcomplete(context, false);
            }
          });
        }catch(e){
          print(e);
          CommonUtills.showprogressdialogcomplete(context, false);
        }

      }



    }
    else {
      CommonUtills.errortoast(context, StringMessage.network_error);
    }

  }

}