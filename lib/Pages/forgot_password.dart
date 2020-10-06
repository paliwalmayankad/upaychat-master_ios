import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:toast/toast.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/forgot_password_email_mobileno_file.dart';
import 'package:upaychat/Pages/password_update_file.dart';
import 'package:upaychat/firebase/firebaseauthentication.dart';

class ForgotPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ForgotPasswordState();
  }
}
class ForgotPasswordState extends State<ForgotPassword>
{
  TextEditingController mobilenumbercontroller=new TextEditingController();
  bool showotpverificationdialog=false;
  bool _obscureEnable = false;
  var pineditingcontroller=  TextEditingController();
  String code = "";
  String countrycode = '+91';
  String mobileNumber;

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: MyColors.base_green_color_20,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: _body(context)),

      ),
    );
  }

  _body(BuildContext context)
  {
     return Container(
       child: Column
         (children: <Widget>[
         CustomUiWidgets. forgotpasswordscreen_header(context),
         showotpverificationdialog==false? forgotpassword_bodypart(context): forgotpasswordemailmobileotpverifyscreen_bodypart(context),
       ],),

     );

  }

  forgotpassword_bodypart(BuildContext context) {
 return Container(
    margin: EdgeInsets.only(top: 10,left: 8,right: 8),
    child: Column(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
        child:
        Text('enter your phone',textAlign:TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),),


      ),
      /// FIRST NAME
      Row(

        children: <Widget>[

          Expanded(flex:1,
            child:

            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color:    Color(0xff64748b), width: 0.2,
                    )),
                margin: EdgeInsets.fromLTRB(2, 15, 2, 0),

                padding: EdgeInsets.only(top: 3,bottom: 3,left: 3,right: 3),
                child: CountryCodePicker(
                  onChanged: (CountryCode){
                    _countrychange(CountryCode);
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'IN',
                  favorite: ['+91','IN'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,textStyle: TextStyle(fontFamily: 'Doomsday'),
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                  showFlagDialog: true,
                  showFlag: false,
                )),
            /*Text(countrycode,
                                  style: TextStyle(color:Color(0xff64748b),
                                      fontWeight: FontWeight.bold,fontSize: 14),),*/
          ),
          Expanded(flex:6,child:   Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(10, 13, 8, 0),
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: mobilenumbercontroller,
              style: TextStyle(fontFamily: 'Doomsday'),
              decoration: InputDecoration(

                border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.zero),
                ),

                hintText: 'Mobile Number',

              ),
            ),
          ),),
        ],

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
          //  Navigator.of(context).pushNamed('/forgotpasswordemailmobileotpverify');
            _sendotpandcheck();
          },
          child: Text('Continue',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Doomsday'),),
        ),),
    ],),

  );}

_countrychange(CountryCode print) {
  countrycode=print.toString();
  // Fluttertoast.showToast(msg: print.toString());
}

  void _sendotpandcheck()async {
    if (true == await CommonUtills.checkNetworkStatus(context)) {
    // CommonUtills.successtoast(context, StringMessage.login_successfully);
    if(CommonUtills.isempty(context, mobilenumbercontroller, StringMessage.enter_correct_mobile_number, 10)){
    CommonUtills.errortoast(context, StringMessage.enter_correct_mobile_number);
    }

    else{

    //add  user mobile OTP Verification File

    FireBaseOTPverification.instantiate(countrycode+mobilenumbercontroller.text);

setState(() {

  showotpverificationdialog=true;
});

    FireBaseOTPverification.stateStream.listen((state)  {
      if (state == PhoneAuthState.CodeSent)
      {
        Toast.show('Code sent successfully', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

      }
      else   if (state == PhoneAuthState.AutoRetrievalTimeOut)
      {

        Toast.show("auto retrival timer oput", context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);
        CommonUtills.showprogressdialogcomplete(context, false);
      }
      else  if (state == PhoneAuthState.Verified) {
        try {
          Toast.show(
              ' verified successfully', context, duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM);
          CommonUtills.showprogressdialogcomplete(context, false);
          Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) =>
              PasswordUpdateFile(mobilenumber: countrycode +
                  mobilenumbercontroller.text.toString(),)));

        //  Navigator.of(context).pop();
        }catch(e)
      {
        print(e);
      }
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: widget.map,mobilenumber: mobilenumbercontroller.text,)));

      }
      else  if (state == PhoneAuthState.autoverified) {
        Toast.show(' autoverified successfully', context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        CommonUtills.showprogressdialogcomplete(context, false);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>PasswordUpdateFile(mobilenumber: countrycode+mobilenumbercontroller.text.toString())));
      //  Navigator.of(context).pop();

      }
      else if (state == PhoneAuthState.Sessionerror) {
        CommonUtills.showprogressdialogcomplete(context, false);
        Toast.show('Sorry , your session is expired', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
      else   if (state == PhoneAuthState.invalidcodeerror) {
        CommonUtills.showprogressdialogcomplete(context, false);
        Toast.show('Sorry , your Entered code is invalid', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
      else if (state == PhoneAuthState.error) {
        CommonUtills.showprogressdialogcomplete(context, false);
        Toast.show('Sorry , your any error occured', context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);

        debugPrint("Seems there is an issue with it");
      }
     else if (state == PhoneAuthState.Failed) {
        CommonUtills.showprogressdialogcomplete(context, false);
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

  forgotpasswordemailmobileotpverifyscreen_bodypart(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text('Enter the code sent to your mobile'+countrycode+" "+mobilenumbercontroller.text.toString(),textAlign:TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),),


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
textStyle: TextStyle(fontFamily: 'Doomsday'),
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

  void _resendcode() {
    FireBaseOTPverification.instantiate(countrycode+mobilenumbercontroller.text.toString());
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