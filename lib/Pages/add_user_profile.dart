import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/imagepicker.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Validationandapi/registervalidation_api.dart';

class AddUserProfile extends StatefulWidget{
  final Map map;
  final String mobilenumber;

final String countrycode;
  // In the constructor, require a Todo.
  AddUserProfile({Key key, @required this.map,this.mobilenumber,this.countrycode}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddUserProfileState();
  }
}

class AddUserProfileState extends State<AddUserProfile>with TickerProviderStateMixin,ImagePickerListener
{
  TextEditingController usernamecontroller=new TextEditingController();
  File _image;
  ImagePickerHandler imagePicker;
  AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
      vsync: this,

      duration: const Duration(milliseconds: 500),
    );


    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(body: Container(
      color: MyColors.base_green_color_20,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _body(context)),

    ),);
  }

  _body(BuildContext context) {
    return Container(child: Column(
      children: <Widget>[
        CustomUiWidgets.adduserprofilescreen_header(context),
        Container(
          margin: EdgeInsets.only(top: 10,left: 8,right: 8),
          child: Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
              child:
              Text("Help people know it"'"s you \n they"'"re paying",textAlign:TextAlign.center,style: TextStyle(color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Doomsday'),),


            ),
            SizedBox(height: 2,),
            Container(height: 200,width: MediaQuery.of(context).size.width/3,
              child: Stack(children: <Widget>[
                Positioned(
                  child:   _image==null? Image.asset(CustomImages.default_profilepic,fit: BoxFit.fill,):
                  new Container(
                      height:110.0,
                      width: 180.0,
                      decoration: new BoxDecoration(
                        color: Colors.white,


                        borderRadius:
                        new BorderRadius.all(const Radius.circular(80.0)),
                      ),
                      child:ClipRRect(
                        borderRadius: new BorderRadius.circular(80.0),
                        child: Image.file(_image,fit: BoxFit.cover,height: 120,width: 100,),)),
                ),
                Positioned(bottom: 100,
                  right: 10,
                  child:InkWell(
                      onTap: (){

                        imagePicker.showDialog(context);
                      },
                      child: Image.asset(CustomImages.edit_photo,height: 20,)),
                ),

              ],),
            ),

            /// FIRST NAME
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: usernamecontroller,
                keyboardType: TextInputType.text,
                style: TextStyle(fontFamily: 'Doomsday'),
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

                shape: CustomUiWidgets.basicgreen_buttonshape(),
                onPressed:(){
                  RegisterValidation.usernamevalidation(context, usernamecontroller, widget.map,  widget.mobilenumber,_image,widget.countrycode);
                  // Navigator.of(context).pushNamed('/home');
                },
                child: Text('Complete Registration',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Doomsday'),),
              ),),
          ],),

        )

      ],
    ));}

  @override
  userImage(File _image) {
    // TODO: implement userImage
    setState(() {

      if(_image!=null) {
        this._image = _image;

      } //_scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Photo uploaded successfully'),));
    });
  }
}