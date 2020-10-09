import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:instant/instant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:toast/toast.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/login_file.dart';
import 'package:upaychat/Pages/splash_screen_sec.dart';
import 'package:upaychat/Validationandapi/changepasswordvalidation.dart';
import 'package:upaychat/Validationandapi/loginvalidation_api.dart';
import 'package:upaychat/Validationandapi/registervalidation_api.dart';
import 'package:upaychat/firebase/firebaseauthentication.dart';
enum phoneass { Home,profile, message, communities, bookmarks,exercise, workout, trainers,invitefriend, news,gym,setting,trainee,traineereq }
class CustomUiWidgets {
  final StreamController<bool> sstream = StreamController<bool>.broadcast();
  static StreamController<phoneass> phoneauthstates = StreamController(sync: true);
  static Stream statestt = phoneauthstates.stream;
  static Container SplashScreen(){
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white ,
      child: Center(child: splashLogo(),),

    );
  }

  static Image splashLogo(){
    return Image.asset(CustomImages.LOGOIMAGE,height: 200,width: 180,);
  }

  static Container SplashScreenSecHeader(){
    return Container(margin: EdgeInsets.only(top: 0),color: MyColors.base_green_color,
      alignment: Alignment.center, width: double.infinity,height: 100,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text('Upaychat',textAlign:TextAlign.center,style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Doomsday'),),
      ),);
  }

  static Container splashscreen_sec_bottomsheet_loginregister(BuildContext context){
    return Container(
        color: MyColors.base_green_color_20,
        width: MediaQuery.of(context).size.width,
        height:115,
        child:Stack(children: <Widget>[
          Positioned(child: Divider(
            height: 10.0,
            indent: 5.0,
            color: Colors.black87,
          ),),
          Positioned(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(width: double.infinity,

                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width:double.infinity,
                        margin: EdgeInsets.only(left: 60,right: 60),
                        child:   FlatButton(
                          textColor: Colors.white,
                          highlightColor: MyColors.base_green_color_20,
                          padding: EdgeInsets.only(top: 15,bottom: 15),
                          splashColor: MyColors.base_green_color_20,
                          color:MyColors.base_green_color,
                          disabledColor: MyColors.base_green_color,

                          shape: RoundedRectangleBorder(
                            side: BorderSide(color:MyColors.base_green_color),
                            borderRadius:     BorderRadius.circular(8.0),
                          ),
                          onPressed:(){
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Text('Login',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Doomsday'),),
                        ),),
                      Container(
                        width:double.infinity,
                        margin: EdgeInsets.only(left:60,right: 60,top: 5),
                        child:  FlatButton(
                          textColor: Colors.white,
                          highlightColor: MyColors.base_green_color_20,
                          padding: EdgeInsets.only(top: 15,bottom: 15),
                          splashColor: MyColors.base_green_color,
                          color:MyColors.base_green_color_20,
                          disabledColor: MyColors.base_green_color_20,

                          shape: RoundedRectangleBorder(
                            side: BorderSide(color:MyColors.light_grey_divider_color,width: 2,),

                            borderRadius:     BorderRadius.circular(8.0),
                          ),
                          onPressed:(){

                            Navigator.of(context).pushNamed('/register');
                          },
                          child: Text('Register',style: TextStyle(fontSize: 14,color: MyColors.base_green_color,fontFamily: 'Doomsday'),),
                        ),)

                    ],),
                ),

              ],),)
        ],));
  }
  /// LOGIN SCREEN
  static Container loginscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
               // Navigator.of(context).pop();
               // Navigator.of(context).pop();*/
                //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                Route route = MaterialPageRoute(builder: (context) => SplashScreenSec());
                Navigator.pushReplacement(context, route);
              },
              child: Text('Cancel',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Login',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pushNamed('/register');
              },
              child: Text('Register',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),

      ],),);

  }

  static Container loginscreen_bodypart(BuildContext context, TextEditingController emailcontroller, TextEditingController passwordcontroller){
    bool _obscureText = true;

    String _password;

    // Toggles the password show status

    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
          child: TextFormField(
            cursorColor: MyColors.base_green_color,
controller: emailcontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(10.0)),),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),

              hintText: 'Email,username or phone number',

            ),
          ),
        ),
        SizedBox(height: 2,),
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
          child: TextField(
            obscureText: _obscureText,
controller: passwordcontroller,
            cursorColor: MyColors.base_green_color,
            decoration: InputDecoration(

              border:  OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(10.0)),),

              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),


              hintText: 'Password',
              suffixIcon:IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.remove_red_eye,color: MyColors.base_green_color,),
              ),

             // Icon(Icons.remove_red_eye,color: MyColors.base_green_color,),

            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child: InkWell(
              onTap: (){
                Navigator.of(context).pushNamed('/forgotpassword');
              },
              child: Text('Forgot your password ?',style: TextStyle(color: MyColors.base_green_color,fontSize: 16),)),
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

            shape: basicgreen_buttonshape(),
            onPressed:(){
              LoginValidationApi.login(context,emailcontroller,passwordcontroller);

              //Navigator.of(context).pushNamed('/home');
            },
            child: Text('Login',style: TextStyle(fontSize: 14,color: Colors.white),),
          ),),
      ],),

    );

  }

//// REGISTER SCREEN HEADER
  static Container registerscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Register',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(),

        ),

      ],),);

  }
  static Container registercreen_bodypart(BuildContext context){
    bool _obscureText = true;

    String _password;

    // Toggles the password show status

    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        /// FIRST NAME
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
          child: TextFormField(

            decoration: InputDecoration(
              border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),

              hintText: 'First Name',

            ),
          ),
        ),

        /// LAST NAME
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
          child: TextFormField(

            decoration: InputDecoration(
              border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),

              hintText: 'Last Name',

            ),
          ),
        ),

        /// EMAIL
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
          child: TextFormField(

            decoration: InputDecoration(
              border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),

              hintText: 'Email',

            ),
          ),
        ),
// PASSWORD
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
          child: TextField(
            obscureText: true,

            decoration: InputDecoration(

              border:  OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),

              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),


              hintText: 'Password',
              suffixIcon:

              Icon(Icons.remove_red_eye,color: MyColors.base_green_color,


              ),

            ),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child:
            Text.rich(
              TextSpan(
                text: "By contuining, you are agree to Upaychat'''s ",
                style: TextStyle(fontSize:16,color: MyColors.grey_color),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Term of use ',
                      style: TextStyle(
                          decoration: TextDecoration.underline,fontSize:16,color: MyColors.grey_color
                      )),
                  TextSpan(
                      text: "and confirm that you have read Upaychat'''s ",
                      style: TextStyle(
                          fontSize:16,color: MyColors.grey_color
                      )),
                  TextSpan(
                      text: 'Privacy Policy.',
                      style: TextStyle(
                          decoration: TextDecoration.underline,fontSize:16,color: MyColors.grey_color
                      )),
                  // can add more TextSpans here...
                ],
              ),
            )


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

            shape: basicgreen_buttonshape(),
            onPressed:(){
              Navigator.of(context).pushNamed('/mobilenumberfile');
            },
            child: Text('Continue',style: TextStyle(fontSize: 14,color: Colors.white),),
          ),),
      ],),

    );

  }

  //// MOBILESCREEN HEADER

  static Container mobilescreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
                textColor: Colors.white,
                highlightColor: MyColors.base_green_color_20,
                padding: EdgeInsets.only(top: 15,bottom: 15),
                splashColor: MyColors.base_green_color_20,
                color:MyColors.base_green_color,
                disabledColor: MyColors.base_green_color,

                shape: RoundedRectangleBorder(

                  side: BorderSide(color:MyColors.base_green_color),
                  borderRadius:     BorderRadius.circular(0.0),
                ),
                onPressed:(){
                  Navigator.of(context).pop();
                },
                child: Row(children: <Widget>[
                  Icon(Icons.arrow_back_ios,color: Colors.white,),
                  Text(' Back',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),],)
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Mobile Number',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(),

        ),

      ],),);

  }static Container mobilescreen_bodypart(BuildContext context, TextEditingController mobilenumbercontroller, Map map){


    // Toggles the password show status

    /*return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text('You can be paid using your phone number.',style: TextStyle(color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),),


        ),
        /// FIRST NAME
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: mobilenumbercontroller,
            decoration: InputDecoration(
              prefix: Text('+1',style: TextStyle(color: Colors.black),),

              border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),

              hintText: 'Mobile Number',

            ),
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

            shape: basicgreen_buttonshape(),
            onPressed:()async{

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
              RegisterValidation.checkregisterformobilenumber(context, mobilenumbercontroller, map);
           //   Navigator.of(context).pushNamed('/adduserprofile');
            },
            child: Text('Continue',style: TextStyle(fontSize: 14,color: Colors.white),),
          ),),
      ],),

    );*/

  }

  ///ADD USER PROFILE
  static Container adduserprofilescreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(),

        ),
        Expanded(
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Profile',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),

        Expanded(
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomRight,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(

                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
              //  Navigator.of(context).pushNamed('/home');
              },
              child:

              Text(' Skip',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),

      ],),);

  }
  static Container adduserscreen_bodypart(BuildContext context,TextEditingController usernamecontroller, Map map, String mobilenumber){


    // Toggles the password show status

    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text("Help people know it"'"s you \n they"'"re paying",textAlign:TextAlign.center,style: TextStyle(color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),),


        ),
        Container(height: 200,width: MediaQuery.of(context).size.width/3,
          child: Stack(children: <Widget>[
            Positioned(
              child: Image.asset(CustomImages.LOGOIMAGE,height:200,),
            ),
            Positioned(bottom: 55,
              right: 10,
              child:InkWell(
                  onTap: (){


                  },
                  child: Image.asset(CustomImages.LOGOIMAGE,height: 20,)),
            ),

          ],),
        ),

        /// FIRST NAME
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(

              border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),

              hintText: 'Username',

            ),
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

            shape: basicgreen_buttonshape(),
            onPressed:(){
             // RegisterValidation.usernamevalidation(context, usernamecontroller, map, mobilenumber);
              // Navigator.of(context).pushNamed('/home');
            },
            child: Text('Complete Registration',style: TextStyle(fontSize: 14,color: Colors.white),),
          ),),
      ],),

    );

  }
  /// FORGOT PASSWORD SCREEN
  static Container forgotpasswordscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pop();
              },
              child: Text('Login',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Doomsday'),),
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Forgot Password',textAlign:TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pushNamed('/register');
              },
              child: Text('Register',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),

      ],),);

  }
  static Container forgotpassword_bodypart(BuildContext context){


    // Toggles the password show status

    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text('enter your phone or email',textAlign:TextAlign.center,style: TextStyle(color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),),


        ),
        /// FIRST NAME
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(

              border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),

              hintText: 'Phone or Email',

            ),
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

            shape: basicgreen_buttonshape(),
            onPressed:(){
              Navigator.of(context).pushNamed('/forgotpasswordemailmobileotpverify');
            },
            child: Text('Continue',style: TextStyle(fontSize: 14,color: Colors.white),),
          ),),
      ],),

    );

  }
  /// FORGOTPASSWORD MOBILE EMAIL VERIFICATION SCREEN
  static Container forgotpasswordemailmobileotpverifyscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
            width:double.infinity,

            child:    FlatButton(
                textColor: Colors.white,
                highlightColor: MyColors.base_green_color_20,
                padding: EdgeInsets.only(top: 15,bottom: 15),
                splashColor: MyColors.base_green_color_20,
                color:MyColors.base_green_color,
                disabledColor: MyColors.base_green_color,

                shape: RoundedRectangleBorder(

                  side: BorderSide(color:MyColors.base_green_color),
                  borderRadius:     BorderRadius.circular(0.0),
                ),
                onPressed:(){
                  Navigator.of(context).pop();
                },
                child: Row(children: <Widget>[
                  Icon(Icons.arrow_back_ios,color: Colors.white,),
                  Text(' Back',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),],)
            ),),

        ),


      ],),);

  }

  static Container forgotpasswordemailmobileotpverifyscreen_bodypart(BuildContext context){

    bool _obscureEnable = false;
    var pineditingcontroller=  TextEditingController();
    String code = "";
    // Toggles the password show status

    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text('Enter the code sent to your email/mobile address abcd@gmail.com/1234567890',textAlign:TextAlign.center,style: TextStyle(color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),),


        ),
        /// FIRST NAME
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: PinInputTextField(
            pinLength: 6,
            controller: pineditingcontroller,
            decoration:
            BoxLooseDecoration(
              strokeWidth: 0,
              gapSpace: 10,

//              enteredColor: Colors.black,
//              solidColor: Colors.white,
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

              }
              else{
                //   Toast.show("Enter correct otp", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
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

            shape: basicgreen_buttonshape(),
            onPressed:(){
              Navigator.of(context).pushNamed('/passwordupdate');
            },
            child: Text('Submit code',style: TextStyle(fontSize: 14,color: Colors.white),),
          ),),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child: InkWell(
              onTap: (){
                //Navigator.of(context).pushNamed('/forgotpassword');
              },
              child: Text('Resend code',style: TextStyle(color: MyColors.base_green_color,fontSize: 14),)),
        ),
      ],),

    );

  }
  // UPDATE PASSWORD CHANGE PASSWORD SCREEN
  static Container updatepasswordscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Forgot Password',textAlign:TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pushNamed('/login');
              },
              child: Text('Login',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),

      ],),);

  }
  static Container updatepasswordscreen_bodypart(BuildContext context){


    // Toggles the password show status

    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,

          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text('ENTER A NEW PASSWORD',style: TextStyle(color:Colors.black,fontSize: 16,),),


        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextField(
            obscureText: true,

            decoration: InputDecoration(

              border:  OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),

              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),


              hintText: 'New password',



            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,

          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text('VERIFY PASSWORD',style: TextStyle(color:Colors.black,fontSize: 16,),),


        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextField(
            obscureText: true,

            decoration: InputDecoration(

              border:  OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),

              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),

              hintText: 'Confirm new password',
            ),
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

            shape: basicgreen_buttonshape(),
            onPressed:(){
              Navigator.of(context).pushNamed('/home');
            },
            child: Text('Change Password',style: TextStyle(fontSize: 14,color: Colors.white),),
          ),),
      ],),

    );

  }

  static RoundedRectangleBorder basicgreen_buttonshape(){
    return RoundedRectangleBorder(
      side: BorderSide(color:MyColors.base_green_color),
      borderRadius:     BorderRadius.circular(8.0),


    );
  }


  /// NAVIGATION CUSTOM DRAWER
  static Container homenavigationdrawer(BuildContext context, GlobalKey<ScaffoldState> scaffoldState, Widget screenview){
    double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return Container(
        color: MyColors.navigation_bg_color,
        child: new Container
          (width: 200,height: double.infinity, color: MyColors.navigation_bg_color,
            child:
            Container(alignment: Alignment.center,margin: EdgeInsets.only(left: 10,top:statusbarHeight ), child:
            SingleChildScrollView(scrollDirection: Axis.vertical, child:
            Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();

                  },
                  child: Container(height: 170 ,margin: EdgeInsets.only(left: 00),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Positioned(
                            child: Image.asset(CustomImages.default_profilepic,height:80,),
                          ),
                          Positioned(bottom:0,
                            right: 0,
                            child: Image.asset(CustomImages.edit_photo,height: 20,),
                          ),

                        ],)
                        ,SizedBox(height:10,),
                        Text("iam stallion",style: TextStyle(color: MyColors.navigation_textcolor),textAlign: TextAlign.center,),
                        SizedBox(height:3,),
                        Text("iam stallion",style: TextStyle(color: MyColors.navigation_textcolor),textAlign: TextAlign.center,),
                        SizedBox(height: 20,),
                        Row(children: <Widget>[
                          Expanded(flex:1,child:  Text("&0.00",style: TextStyle(color: MyColors.navigation_textcolor),textAlign: TextAlign.start,),
                          ),
                          Expanded(flex:2,child:  Text("Manage Balance ",style: TextStyle(color: MyColors.base_green_color,fontSize: 14),textAlign: TextAlign.end,),
                          ),
                        ],)


                      ],),),),
                Container(height: 1,color: MyColors.grey_color,),
                SizedBox(height: 5,),
                InkWell(onTap: ()
                {
                  Navigator.of(context).pop();
                  addState(phoneass.Home);
                },
                  child:
                  Container(child:
                  Row(  children: <Widget>[
                    Image.asset(CustomImages.selected_home,height: 30,width: 30,),
                    SizedBox(width: 10,),
                    Text('Home',style: TextStyle(color: MyColors.base_green_color,fontSize: 14),)

                  ],)),),
                SizedBox(height: 13,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/editprofile");
                    addState(phoneass.profile);




                  }, child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.round_grey_user,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Profile',style: TextStyle(color:Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(
                  onTap: (){
                    addState(phoneass.message);
                    Navigator.of(context).pop();
                  },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.grey_dollar_note,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Wallet',style: TextStyle(color:Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(
                  onTap: (){
                    addState(phoneass.message);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/addbenificary");
                  },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.unselected_search,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Search People',style: TextStyle(color:Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){
                  addState(phoneass.communities);
                  Navigator.of(context).pop();
                },child: Container(child:Row( children: <Widget>[
                  Image.asset(CustomImages.unselected_bell,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Notification',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),
                SizedBox(height: 13,),
                InkWell(onTap: (){
                  Navigator.of(context).pop();

                  Navigator.of(context).pushNamed("/pending");
                  //addState(phoneass.bookmarks);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.unselected_timer_for_wallet,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Pending',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),

                SizedBox(height: 13,),
                InkWell(onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/setting");
                  // addState(phoneass.workout);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.unselected_setting,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Setting & Help',style: TextStyle(color: Colors.white,fontSize: 14),)

                ],)),),






              ],
            ),
            ) ,)));
  }

  static addState(phoneass state){
    phoneauthstates.sink.add(state);
  }
  ///SETTING FILE
  static Container settingscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

      child:Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
                textColor: Colors.white,
                highlightColor: MyColors.base_green_color_20,
                padding: EdgeInsets.only(top: 15,bottom: 15),
                splashColor: MyColors.base_green_color_20,
                color:MyColors.base_green_color,
                disabledColor: MyColors.base_green_color,

                shape: RoundedRectangleBorder(

                  side: BorderSide(color:MyColors.base_green_color),
                  borderRadius:     BorderRadius.circular(0.0),
                ),
                onPressed:(){
                  Navigator.of(context).pop();
                },
                child: Row(children: <Widget>[
                  Icon(Icons.arrow_back_ios,color: Colors.white,),
                ],)
            ),),

        ),
        Expanded(flex: 2,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Setting & Help',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(),

        ),

      ],),);

  }

  static Container setting_bodypart(BuildContext context){
    return Container(alignment: Alignment.topLeft,
        margin:  EdgeInsets.only(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 25,),
              Text('   Setting',textAlign: TextAlign.start,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color),),
              SizedBox(height: 5,),
              Container(color: Colors.white,
                child: Column(children: <Widget>[
                  Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:InkWell(onTap: (){
                        Navigator.of(context).pushNamed("/editprofile");
                      } ,child: Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.green_person,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Edit Profile",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                  InkWell(onTap:(){
                    Navigator.of(context).pushNamed("/banklistfile");

                  },
                      child:(
                          Container(width: double.infinity
                              ,
                              padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                              child:  Row(children: <Widget>[
                                Expanded(

                                    child:

                                    Align( alignment: Alignment.centerLeft,child:
                                    Image.asset(CustomImages.green_card,height: 30,width: 30,))),

                                Expanded(flex:6,child:
                                Align( alignment: Alignment.topLeft,child:Text("Bank & Cards",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                                Expanded(child:
                                Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                              ],)))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                  Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:InkWell(onTap: (){
                        Navigator.of(context).pushNamed("/notification");
                      } ,child: Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.selected_bell,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Notifications",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                  InkWell(onTap: (){
                    Navigator.of(context).pushNamed('/changepassword');
                  },child:Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.green_key,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Change Password",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                 /* InkWell(onTap: (){
                    Navigator.of(context).pushNamed('/privacypolicy');

                  },child:Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.green_lock,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Privacy",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
*/

                ],),
              ),
              SizedBox(height: 25,),
              Text('   Help',textAlign: TextAlign.start,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color),),
              SizedBox(height: 5,),
              Container(color: Colors.white,
                child: Column(children: <Widget>[
                  Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed("/faq");
                          },
                          child:Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.green_chat_question,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("FAQ",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                  InkWell(
                      onTap:()async{
                        final Email email = Email(
                          body: 'Email body',
                          subject: 'Email subject',
                          recipients: ['support@upaychat.com'],


                          isHTML: false,
                        );

                        await FlutterEmailSender.send(email);
                      },
                      child:Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.green_phone,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Contact Us",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                /*  Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.green_thought,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Complaints",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],)),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
*/


                ],),
              ),
              SizedBox(height: 15,),
              Container(color: Colors.white,
                child: Column(children: <Widget>[
                  Container(color: MyColors.light_grey_divider_color,height: 1,),

                  InkWell(
                      onTap: (){

                        _createlogoutdialogbox(context);
                     /* PrefrencesManager.setBool(StringMessage.islogin, false);
                      PrefrencesManager.clear();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, new MaterialPageRoute(builder:  (ctxt) =>  LoginFile()));*/
                      },
                      child:Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[


                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Sign out",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),




                ],),
              ),
              SizedBox(height: 15,),

            ],)
          ,
        )

    );
  }

  ///EDIT PROFILE FILE
  static Container editprofilescreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

      child:Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
                textColor: Colors.white,
                highlightColor: MyColors.base_green_color_20,
                padding: EdgeInsets.only(top: 15,bottom: 15),
                splashColor: MyColors.base_green_color_20,
                color:MyColors.base_green_color,
                disabledColor: MyColors.base_green_color,

                shape: RoundedRectangleBorder(

                  side: BorderSide(color:MyColors.base_green_color),
                  borderRadius:     BorderRadius.circular(0.0),
                ),
                onPressed:(){
                  Navigator.of(context).pop();
                },
                child: Row(children: <Widget>[
                  Icon(Icons.arrow_back_ios,color: Colors.white,),
                ],)
            ),),

        ),
        Expanded(flex: 2,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Edit Profile',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container( padding: EdgeInsets.only(), alignment: Alignment.bottomRight,child:FlatButton(
            textColor: Colors.white,
            highlightColor: MyColors.base_green_color_20,
            padding: EdgeInsets.only(top: 15,bottom: 15),
            splashColor: MyColors.base_green_color_20,
            color:MyColors.base_green_color,
            disabledColor: MyColors.base_green_color,

            shape: RoundedRectangleBorder(
              side: BorderSide(color:MyColors.base_green_color),
              borderRadius:     BorderRadius.circular(0.0),
            ),
            onPressed:(){},
            child: Text('Save',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
            ),),
          ),

        ),

      ],),);

  }
  static Container editprofilescreen_body(BuildContext context){

    return Container(
      margin:  EdgeInsets.only(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Column(
            children: <Widget>[
              ///
              Container(height: 150,width: MediaQuery.of(context).size.width/3,
                child: Stack(children: <Widget>[
                  Positioned(
                    child: Image.asset(CustomImages.default_profilepic,height:200,),
                  ),
                  Positioned(bottom: 25,
                    right: 10,
                    child: Image.asset(CustomImages.edit_photo,height: 20,),
                  ),

                ],),
              ),

              SizedBox(height: 2,),
              Text("Change Profile Photo",style: TextStyle(color: MyColors.base_green_color),),

              SizedBox(height: 5,),
              Container(margin: EdgeInsets.only(left: 5,right: 5),child: Column(children: <Widget>[
                TextFormField(

                  cursorColor: MyColors.grey_color,style: TextStyle(color: MyColors.grey_color),
                  decoration: InputDecoration(
                    labelText: 'First Name',labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 13),
                    contentPadding:EdgeInsets.all(0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.grey_color),

                    ),



                  ),
                ),
                SizedBox(height: 2,),
                TextFormField(

                  cursorColor: MyColors.grey_color,style: TextStyle(color: MyColors.grey_color),
                  decoration: InputDecoration(
                    labelText: 'Last Name',labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 13),
                    contentPadding:EdgeInsets.all(0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.grey_color),

                    ),



                  ),
                ),
                SizedBox(height: 2,),
                TextFormField(

                  cursorColor: MyColors.grey_color,style: TextStyle(color: MyColors.grey_color),
                  decoration: InputDecoration(
                    labelText: 'Username',labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 13),
                    contentPadding:EdgeInsets.all(0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.grey_color),

                    ),



                  ),
                ),
                SizedBox(height: 2,),
                TextFormField(

                  cursorColor: MyColors.grey_color,style: TextStyle(color: MyColors.grey_color),
                  decoration: InputDecoration(
                    labelText: 'Email',labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 13),
                    contentPadding:EdgeInsets.all(0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.grey_color),

                    ),



                  ),
                ),
                SizedBox(height: 10,),
                Container(alignment: Alignment.centerLeft,child:Text("you can be paid using your username, email, or \n phone number.",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontSize: 9),)),
              ],),)




            ]),),);

  }

  ///ADD CARD SCREEN
  static Container addcardcreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

      child:Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomLeft,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom:0),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(

                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pop();
              },
              child:FlatButton(
                textColor: Colors.white,
                highlightColor: MyColors.base_green_color_20,
                padding: EdgeInsets.only(top: 15,bottom: 15),
                splashColor: MyColors.base_green_color_20,
                color:MyColors.base_green_color,
                disabledColor: MyColors.base_green_color,

                shape: RoundedRectangleBorder(
                  side: BorderSide(color:MyColors.base_green_color),
                  borderRadius:     BorderRadius.circular(0.0),
                ),
                onPressed:(){
                  Navigator.of(context).pop();
                },
                child: Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),),

        ),
        Expanded(flex: 2,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Add Bank Account',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container( padding: EdgeInsets.only(), alignment: Alignment.bottomRight,child:FlatButton(
            textColor: Colors.white,
            highlightColor: MyColors.base_green_color_20,
            padding: EdgeInsets.only(top: 15,bottom: 15),
            splashColor: MyColors.base_green_color_20,
            color:MyColors.base_green_color,
            disabledColor: MyColors.base_green_color,

            shape: RoundedRectangleBorder(
              side: BorderSide(color:MyColors.base_green_color),
              borderRadius:     BorderRadius.circular(0.0),
            ),
            onPressed:(){},
            child: Container(),),
          ),

        ),

      ],),);

  }
  static Container addcardscreen_boady(BuildContext context){

    return Container(
        margin:  EdgeInsets.only(left: 20,right:20),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:Column(
                children: <Widget>[
                  SizedBox(height: 15,),
                  TextFormField(
                    cursorColor: MyColors.base_green_color,


                    decoration: InputDecoration(fillColor: Colors.white,filled: true,
                      contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 4,right: 4),
                      labelText: "Card Number",

                      labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 12),

                      focusedBorder: OutlineInputBorder(

                        borderSide: BorderSide(color:MyColors.grey_color, width: 1.0),

                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.grey_color, width: 1.0),
                      ),
                    ),

                  ),
                  SizedBox(height: 15,),
                  Container(margin: EdgeInsets.only(right: 25), child: Row(children: <Widget>[
                    Expanded(flex:1,child:   TextFormField(
                      cursorColor: MyColors.base_green_color,


                      decoration: InputDecoration(fillColor: Colors.white,filled: true,
                        contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 4,right: 4),
                        labelText: "Expiration Date",

                        labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 12),

                        focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color:MyColors.grey_color, width: 1.0),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.grey_color, width: 1.0),
                        ),
                      ),

                    ),),

                    Expanded(flex:1,child:  Container(margin: EdgeInsets.only(left: 5), child:TextFormField(
                      cursorColor: MyColors.base_green_color,

                      decoration: InputDecoration(fillColor: Colors.white,filled: true,
                        contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 4,right: 4),
                        labelText: "Security Code",

                        labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 12),

                        focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color:MyColors.grey_color, width: 1.0),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.grey_color, width: 1.0),
                        ),
                      ),

                    )),),
                  ],)),

                  SizedBox(height: 15,),
                  Container(

                    margin: EdgeInsets.only(top: 15),
                    child:   FlatButton(
                      textColor: Colors.white,
                      highlightColor: MyColors.base_green_color_20,
                      padding: EdgeInsets.only(top: 15,bottom: 15,left: 60,right: 60),
                      splashColor: MyColors.base_green_color_20,
                      color:MyColors.base_green_color,
                      disabledColor: MyColors.base_green_color,

                      shape: basicgreen_buttonshape(),
                      onPressed:(){
                        //  Navigator.of(context).pushNamed('/home');
                      },
                      child: Text('Add',style: TextStyle(fontSize: 14,color: Colors.white),),
                    ),),


                ])));
  }
  /// CHANGE PASSWORD
  // UPDATE PASSWORD CHANGE PASSWORD SCREEN
  static Container changepasswordscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Doomsday'),),
            ),),

        ),
        Expanded(flex: 2,
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Change Password',textAlign:TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){

              },
              child: Text('',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),

      ],),);

  }
  static Container changepasswordscreen_bodypart(BuildContext context, TextEditingController oldpassword,TextEditingController newpassword,TextEditingController confirmpassword){


    // Toggles the password show status

    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,

          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child:
          Text('Current',style: TextStyle(color:MyColors.grey_color,fontSize: 16,fontFamily: 'Doomsday'),),


        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextField(
            obscureText: true,
controller: oldpassword,
            style: TextStyle(fontFamily: 'Doomsday'),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 0.5,bottom: 0.5,left: 4,right: 4),
              border:  OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(10.0)),),

              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),


              hintText: 'Your old Password',



            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,

          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child:
          Text('Enter A New Password',style: TextStyle(color:MyColors.grey_color,fontSize: 16,fontFamily: 'Doomsday'),),


        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextField(
            obscureText: true,
controller: newpassword,
            style: TextStyle(fontFamily: 'Doomsday'),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 4,right: 4),
              border:  OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(10.0)),),

              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),


              hintText: 'New Password',



            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,

          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child:
          Text('Verify Password',style: TextStyle(color:MyColors.grey_color,fontSize: 16,fontFamily: 'Doomsday'),),


        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextField(
            obscureText: true,
            style: TextStyle(fontFamily: 'Doomsday'),
controller: confirmpassword,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 4,right: 4),
              border:  OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(10.0)),),

              focusedBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                borderRadius: BorderRadius.all(Radius.zero),
              ),


              hintText: 'Confirm New Password',



            ),
          ),
        ),
        SizedBox(height: 5,),
        Text('Cahnging password will delete all your active web seosons',style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 10),),









        Container(

          margin: EdgeInsets.only(top: 15),
          child:   FlatButton(
            textColor: Colors.white,
            highlightColor: MyColors.base_green_color_20,
            padding: EdgeInsets.only(top: 15,bottom: 15,left: 60,right: 60),
            splashColor: MyColors.base_green_color_20,
            color:MyColors.base_green_color,
            disabledColor: MyColors.base_green_color,

            shape: basicgreen_buttonshape(),
            onPressed:(){
             // Navigator.of(context).pushNamed('/home');
ChangePasswordValidation.changepassword(context, oldpassword, newpassword, confirmpassword);
            },
            child: Text('Change Password',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
          ),),
        Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child:
            Text.rich(
              TextSpan(
                text: "If you forgot your current password. please log out and at top right corner click",
                style: TextStyle(fontFamily: 'Doomsday',fontSize:12,color: MyColors.grey_color),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign in ',
                      style: TextStyle(fontFamily: 'Doomsday',
                        fontSize:14,color: Colors.black,
                      )),
                  TextSpan(
                      text: "and ",
                      style: TextStyle(fontFamily: 'Doomsday',
                          fontSize:12,color: MyColors.grey_color
                      )),
                  TextSpan(
                      text: 'Forgot Password ',
                      style: TextStyle(fontFamily: 'Doomsday',
                        fontSize:14,color: Colors.black,
                      )),
                  TextSpan(
                      text: "link. ",
                      style: TextStyle(fontFamily: 'Doomsday',
                          fontSize:12,color: MyColors.grey_color
                      )),
                  // can add more TextSpans here...
                ],
              ),
            )


        ),
      ],),

    );

  }

  /// PRIVACY POLICY
  static Container privacypolicycreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

      child:Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
                textColor: Colors.white,
                highlightColor: MyColors.base_green_color_20,
                padding: EdgeInsets.only(top: 15,bottom: 15),
                splashColor: MyColors.base_green_color_20,
                color:MyColors.base_green_color,
                disabledColor: MyColors.base_green_color,

                shape: RoundedRectangleBorder(

                  side: BorderSide(color:MyColors.base_green_color),
                  borderRadius:     BorderRadius.circular(0.0),
                ),
                onPressed:(){
                  Navigator.of(context).pop();
                },
                child: Row(children: <Widget>[
                  Icon(Icons.arrow_back_ios,color: Colors.white,),
                ],)
            ),),

        ),
        Expanded(flex: 2,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomCenter,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Privacy',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(),

        ),

      ],),);

  }

  static Container privacypolicycreen_bodypart(BuildContext context){
    return Container(alignment: Alignment.topLeft,
        margin:  EdgeInsets.only(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15,),
              Container(color: MyColors.light_grey_divider_color,height: 1,),
              InkWell(onTap:(){


              },
                  child:(
                      Container(width: double.infinity
                          ,color: Colors.white,
                          padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                          child:  Row(children: <Widget>[


                            Expanded(flex:6,child:
                            Align( alignment: Alignment.topLeft,child:Text("Learn More About Privacy",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 15),))),
                            Expanded(child:
                            Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                          ],)))),
              Container(color: MyColors.light_grey_divider_color,height: 1,),
              SizedBox(height: 25,),
              Text('   Default Privacy Setting',textAlign: TextAlign.start,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text('   Select your default privacy setting for all future\n   payment. you can also change it for each\n   payment individually.',textAlign: TextAlign.start,style: TextStyle(color: MyColors.grey_color,fontSize: 12),),

              SizedBox(height: 5,),
              Container(color: Colors.white,
                child: Column(children: <Widget>[

                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                  InkWell(onTap:(){
                    //// SHOW CUSTOM DIALOGBOX
                    _createCustomDialogForChangePrivacy(context);

                  },
                      child:(
                          Container(width: double.infinity
                              ,
                              padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                              child:  Row(children: <Widget>[
                                Expanded(

                                    child:

                                    Align( alignment: Alignment.centerLeft,child:
                                    Image.asset(CustomImages.selected_globe,height: 30,width: 30,))),

                                Expanded(flex:6,child:
                                Align( alignment: Alignment.topLeft,
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Public",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                        Text("Visible to everyone on the internet",textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize:8),)
                                      ],)

                                )),
                                Expanded(child:
                                Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.selected_single_tick,height: 20,width: 20,)))

                              ],)))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                  Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.friends,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:
                        Column(  crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                            Text("Friends",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                            Text("Visible to sender and recipient and their \n Upaychat friends",textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize: 8),)
                          ],) )),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],)),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                  InkWell(onTap: (){

                  },child:Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.green_lock,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Column(  crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                            Text("Private",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                            Text("Visible to sender and recipient only",textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize: 8),)
                          ],))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],))),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),

                ],),
              ),
              SizedBox(height: 25,),
              SizedBox(height: 5,),
              Container(color: Colors.white,
                child: Column(children: <Widget>[
                  Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[


                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Post Transcations",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],)),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),
                  Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      child:  Row(children: <Widget>[


                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,child:Text("Blocked Users",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 15),))),
                        Expanded(child:
                        Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                      ],)),
                  Container(color: MyColors.light_grey_divider_color,height: 1,),



                ],),
              ),

              SizedBox(height: 15,),

            ],)
          ,
        )

    );
  }

  static void _createCustomDialogForChangePrivacy(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            child: SizedBox.expand(child: Column(children: <Widget>[
              Image.asset(CustomImages.LOGOIMAGE,height: 130,width: 80,),
              SizedBox(height: 8,),
              Text("Are you sure you want to change your default privacy setting ?",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,fontSize: 14,color: MyColors.grey_color,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Text("Did you know you can change the privacy setting for each payment individually ?",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontSize: 10),),

              SizedBox(height: 25,),
              Container(color: MyColors.light_grey_divider_color,height: 1,),

              Container(width: double.infinity
                ,
                padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                child:   Text("Change Anyway",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,color: MyColors.base_green_color,fontWeight: FontWeight.bold,fontSize: 15),),
              ),
              Container(color: MyColors.light_grey_divider_color,height: 1,),


              Container(width: double.infinity
                ,
                padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                child:    Text("Cancel",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,color: MyColors.base_green_color,fontWeight: FontWeight.bold,fontSize: 15),),
              ),

            ],)),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
///// ADD BENFICIARY

  static Container benificiaryscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
           // width:double.infinity,
            alignment: Alignment.bottomLeft,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(alignment: Alignment.bottomCenter,
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Search People',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(
          child: Container(),

        ),

      ],),);

  }
  static Container  benificiaryscreen_bodypart(BuildContext context){
    bool _obscureText = true;

    String _password;

    // Toggles the password show status

    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child:
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
                  child: TextFormField(

                    decoration: InputDecoration(
                      border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(5.0)),),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),

                      hintText: 'Name, @username,phone, or email',

                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
                  child:   Container(width: double.infinity
                      ,
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                      decoration: BoxDecoration(
                          border: Border.all(color: MyColors.grey_color,width: 1.0)
                      ),
                      child:  Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerLeft,child:
                            Image.asset(CustomImages.social_media_greeen,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Scan Code",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Quicly pay or request money",textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize:8),)
                              ],)

                        )),


                      ],)),
                ),

                SizedBox(height: 25,),
                Text('   Top People',textAlign: TextAlign.start,style: TextStyle(color: MyColors.grey_color),),
                SizedBox(height: 5,),
                Container(
margin: EdgeInsets.only(left: 10,right: 10),

                    child: ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          return Column(children: <Widget>[
                            Container(
                              color: Colors.white,
                              child:   Container(width: double.infinity
                                  ,
                                  padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: MyColors.grey_color,width: 1.0)
                                  ),
                                  child:  Row(children: <Widget>[
                                    Expanded(

                                        child:

                                        Align( alignment: Alignment.centerLeft,child:
                                        Image.asset(CustomImages.round_grey_user,height: 30,width: 30,))),

                                    Expanded(flex:6,child:
                                    Align( alignment: Alignment.topLeft,
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Scan Code",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                            Text("Quicly pay or request money",textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize:8),)
                                          ],)

                                    )),


                                  ],)),
                            ),
                            Container(color: MyColors.light_grey_divider_color,height: 1,),

                          ],);
                        })),
                SizedBox(height: 5,),
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10),

                    child: ListView.builder(
                        itemCount: 15
                        ,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          return Column(children: <Widget>[
                            Container(
                              color: Colors.white,
                              child:  InkWell(onTap: (){
                                Navigator.of(context).pushNamed("/payorrequestfile");
                              }, child:Container(width: double.infinity
                                  ,
                                  padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: MyColors.grey_color,width: 1.0)
                                  ),
                                  child:  Row(children: <Widget>[
                                    Expanded(

                                        child:

                                        Align( alignment: Alignment.centerLeft,child:
                                        Image.asset(CustomImages.round_grey_user,height: 30,width: 30,))),

                                    Expanded(flex:6,child:
                                    Align( alignment: Alignment.topLeft,
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Scan Code",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                            Text("Quicly pay or request money",textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize:8),)
                                          ],)

                                    )),


                                  ],))),
                            ),
                            Container(color: MyColors.light_grey_divider_color,height: 1,),

                          ],);
                        }))
              ])),

    );

  }

  ///// PAY OR REQUEST
  static Container payrequestscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomLeft,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(flex: 2,
          child: Container(alignment: Alignment.bottomCenter,
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Pay or Request',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(flex: 1,
            child: Container()

        ),


      ],),);

  }
  static Container   payrequestscreen_bodypart(BuildContext context){
    bool _obscureText = true;

    String _password;

    // Toggles the password show status
    double height=MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 10,left: 0,right: 0),
      child:

      Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
            Container(color: MyColors.light_grey_divider_color,height: 2,),
            Container(
                color: Colors.white,

                child:Row(children: <Widget>[

                  Expanded(flex:4,child:Text("Gunjanar",style: TextStyle(color: MyColors.base_green_color),)),
                  Expanded( flex:1,child:TextFormField(
                    textAlign: TextAlign.center,
                    cursorColor: MyColors.base_green_color,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,

                      hintText: '&0',

                    ),
                  )),])
            ),
            Container(  color: MyColors.light_grey_divider_color,height: 2,),
            SizedBox(height: 5,),
            Container(color: MyColors.light_grey_divider_color,height: 2,),
            Container(height:height/1.8 ,color: Colors.white,width: double.infinity,
              child: TextFormField(
                cursorColor: MyColors.base_green_color,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  hintText: ' Whts it for ?',

                ),
              ),
            ),
            Container(color: MyColors.light_grey_divider_color,height: 2,),
            Container(height:height/8,child:Column(children: <Widget>[
              Container(height: 20,color: MyColors.base_green_color_20,alignment: Alignment.centerRight,child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(CustomImages.selected_globe,height: 10,width: 10,),
                  SizedBox(width: 2,),
                  Text("Public",style:TextStyle(color: MyColors.grey_color),),
                  SizedBox(width:4,),
                ],),),
              Container( height:height/11.6,width: double.infinity,color: MyColors.base_green_color,
                  child:Row(children: <Widget>[
                    Expanded(flex: 35,
                      child: Container(
                        width:double.infinity,
                        alignment: Alignment.center,
                        child:   FlatButton(
                          textColor: Colors.white,
                          highlightColor: MyColors.base_green_color_20,
                          padding: EdgeInsets.only(top: 15,bottom: 15),
                          splashColor: MyColors.base_green_color_20,
                          color:MyColors.base_green_color,
                          disabledColor: MyColors.base_green_color,

                          shape: RoundedRectangleBorder(
                            side: BorderSide(color:MyColors.base_green_color),
                            borderRadius:     BorderRadius.circular(0.0),
                          ),
                          onPressed:(){
                            Navigator.of(context).pushNamed("/paymentreq");
                          },
                          child: Text('Request',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),),

                    ),

                    Expanded(flex:1,
                        child: Container(width: 1.0,margin: EdgeInsets.only(top: 3,bottom: 3),color: MyColors.grey_color,)

                    ),
                    Expanded(flex: 35,
                      child: Container(alignment: Alignment.center,
                        width:double.infinity,

                        child:   FlatButton(
                          textColor: Colors.white,
                          highlightColor: MyColors.base_green_color_20,
                          padding: EdgeInsets.only(top: 15,bottom: 15),
                          splashColor: MyColors.base_green_color_20,
                          color:MyColors.base_green_color,
                          disabledColor: MyColors.base_green_color,

                          shape: RoundedRectangleBorder(
                            side: BorderSide(color:MyColors.base_green_color),
                            borderRadius:     BorderRadius.circular(0.0),
                          ),
                          onPressed:(){
                            _callpaymentgateway(context,'public');
                            //_open_privacydialogbox(context);
                          },
                          child: Text('Pay',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),),

                    ),


                  ],)


              )

            ],)),



          ]),

    );

  }

  static void _open_privacydialogbox(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            child: SizedBox.expand(
                child: Column(children: <Widget>[

                  SizedBox(height: 8,),
                  Row(children: <Widget>[
                    Expanded(flex:1,child:
                    Text("Cancel",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,fontSize: 14,color: MyColors.base_green_color,fontWeight: FontWeight.bold),)),

                    Expanded(flex:2,child:Text("Who can See this ?",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontSize: 10),)),
                    Expanded(flex:1,child:Container()),

                  ],),
                  SizedBox(height: 15,),

                  Container(alignment: Alignment.center,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                      SizedBox(height: 10,),
                      Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerRight,child:
                            Image.asset(CustomImages.selected_globe,height: 20,width: 20,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.centerLeft,
                            child:
                           /* InkWell(onTap: (){
                              _callpaymentgateway(context,'public');
                            },child:*/
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("public",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Visible to everyone on the internet",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
                              ],)

                        )),


                      ],),
                      SizedBox(height: 10,),
                      Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.center,child:
                            Image.asset(CustomImages.friends,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Friends",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Visible to sender ,receipent, and their Upaychat friends only",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
                              ],)

                        )),


                      ],),
                      SizedBox(height: 10,),
                      Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.center,child:
                            Image.asset(CustomImages.green_lock,height: 20,width: 20,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Private",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Visible to sender and receipent only",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
                              ],)

                        )),


                      ],),
                      SizedBox(height: 10,),
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
                            Navigator.of(context).pushNamed('/alldone');
                          },
                          child: Text('Confirm',style: TextStyle(fontSize: 14,color: Colors.white),),
                        ),),
                    ],),)



                ],)),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0,1), end: Offset(0,0)).animate(anim),
          child: child,
        );
      },
    );
  }

  static void _callpaymentgateway(BuildContext context, String s) async{
    String transcation = 'No transcation Yet';
    Map<String, dynamic> _data = {};

    const platform = const MethodChannel('maugost.com/paystack_flutter');
    const paystack_pub_key = "pk_test_0efccd4aca53377768eb4de542044acb7fc4f780";
    const paystack_backend_url =
        "https://infinite-peak-60063.herokuapp.com";
    String result;
    try {

    } on PlatformException catch (e) {
      result = e.message;
      print(e.message);
    }





  }

  //// ALL DONE
  static Container alldonescreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Container(),);

  }
  static Container alldonescreen_bodypart(BuildContext context,String msg){
    bool _obscureText = true;

    String _password;

    // Toggles the password show status
    double height=MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 10,left: 0,right: 0),
      child:

      Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[




            Container(height:height/1.5 ,
                alignment: Alignment.center,
                color: Colors.white,
                width: double.infinity,
                child:Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Image.asset(CustomImages.green_ok,height: 150,width: 100,),
                  Text(msg,textAlign: TextAlign.center,style: TextStyle(color: MyColors.base_green_color),),
                ],)
            ),

            Container(width: double.infinity,margin: EdgeInsets.only(left: 10,right: 10),
              child: Container(

                margin: EdgeInsets.only(top: 15),
                child:   FlatButton(
                  textColor: Colors.white,
                  highlightColor: MyColors.base_green_color_20,
                  padding: EdgeInsets.only(top: 15,bottom: 15,left: 60,right: 60),
                  splashColor: MyColors.base_green_color_20,
                  color:MyColors.base_green_color,
                  disabledColor: MyColors.base_green_color,

                  shape: basicgreen_buttonshape(),
                  onPressed:(){
                    Navigator.of(context).pop();
                  },
                  child: Text('Done',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Doomsday'),),
                ),),
            ),



          ]),

    );

  }

  ///// PAYMENT REQUEST
  static Container paymentrequestscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomLeft,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(flex: 2,
          child: Container(alignment: Alignment.bottomCenter,
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Request',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(flex: 1,
            child: Container()

        ),


      ],),);

  }


  // PENDING FILE
  static Container pendingrequestscreen_header(BuildContext context){
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomLeft,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){
                //  Navigator.of(context).pop();
              },
              child: Text('',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(flex: 2,
          child: Container(alignment: Alignment.bottomCenter,
            width:double.infinity,

            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom: 15),
              splashColor: MyColors.base_green_color_20,
              color:MyColors.base_green_color,
              disabledColor: MyColors.base_green_color,

              shape: RoundedRectangleBorder(
                side: BorderSide(color:MyColors.base_green_color),
                borderRadius:     BorderRadius.circular(0.0),
              ),
              onPressed:(){},
              child: Text('Pending',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
            ),),

        ),
        Expanded(flex: 1,
            child: Container()

        ),


      ],),);

  }
  static String timesagofeacture(String fromdate,[BuildContext context]){
    try {

     // Locale myLocale = Localizations.localeOf(context);
var myDate = DateTime.parse(fromdate).toLocal();
      print('timeZoneName'+myDate.toString());
       const DATE_FORMAT = 'dd/MMM/yyyy HH:mm:ss';
     // var updatedatefrom = new DateFormat('EEE, dd/MMM/yyyy HH:mm:ss').parse(fromdate);
//

      //

    //  var asd = DateFormat(DATE_FORMAT).parse(myDate);
    //  print('timeZoneNameas'+asd.toString());
       DateTime nows = DateTime.now();
   //    var updatedatefrom = new DateFormat('dd/MMM/yyyy HH:mm:ss').parse(asd);



      // with a defined format
      // var newDateTimeObj2 = new DateFormat("dd/MM/yyyy HH:mm:ss").parse("10/02/2000 15:13:09");
      //DateTime EastCoast = dateTimeToZone(zone: "UTC", datetime: updatedatefrom).toLocal();

      final now = new DateTime.now();
      String timemsg;
      var locale = 'en';
      //DateTime dateTime = DateTime.tryParse(fromdate);
      final difference = now.difference(myDate);
      timemsg = timeago.format(now.subtract(difference), locale: locale);
      return timemsg;
    }
    catch(e)
    {
      print(e);
    }
  }

  static void _createlogoutdialogbox(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Do you want to Logout ?',style: TextStyle(color: Colors.black54),),
        content: Text('We hate to see you leave...'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print("you choose no");
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () {
              PrefrencesManager.setBool(StringMessage.islogin, false);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => LoginFile()),
                      (route) => false);
             // PrefrencesManager.clear();
              //Navigator.of(context).pop();
              //Navigator.popUntil(context, new MaterialPageRoute(builder:  (ctxt) =>  LoginFile()));
              //Navigator.pushReplacement(context, new MaterialPageRoute(builder:  (ctxt) =>  LoginFile()));
             // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
