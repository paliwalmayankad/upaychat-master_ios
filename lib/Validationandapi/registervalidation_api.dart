import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';


import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/Pages/add_user_profile.dart';
import 'package:upaychat/Pages/login_file.dart';
import 'package:upaychat/Pages/mobile_number_file.dart';
import 'package:upaychat/api/login_api.dart';
import 'package:upaychat/api/network_utils.dart';
import 'package:upaychat/firebase/firebaseauthentication.dart';
import 'package:upaychat/models/loginmodels.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class RegisterValidation{
  static checkbasicdetailforregister(BuildContext context, TextEditingController firstnamecontroller,TextEditingController lastnamecontroller,TextEditingController emailcontroller,TextEditingController passwordcontroller) async{
    if (true == await CommonUtills.checkNetworkStatus(context)) {
      // CommonUtills.successtoast(context, StringMessage.login_successfully);
      if(CommonUtills.isempty(context, firstnamecontroller, StringMessage.firstname_error, 3)){
        CommonUtills.errortoast(context, StringMessage.firstname_error);
      }
      else if(CommonUtills.isempty(context, lastnamecontroller, StringMessage.lastname_error, 3)){
        CommonUtills.errortoast(context, StringMessage.lastname_error);
      }
      else  if(CommonUtills.isempty(context, emailcontroller, StringMessage.enter_correct_email, 3)){
        CommonUtills.errortoast(context, StringMessage.enter_correct_email);
      }
      else if(CommonUtills.validateemail(emailcontroller.text)==false){
        CommonUtills.errortoast(context, StringMessage.enter_correct_email);
      }
      else if(CommonUtills.isempty(context, passwordcontroller, StringMessage.enter_correct_password, 6)){
        CommonUtills.errortoast(context, StringMessage.enter_correct_password);
      }
      else{
        Map data={'firstname':firstnamecontroller.text,'lastname':lastnamecontroller.text,'email':emailcontroller.text,'password':passwordcontroller.text,};
        //  Navigator.of(context).pushNamed('/mobilenumberfile',arguments: {map:data});
        Navigator.push(context,MaterialPageRoute(builder: (context)=>MobileNumberFile(map: data,)));
        /*CommonUtills.showprogressdialogcomplete(context, true);
        LoginApi _loginapi = new LoginApi();
        LoginModels results = await _loginapi.search(emailcontroller.text,passwordcontroller.text);
        if(results.status=="true"){
          CommonUtills.showprogressdialogcomplete(context, false);
          CommonUtills.successtoast(context, results.message);
         // _savemydata(results,context);
        }
        else{
          CommonUtills.showprogressdialogcomplete(context, false);
          CommonUtills.errortoast(context,results.message);
        }*/
      }



    }
    else {
      CommonUtills.errortoast(context, StringMessage.network_error);
    }

  }

  static checkregisterformobilenumber(BuildContext context,TextEditingController mobilenumbercontroller,Map data) async{
    if (true == await CommonUtills.checkNetworkStatus(context)) {
      // CommonUtills.successtoast(context, StringMessage.login_successfully);
      if(CommonUtills.isempty(context, mobilenumbercontroller, StringMessage.enter_correct_mobile_number, 10)){
        CommonUtills.errortoast(context, StringMessage.enter_correct_mobile_number);
      }

      else{

            //add  user mobile OTP Verification File
        FireBaseOTPverification.instantiate(mobilenumbercontroller.text);

        FireBaseOTPverification.stateStream.listen((state) {
          if (state == PhoneAuthState.CodeSent)
          {
            Toast.show("code sent", context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);

          }
          if (state == PhoneAuthState.AutoRetrievalTimeOut)
          {

            Toast.show("auto retrival timer oput", context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);
          }
          if (state == PhoneAuthState.Verified) {
            Toast.show(
                ' verified successfully', context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);


            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: data,mobilenumber: mobilenumbercontroller.text,)));

          }
          if (state == PhoneAuthState.autoverified) {
            Toast.show(
                ' autoverified successfully', context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: data,mobilenumber: mobilenumbercontroller.text,)));

          }
          if (state == PhoneAuthState.Sessionerror) {

            Toast.show('Sorry , your session is expired', context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);

            debugPrint("Seems there is an issue with it");
          }
          if (state == PhoneAuthState.invalidcodeerror) {

            Toast.show('Sorry , your Entered code is invalid', context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);

            debugPrint("Seems there is an issue with it");
          }if (state == PhoneAuthState.error) {

            Toast.show('Sorry , your any error occured', context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);

            debugPrint("Seems there is an issue with it");
          }
          if (state == PhoneAuthState.Failed) {

            Toast.show("sorry your verification failed", context, duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);

            debugPrint("Seems there is an issue with it");
          }
        });



       // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: data,mobilenumber: mobilenumbercontroller.text,)));

      }



    }
    else {
      CommonUtills.errortoast(context, StringMessage.network_error);
    }
  }
  static usernamevalidation(BuildContext context,TextEditingController usernamecontroller,Map data,String mobilenumber, File image,String countrycode) async{
    if (true == await CommonUtills.checkNetworkStatus(context)) {
      // CommonUtills.successtoast(context, StringMessage.login_successfully);
      if(CommonUtills.isempty(context, usernamecontroller, StringMessage.username_error, 6)){
        CommonUtills.errortoast(context, StringMessage.username_error);
      }

     else if(image==null){
        CommonUtills.errortoast(context, StringMessage.select_image);
      }

      else{
        _callMultipartrequestforimageandtegister(context,usernamecontroller, data, mobilenumber,image,countrycode);


        // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: data,mobilenumber: mobilenumbercontroller.text,)));

      }



    }
    else {
      CommonUtills.errortoast(context, StringMessage.network_error);
    }
  }

  static void _callMultipartrequestforimageandtegister(BuildContext context,TextEditingController usernamecontroller, Map data, String mobilenumber, File images,String countrycode) async
  {
    CommonUtills.showprogressdialogcomplete(context, true);
    try {
      var stream = new http.ByteStream(
          DelegatingStream.typed(images.openRead()));

      var length = await images.length();

      Map<String, String> headers = {'Accept': 'application/json'};
      var uri = Uri.parse(NetworkUtils.base_url+NetworkUtils.register);
      var request = new http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFileSign = new http.MultipartFile(
          'profile_image', stream, length,
          filename: images.path);

      // add file to multipart
      request.files.add(multipartFileSign);

      request.headers.addAll(headers);

      request.fields['firstname'] = data['firstname'];
      request.fields['lastname'] = data['lastname'];
      request.fields['currency_code'] =countrycode??"+91" ;
      request.fields['username'] = usernamecontroller.text.toString();
      request.fields['mobile'] = mobilenumber;
      request.fields['email'] = data['email'];
      request.fields['password'] = data['password'];



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
         // CommonUtills.showprogressdialogcomplete(context, false);
          if(status=="true"){
            CommonUtills.showprogressdialogcomplete(context, false);
            CommonUtills.successtoast(context, msg+" login to continue");
           // Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
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