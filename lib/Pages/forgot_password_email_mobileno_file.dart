import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:toast/toast.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/password_update_file.dart';
import 'package:upaychat/firebase/firebaseauthentication.dart';
import 'package:upaychat/models/common_models.dart';

class ForgotPasswordEmailMobilenoFile extends StatefulWidget{
  final  String countrycode;
  final String mobilenumber;
  const  ForgotPasswordEmailMobilenoFile({Key key,this.countrycode,this.mobilenumber}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgotpassemailmobileOtp();
  }
}

class ForgotpassemailmobileOtp extends State<ForgotPasswordEmailMobilenoFile>
{
  bool _obscureEnable = false;
  var pineditingcontroller=  TextEditingController();
  String code = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyotpiscorrectornot();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(   body: Container(
      color: MyColors.base_green_color_20,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:_body(context)),

    ),);
  }

  _body(BuildContext context) {

    {
      return Container(
        child: Column
          (children: <Widget>[
          CustomUiWidgets. forgotpasswordemailmobileotpverifyscreen_header(context),
          forgotpasswordemailmobileotpverifyscreen_bodypart(context),
        ],),

      );

    }

  }

  forgotpasswordemailmobileotpverifyscreen_bodypart(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text('Enter the code sent to your mobile'+widget.countrycode+" "+widget.mobilenumber,textAlign:TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),),


        ),
        /// FIRST NAME
        Container(

          margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: PinInputTextField(
            pinLength: 6,
            controller: pineditingcontroller,
            autocorrect: true,
            decoration:
            BoxLooseDecoration(
              strokeWidth: 1,
              gapSpace: 10,
textStyle:  TextStyle(fontFamily: 'Doomsday'),
//              enteredColor: MyColors.base_green_color,
//              solidColor: MyColors.base_green_color_20,
//              strokeColor: Colors.black,

              obscureStyle: ObscureStyle(
                isTextObscure: _obscureEnable,

              ),

            ),
            autoFocus: true,

            textInputAction: TextInputAction.go,
            onSubmit: (pin) {
              if(pin.length==6){
                code=pin;
                _checkotpverifyandgo();
              }
              else{
                Toast.show("Enter correct otp", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
              }


            },
          ),
        ),






        Container(

          margin: EdgeInsets.only(top: 15),
          child:   FlatButton(
            textColor: Colors.white,
            highlightColor: MyColors.base_green_color_20,
            padding: EdgeInsets.only(top: 15,bottom: 15,left: 60,right: 60),
            splashColor: MyColors.base_green_color_20,
            color:MyColors.base_green_color,
            disabledColor: MyColors.base_green_color,

            shape: CustomUiWidgets.basicgreen_buttonshape(),
            onPressed:(){
              // VERFIY OTP IS RIGHT OR NOT

              String codes=pineditingcontroller.text.toString();

              if(codes.length==6){
                code=codes;
                _checkotpverifyandgo();
              }
              else{
                Toast.show("Enter correct otp", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
              }


            },
            child: Text('Submit code',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Doomsday'),),
          ),),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child: InkWell(
              onTap: (){
                //Navigator.of(context).pushNamed('/forgotpassword');
                _resendcode();
              },
              child: Text('Resend code',style: TextStyle(color: MyColors.base_green_color,fontSize: 14,fontFamily: 'Doomsday'),)),
        ),
      ],),

    );

  }

  void _verifyotpiscorrectornot() {

    FireBaseOTPverification.stateStream.listen((state) {
      if (state == PhoneAuthState.CodeSent)
      {
        Toast.show('Code sent successfully', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

      }
      if (state == PhoneAuthState.AutoRetrievalTimeOut)
      {

        Toast.show("auto retrival timer oput", context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);
        CommonUtills.showprogressdialogcomplete(context, false);
      }
      if (state == PhoneAuthState.Verified) {
        Toast.show(' verified successfullyas', context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        CommonUtills.showprogressdialogcomplete(context, false);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>PasswordUpdateFile(mobilenumber: widget.countrycode+widget.mobilenumber,)));

        Navigator.of(context).pop();
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: widget.map,mobilenumber: mobilenumbercontroller.text,)));

      }
      if (state == PhoneAuthState.autoverified) {
        Toast.show(' autoverified successfully', context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        CommonUtills.showprogressdialogcomplete(context, false);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>PasswordUpdateFile(mobilenumber: widget.countrycode+widget.mobilenumber,)));
        Navigator.of(context).pop();

      }
      if (state == PhoneAuthState.Sessionerror) {
        CommonUtills.showprogressdialogcomplete(context, false);
        Toast.show('Sorry , your session is expired', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
      if (state == PhoneAuthState.invalidcodeerror) {
        CommonUtills.showprogressdialogcomplete(context, false);
        Toast.show('Sorry , your Entered code is invalid', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }if (state == PhoneAuthState.error) {
        CommonUtills.showprogressdialogcomplete(context, false);
        Toast.show('Sorry , your any error occured', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
      if (state == PhoneAuthState.Failed) {
        CommonUtills.showprogressdialogcomplete(context, false);
        Toast.show("sorry your verification failed", context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
    });

  }

  void _resendcode() {
    FireBaseOTPverification.instantiate(widget.countrycode+widget.mobilenumber);
  }

  void _checkotpverifyandgo() {
    if(code==""||code.isEmpty||code==null||code==" "){
      Toast.show("Enter code", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
    }
    else if(code.length<6){
      Toast.show("Please enter complete code", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
    }
    else
    {
      CommonUtills.showprogressdialogcomplete(context, true);
      FireBaseOTPverification.signInWithPhoneNumber(code);
    }
  }

}