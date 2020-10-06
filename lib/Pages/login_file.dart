import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Validationandapi/loginvalidation_api.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';

class LoginFile extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginFileState();
  }
}
class LoginFileState extends State<LoginFile>
{
  bool _obscureText = true;
  TextEditingController emailcontroller= TextEditingController();
  TextEditingController passwordcontroller= TextEditingController();
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

    );
  }

  _body(BuildContext context) {


    String _password;
    return Container(
      child: Column(
        children: <Widget>[
          CustomUiWidgets.loginscreen_header(context),


          // Toggles the password show status

          Container(
            margin: EdgeInsets.only(top: 10,left: 8,right: 8),
            child: Column(children: <Widget>[
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
                child: TextFormField(
                  cursorColor: MyColors.base_green_color,
                  controller: emailcontroller,
                  style: TextStyle(fontFamily: 'Doomsday'),
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
                margin: EdgeInsets.fromLTRB(10, 6, 10, 0),
                child: TextFormField(
                  obscureText: _obscureText,

                  style: TextStyle(fontFamily: 'Doomsday'),
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
                        setState(() {

                          _obscureText = !_obscureText;
                        });
                      },
                      icon:_obscureText==true? Icon(Icons.remove_red_eye,color: MyColors.grey_color,):Icon(Icons.remove_red_eye,color: MyColors.base_green_color,),
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
                    child: Text('Forgot your password ?',style: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color,fontSize: 16),)
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

                  shape:  CustomUiWidgets.basicgreen_buttonshape(),
                  onPressed:(){
                    LoginValidationApi.login(context,emailcontroller,passwordcontroller);

                    //Navigator.of(context).pushNamed('/home');
                  },
                  child: Text('Login',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
                ),),
            ],),

          )
        ],
      ),

    );

  }
}