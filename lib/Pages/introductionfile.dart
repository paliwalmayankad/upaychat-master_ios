import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/main.dart';
class  IntroductionFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
return IntroductionFileState();
  }
}
class IntroductionFileState extends State<IntroductionFile>{
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
          backgroundImage: "assets/slider_one.png",
        backgroundImageFit:BoxFit.fill,
        backgroundOpacityColor: Colors.white,
        backgroundColor: Colors.white,
        backgroundOpacity: 0.0,




      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/slider_two.jpg",
        backgroundImageFit:BoxFit.fill,
        backgroundOpacityColor: Colors.white,
        backgroundColor: Colors.white,
        backgroundOpacity: 0.0,
      ),
    );
    slides.add(
      new Slide(
        backgroundImage: "assets/slider_three.png",
        backgroundImageFit:BoxFit.fill,
        backgroundOpacityColor: Colors.white,
        backgroundColor: Colors.white,
        backgroundOpacity: 0.0,
      ),
    );
  }

  void onDonePress() {
    // TODO: go to next screen
   Navigator.of(context).pushReplacementNamed('/splashscreensec');
  }

  void onSkipPress() {
    Navigator.of(context).pushReplacementNamed('/splashscreensec');
    // TODO: go to next screen
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.black54,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.black54,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.black54,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      onSkipPress: this.onSkipPress,
     // colorSkipBtn: MyColors.base_green_color,
      highlightColorSkipBtn: MyColors.base_green_color,

      // Next, Done button
      onDonePress: this.onDonePress,
      renderNextBtn: this.renderNextBtn(),
      renderDoneBtn: this.renderDoneBtn(),
    //  colorDoneBtn: MyColors.base_green_color,
      highlightColorDoneBtn: MyColors.base_green_color,

      // Dot indicator
      colorDot: MyColors.base_green_color_20,
      colorActiveDot:MyColors.base_green_color,
      sizeDot: 13.0,
    );

  }
  
}