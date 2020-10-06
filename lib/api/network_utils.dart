import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
class NetworkUtils{
//  static String base_url = 'http://abstractsoftweb.com/upaychat2/api/';
  static String base_url = 'http://upaychat.com/api/';
  static String login = 'login';
  static String register = 'register';
  static String changepassword = 'changepassword';
  static String walletapi = 'wallet';
  static String addmoneytowallet = 'addmoneytowallet';
  static String transcation = 'mytransactions';
  static String usersearch = 'usersearch';
  static String addtransaction = 'addtransaction';
  static String bankdetails = 'bankdetails';
  static String withdrawrequest = 'withdrawrequest';
  static String requeststome = 'requeststome';
  static String cancelrequest = 'cancel-request';
  static String acceptrequest = 'acceptrequest';
  static String forgotpassword = 'forgotpassword';
  static String addcomment = 'addcomment';
  static String addlike = 'addlike';
  static String transactionshistory = 'transactionshistory';
  static String faq = 'faq';
  static String mynotification = 'mynotification';


  //http://upaychat.com/api//transactionshistory

  static NetworkUtils _instance = new NetworkUtils.internal();
  SharedPreferences sha;

  //String token=PrefrencesManager.getString(StringMessage.token);






  NetworkUtils.internal();

  factory NetworkUtils() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url, { encoding}) async{
    sha= await SharedPreferences.getInstance();
    String token=sha.getString(StringMessage.token);
    print(token);
    Map<String, String> headers;
    if(token!=null){
      headers={
        "Accept":"application/json",
        "Authorization":"Bearer "+token

      };

    }
    else{
      headers={
        "Accept":"application/json",

      };
    }

    return http
        .get(
      url,
      headers: headers,

    ).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);


      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":"+
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception( statusCode);
      }
      return _decoder.convert(res);
    }).timeout(const Duration(seconds:300));
  }

  Future<dynamic> post(String url,
      { body, encoding})async {
    sha= await SharedPreferences.getInstance();
    String token=sha.getString(StringMessage.token);

    Map<String, String> headers;
    if(token!=null){
      headers={
        "Accept":"application/json",
        "Authorization":"Bearer "+token

      };

    }
    else{
      headers={
        "Accept":"application/json",

      };
    }

    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 401 || json == null) {

        throw new Exception( statusCode);
      }
      return _decoder.convert(res);
    }).timeout(const Duration(seconds:30));
  }

}