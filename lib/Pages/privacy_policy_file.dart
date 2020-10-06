import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';

class PrivacyPolicyFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PrivacyPolicyFileState();
  }
}

class PrivacyPolicyFileState extends State<PrivacyPolicyFile>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.base_green_color_20,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _body(context),

      ),
    );
  }

  _body(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            CustomUiWidgets.privacypolicycreen_header(context),
            Expanded(child: CustomUiWidgets.privacypolicycreen_bodypart(context)),


          ],
        ));
  }
}