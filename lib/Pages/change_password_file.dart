import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';

class ChangePasswordFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChangePasswordFileState();
  }

}
class ChangePasswordFileState extends State<ChangePasswordFile>{
  TextEditingController oldpassword =new TextEditingController();
  TextEditingController newpassword=new TextEditingController();
  TextEditingController confirmpassword=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
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
          CustomUiWidgets. changepasswordscreen_header(context),
          CustomUiWidgets. changepasswordscreen_bodypart(context,oldpassword,newpassword,confirmpassword),
        ],),

      );

    }

  }}
