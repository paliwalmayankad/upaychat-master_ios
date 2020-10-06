import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/Pages/splash_screen_sec.dart';

import 'CommonUtills/prefrences_manager.dart';
import 'CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CommonUtills/string_files.dart';

import 'Pages/introductionfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget  {
  // This widget is the root of your application.

 @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  SplashScreenState();
  }
}
class SplashScreenState extends State<MyApp>{
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  MediaQueryData media;
  Widget screenview;
  SharedPreferences sha;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'UpayChat',
      navigatorKey: _navigator,

      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      debugShowCheckedModeBanner: false,
      home: Scaffold(resizeToAvoidBottomPadding: true,
        body: Center(child: screenview),

      ),

      routes: CommonUtills.returnroutes(context),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PrefrencesManager.init();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,]);
   handletimeout();
    Firebase.initializeApp();
  }
   handletimeout() async {
    try {
      sha=await SharedPreferences.getInstance().then((SharedPreferences sp){
        bool isfirsttime=sp.getBool(StringMessage.firsttimelogin);
        if(isfirsttime==false||isfirsttime==null){
          setState(() {
            screenview=SplashScreenSec();
          });


          // _navigator.currentState.pushReplacement( MaterialPageRoute(builder: (BuildContext context) => IntroductionFile()));
        }
        else{
          bool islogin= sp.getBool(StringMessage.islogin);
          if(islogin==null||islogin!=true){
            setState(() {
              screenview=SplashScreenSec();
            });


          }
          else {
            _navigator.currentState.pushReplacementNamed( '/home');

            // _navigator.currentState.pushReplacementNamed('/splashscreensec');
          }}

      });

    }catch (e) {
      print(e);
    }
  }
}

