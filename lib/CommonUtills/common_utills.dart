import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/add_benificary_file.dart';
import 'package:upaychat/Pages/add_card_file.dart';
import 'package:upaychat/Pages/add_user_profile.dart';
import 'package:upaychat/Pages/all_done_file.dart';
import 'package:upaychat/Pages/banklistfile.dart';
import 'package:upaychat/Pages/change_password_file.dart';
import 'package:upaychat/Pages/edit_profile.dart';
import 'package:upaychat/Pages/faqfile.dart';
import 'package:upaychat/Pages/forgot_password.dart';
import 'package:upaychat/Pages/forgot_password_email_mobileno_file.dart';
import 'package:upaychat/Pages/home_file.dart';
import 'package:upaychat/Pages/login_file.dart';
import 'package:upaychat/Pages/mobile_number_file.dart';
import 'package:upaychat/Pages/notificationpagae.dart';
import 'package:upaychat/Pages/password_update_file.dart';
import 'package:upaychat/Pages/pay_or_requestfile.dart';
import 'package:upaychat/Pages/payment_requestfile.dart';
import 'package:upaychat/Pages/pending_file.dart';
import 'package:upaychat/Pages/privacy_policy_file.dart';
import 'package:upaychat/Pages/register_file.dart';
import 'package:upaychat/Pages/setting_file.dart';
import 'package:upaychat/Pages/splash_screen_sec.dart';
import 'package:upaychat/Pages/transactionHistory.dart';
import 'package:upaychat/Pages/wallet.dart';

class CommonUtills

{
  static dynamic returnroutes(BuildContext context){
    return
      {

        '/login': (context) => LoginFile(),
        '/splashscreensec': (context) => SplashScreenSec(),
        '/register': (context) => RegisterFile(),
        '/mobilenumberfile': (context) => MobileNumberFile(),
        '/adduserprofile': (context) => AddUserProfile(),
        '/home': (context) => HomeFile(),
        '/forgotpassword': (context) => ForgotPassword(),
        '/forgotpasswordemailmobileotpverify': (context) => ForgotPasswordEmailMobilenoFile(),
        '/passwordupdate': (context) => PasswordUpdateFile(),
        '/setting': (context) => SettingFile(),
        '/editprofile': (context) => EditProfile(),
        '/transaction': (context) => TransactionHistory(),
        '/addcard': (context) => AddCardFile(),
        '/changepassword': (context) => ChangePasswordFile(),
        '/privacypolicy': (context) => PrivacyPolicyFile(),
        '/addbenificary': (context) => AddBenificiaryFile(),
        '/payorrequestfile': (context) => PayorRequestFile(),
        '/alldone': (context) => AllDoneFile(),
        '/paymentreq': (context) => PaymentRequestFile(),
        '/pending': (context) => PendingFile(),
        '/wallet': (context) => Wallet(),
        '/banklistfile': (context) => BankListFile(),
        '/notification': (context) => NotificationFile(),
        '/faq': (context) => FaqFile(),




      };

  }
  static Future<bool> checkNetworkStatus(BuildContext context ) async{
    bool connected=false;
    var connectivityResult = await  Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      connected=true;

    }

    else if (connectivityResult == ConnectivityResult.wifi) {
      connected=true;

    }
    return connected;

  }
  static errortoast(BuildContext context,String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 0,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  static messagetoast(BuildContext context,String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black26,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }  static successtoast(BuildContext context,String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.base_green_color
        ,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }

  static bool validateemail(String email){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!(regex.hasMatch(email)))
      return false;
    else
      return true;
  }
  static bool isempty(BuildContext context,TextEditingController controller,String msg, int length){
    String text=controller.text.toString();
    if(text.length<length||controller.text.isEmpty){
      return true;
    }
    else{
      return false;
    }
  }
  static BoxDecoration whiteboxroundeddecoration(){
    return BoxDecoration(color:Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),

          topRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0)
      ),);
  }
  static void showprogressdialogcomplete(BuildContext context, bool show){
    if(show==true){
      try {
        showGeneralDialog(context: context,
            barrierDismissible: false,
            barrierLabel: MaterialLocalizations
                .of(context)
                .modalBarrierDismissLabel,
            barrierColor: Colors.black45,

            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext buildContext,
                Animation animation,
                Animation secondaryAnimation) {
              return
                Center(child: Container(
                    height: 65, width: 65,
                    child: SpinKitChasingDots(
                      color: MyColors.base_green_color,

                      size: 50.0,
                    )
                ));
            });
      }catch(e){
        print(e);
      }
    }
    else{
      Navigator.of(context).pop();
    }
  }

  static progressdialogbox() {
    return  Center(child: Container(
        height: 65, width: 65,
        child: SpinKitChasingDots(
          color: MyColors.base_green_color,

          size: 50.0,
        )
    ));

  }
}