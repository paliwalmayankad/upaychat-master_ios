import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';

class SplashScreenSec extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenSecState();
  }
}
 class SplashScreenSecState extends State<SplashScreenSec>
 {
   List<Slide> slides = new List();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColors.base_green_color
    ));
    PrefrencesManager.setBool(StringMessage.firsttimelogin, true);
    slides.add(
      new Slide(
        backgroundImage: CustomImages.sliderfirst,
        backgroundImageFit:BoxFit.cover,
        backgroundOpacityColor: Colors.white,
        backgroundColor: Colors.white,
        backgroundOpacity: 0.0,




      ),
    );
    slides.add(
      new Slide(
        backgroundImage:  CustomImages.slidersecond,
        backgroundImageFit:BoxFit.cover,
        backgroundOpacityColor: Colors.white,
        backgroundColor: Colors.white,
        backgroundOpacity: 0.0,
      ),
    );
  }
   @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(color: MyColors.base_bg_color,
        height:  MediaQuery.of(context).size.height,
        width: double.infinity,

        child:
      /*  Column(children: <Widget>[
          Container(height: MediaQuery.of(context).size.height/5 ,  child: CustomUiWidgets.SplashScreenSecHeader(),),
          Container(height: MediaQuery.of(context).size.height/1.95 ,
              child:CarouselSlider(
            options: CarouselOptions(height: 400.0, aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,

              scrollDirection: Axis.horizontal,),
            items: [ CustomImages.sliderfirst, CustomImages.slidersecond,].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Image.asset(i)
                  );
                },
              );
            }).toList(),
          )),
          Container(height: MediaQuery.of(context).size.height/3.50 ,  child: CustomUiWidgets.splashscreen_sec_bottomsheet_loginregister(context),),


        ],),*/

        Stack(children: <Widget>[
          //HEADER
          Positioned(
           child: CustomUiWidgets.SplashScreenSecHeader()
            ,
          ), new Positioned(

         child: Align(

            alignment: Alignment.center,
            child: Container(margin:EdgeInsets.only(top: 100.00,bottom: 125),
                child:Image.asset(CustomImages.sliderfirst)),
          )),
          ///BOTTOM SHEET

          new Positioned(
            bottom: 0.0,
            child: CustomUiWidgets.splashscreen_sec_bottomsheet_loginregister(context),
          ),
           /*Positioned(bottom: 5,
          width: double.infinity,
          height: 150,

          child: CustomUiWidgets.splashscreen_sec_bottomsheet_loginregister(context),
          )*/
        ],),
       ),

     );
  }
 }