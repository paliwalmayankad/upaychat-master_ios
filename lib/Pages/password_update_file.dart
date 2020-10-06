import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/api/forgotpasswordapi.dart';
import 'package:upaychat/models/common_models.dart';

class PasswordUpdateFile extends StatefulWidget{
  final  String mobilenumber;
  const PasswordUpdateFile({Key key,this.mobilenumber}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PasswordUpdateFilestate();
  }
}
class PasswordUpdateFilestate extends State<PasswordUpdateFile>
{
  TextEditingController passwordcontroller,confirmpasswordcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordcontroller=new TextEditingController();
    confirmpasswordcontroller=new TextEditingController();
  }
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
          CustomUiWidgets. updatepasswordscreen_header(context),
          updatepasswordscreen_bodypart(context),
        ],),

      );

    }

  }

  updatepasswordscreen_bodypart(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child: Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,

          margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
          child:
          Text('ENTER A NEW PASSWORD',style: TextStyle(fontFamily: 'Doomsday',color:Colors.black,fontSize: 16,),),


        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextField(
            obscureText: true,
            style: TextStyle(fontFamily: 'Doomsday'),
            controller: passwordcontroller,
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
          Text('VERIFY PASSWORD',style: TextStyle(fontFamily: 'Doomsday',color:Colors.black,fontSize: 16,),),


        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextField(
            obscureText: true,
            style: TextStyle(fontFamily: 'Doomsday'),
            controller: confirmpasswordcontroller,
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

            shape:   CustomUiWidgets.basicgreen_buttonshape(),
            onPressed:(){
              String password=passwordcontroller.text.toString();
              String confirmpassword=confirmpasswordcontroller.text.toString();
              if(password.isEmpty||password==null||password.length<6){
                CommonUtills.errortoast(context, 'please enter correct password');
              }
              else if(password!=confirmpassword){
                CommonUtills.errortoast(context, 'Password not matched');

              }
              else{
                _updatemypassword();
              }


            },
            child: Text('Change Password',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
          ),),
      ],),

    );

  }

  void _updatemypassword() async{

    try{
      CommonUtills.showprogressdialogcomplete(context, true);
      ForgotPasswordApi _forgotpasswordfapi = new ForgotPasswordApi() ;
      CommonModels results=await _forgotpasswordfapi.search(widget.mobilenumber, passwordcontroller.text.toString());
      if(results.status=="true"){
            CommonUtills.showprogressdialogcomplete(context, false);
            CommonUtills.successtoast(context, "Password change successfully, please login again");
       }
      else{
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.errortoast(context,results.message);
      }


    }
    catch(e)
    {
      print(e);
      CommonUtills.showprogressdialogcomplete(context, false);
      CommonUtills.errortoast(context, e.toString());
    }

  }}