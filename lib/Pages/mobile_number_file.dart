import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:toast/toast.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/add_user_profile.dart';
import 'package:upaychat/Validationandapi/registervalidation_api.dart';
import 'package:upaychat/firebase/firebaseauthentication.dart';

class MobileNumberFile extends StatefulWidget{
  final Map map;

  // In the constructor, require a Todo.
  MobileNumberFile({Key key, @required this.map}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MobileNumberFileState();
  }
}
class MobileNumberFileState extends State<MobileNumberFile>{
  TextEditingController mobilenumbercontroller=new TextEditingController();
  bool showotpverificationdialog=false;
  var pineditingcontroller;
  bool _obscureEnable = false;
  String code = "";
  String countrycode = '+91';
  String mobileNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonUtills.successtoast(context, widget.map['firstname']);
    pineditingcontroller= TextEditingController();
  }

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
   //   bottomNavigationBar: showotpverificationdialog==true?showbottomdialog(context):SizedBox(),

    );
  }

  _body(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    double heightScreen = screenSize.height;
    double widthScreen = screenSize.width;
    return Container(child: Column(
      children: <Widget>[
        CustomUiWidgets.mobilescreen_header(context),
        // CustomUiWidgets.mobilescreen_bodypart(context,mobilenumbercontroller,widget.map),
        showotpverificationdialog==true?Container(color: MyColors.base_green_color_20, margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            child:
            Column(children: <Widget>[
              Text('Enter the code sent to your ${countrycode+ mobilenumbercontroller.text.toString()}',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',
                  color: Colors.grey,
                  fontSize: 16,
                 ),),

              /*Align(alignment: Alignment.topLeft,
                  child: Container(child: Text("OTP", style: TextStyle(fontFamily: 'Doomsday',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),)
                  )),*/
              //// OTP VERIFICATION LAYOUT
              Align(alignment: Alignment.center, child:
              Container(
                  margin: EdgeInsets.only(left: 0, top: 40, right: 0),
                  child:  /*Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            getField("1", focusNode1,firstvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("2", focusNode2,secondvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("3", focusNode3,thridvaluecontoller),
                            SizedBox(width: 5.0),
                            getField("4", focusNode4,fourtthvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("5", focusNode5,fifthvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("6", focusNode6,sixthvaluecontroller),
                            SizedBox(width: 5.0),
                          ],
                        ),*/


                  PinInputTextField(
                    pinLength: 6,
                    controller: pineditingcontroller,


                    decoration:
                    BoxLooseDecoration(
                      strokeWidth: 0,
                      gapSpace: 10,
                      textStyle: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color),
                      enteredColor: MyColors.base_green_color,
                      solidColor: Colors.white,
                      strokeColor: Colors.black,
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
                  ))
              ),

              /// LETSGO BUTTON
              Container(
                  margin: EdgeInsets.only(top: 40), height: 40, width: 150,
                  child: MaterialButton(minWidth: 60,

                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "Lets Go", style: TextStyle(color: Colors.white,fontFamily: 'Doomsday'),),
                    color: MyColors.base_green_color,

                    splashColor: MyColors.base_bg_color,
                    colorBrightness: Brightness.light,
                    onPressed: () {

                      /*  String codes=firstvaluecontroller.text.toString()+
                            secondvaluecontroller.text.toString()+
                            thridvaluecontoller.text.toString()+
                            fourtthvaluecontroller.text.toString()+
                            fifthvaluecontroller.text.toString()+
                            sixthvaluecontroller.text.toString();*/
                      String codes=pineditingcontroller.text.toString();

                      if(codes.length==6){
                        code=codes;
                        _checkotpverifyandgo();
                      }
                      else{
                        Toast.show("Enter correct otp", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                      }



                    },


                  )
              )


            ],)
        ):  Container(
          margin: EdgeInsets.only(top: 10,left: 8,right: 8),
          child: Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
              child:
              Text('You can be paid using your phone number.',style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),),


            ),
            /// FIRST NAME
            Container(
              alignment: Alignment.centerLeft,

              child: Row(

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
                          textStyle: TextStyle(fontFamily: 'Doomsday'),
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
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

              ),),







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
                onPressed:()async{

                  if (true == await CommonUtills.checkNetworkStatus(context)) {
                    // CommonUtills.successtoast(context, StringMessage.login_successfully);
                    if(CommonUtills.isempty(context, mobilenumbercontroller, StringMessage.enter_correct_mobile_number, 5)){
                      CommonUtills.errortoast(context, StringMessage.enter_correct_mobile_number);
                    }

                    else{

                      //add  user mobile OTP Verification File

                      FireBaseOTPverification.instantiate(countrycode+mobilenumbercontroller.text);

                      FireBaseOTPverification.stateStream.listen((state) {
                        if (state == PhoneAuthState.CodeSent)
                        {
                          setState(() {
                            showotpverificationdialog=true;
                          });

                        }
                       /* if (state == PhoneAuthState.AutoRetrievalTimeOut)
                        {

                          Toast.show("auto retrival timer oput", context, duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }*/
                        if (state == PhoneAuthState.Verified) {
                          Toast.show(
                              ' verified successfully', context, duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);

                          CommonUtills.showprogressdialogcomplete(context, false);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: widget.map,mobilenumber: mobilenumbercontroller.text,countrycode: countrycode,)));

                        }
                        if (state == PhoneAuthState.autoverified) {
                          Toast.show(
                              ' autoverified successfully', context, duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          CommonUtills.showprogressdialogcomplete(context, false);
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: widget.map,mobilenumber: mobilenumbercontroller.text,countrycode: countrycode,)));

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



                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddUserProfile(map: data,mobilenumber: mobilenumbercontroller.text,)));

                    }



                  }
                  else {
                    CommonUtills.errortoast(context, StringMessage.network_error);
                  }
                  //RegisterValidation.checkregisterformobilenumber(context, mobilenumbercontroller, map);
                  //   Navigator.of(context).pushNamed('/adduserprofile');
                },
                child: Text('Continue',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
              ),),
          ],),

        )

      ],
    ));
  }

  showbottomdialog(BuildContext context) {
    return Container(color: MyColors.base_green_color_20, margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child:
        Column(children: <Widget>[
          Align(alignment: Alignment.topLeft,
              child: Container(child: Text("OTP", style: TextStyle(fontFamily: 'Doomsday',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),)
              )),
          //// OTP VERIFICATION LAYOUT
          Align(alignment: Alignment.center, child:
          Container(
              margin: EdgeInsets.only(left: 0, top: 40, right: 0),
              child:  /*Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            getField("1", focusNode1,firstvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("2", focusNode2,secondvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("3", focusNode3,thridvaluecontoller),
                            SizedBox(width: 5.0),
                            getField("4", focusNode4,fourtthvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("5", focusNode5,fifthvaluecontroller),
                            SizedBox(width: 5.0),
                            getField("6", focusNode6,sixthvaluecontroller),
                            SizedBox(width: 5.0),
                          ],
                        ),*/


              PinInputTextField(
                pinLength: 6,
                controller: pineditingcontroller,


                decoration:
                BoxLooseDecoration(
                  strokeWidth: 0,
                  gapSpace: 10,
                  textStyle: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color),
                enteredColor: MyColors.base_green_color,
                 solidColor: Colors.white,
                  strokeColor: Colors.black,
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
              ))
          ),

          /// LETSGO BUTTON
          Container(
              margin: EdgeInsets.only(top: 40), height: 40, width: 150,
              child: MaterialButton(minWidth: 60,

                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  "Lets Go", style: TextStyle(color: Colors.white,fontFamily: 'Doomsday'),),
                color: MyColors.base_green_color,

                splashColor: MyColors.base_bg_color,
                colorBrightness: Brightness.light,
                onPressed: () {

                  /*  String codes=firstvaluecontroller.text.toString()+
                            secondvaluecontroller.text.toString()+
                            thridvaluecontoller.text.toString()+
                            fourtthvaluecontroller.text.toString()+
                            fifthvaluecontroller.text.toString()+
                            sixthvaluecontroller.text.toString();*/
                  String codes=pineditingcontroller.text.toString();

                  if(codes.length==6){
                    code=codes;
                    _checkotpverifyandgo();
                  }
                  else{
                    Toast.show("Enter correct otp", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                  }



                },


              )
          )


        ],)
    );

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

  _countrychange(CountryCode print) {
    countrycode=print.toString();
    // Fluttertoast.showToast(msg: print.toString());
  }
}