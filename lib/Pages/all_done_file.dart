import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';

class AllDoneFile extends StatefulWidget{
 final String msg;
  const AllDoneFile({Key key,this.msg}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllDoneFileState();

  }
}

class AllDoneFileState extends State<AllDoneFile>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(   body: Container(
      color: MyColors.base_green_color_20,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _body(context)),

    ),);
  }

  _body(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CustomUiWidgets.alldonescreen_header(context),
          CustomUiWidgets.alldonescreen_bodypart(context,widget.msg??""),
        ],
      ),

    );
  }
}