import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Validationandapi/registervalidation_api.dart';


class RegisterFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterFileState();
  }
}

class RegisterFileState extends State<RegisterFile>
{
  bool _obscureText = true;
  TextEditingController firstnamecontroller=TextEditingController(),lastnamecontroller=TextEditingController(),emailcontroller=TextEditingController(),passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    initState(){};
    return Scaffold(
      body: Container(
        color: MyColors.base_green_color_20,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:_body(context)),

      ),

    );
  }

  _body(BuildContext context) {
    return Container(child: Column(
      children: <Widget>[
        CustomUiWidgets.registerscreen_header(context),
        Container(
          margin: EdgeInsets.only(top: 10,left: 8,right: 8),
          child: Column(children: <Widget>[
            /// FIRST NAME
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: TextFormField(
                cursorColor: MyColors.base_green_color,
                controller: firstnamecontroller,
                style: TextStyle(fontFamily: 'Doomsday'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),

                  hintText: 'First Name',

                ),
              ),
            ),

            /// LAST NAME
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: TextFormField(
                cursorColor: MyColors.base_green_color,
                controller: lastnamecontroller,
                style: TextStyle(fontFamily: 'Doomsday'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),

                  hintText: 'Last Name',

                ),
              ),
            ),

            /// EMAIL
            Container(
              color: Colors.white,

              margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: TextFormField(
                controller: emailcontroller,
                cursorColor: MyColors.base_green_color,
                style: TextStyle(fontFamily: 'Doomsday'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),

                  hintText: 'Email',

                ),
              ),
            ),
// PASSWORD
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: TextField(
                obscureText: _obscureText,
                controller: passwordcontroller,
                style: TextStyle(fontFamily: 'Doomsday'),
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
                    style: TextStyle(fontFamily: 'Doomsday',fontSize:16,color: MyColors.grey_color),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Term of use ',
                          style: TextStyle(fontFamily: 'Doomsday',
                              decoration: TextDecoration.underline,fontSize:16,color: MyColors.grey_color
                          )),
                      TextSpan(
                          text: "and confirm that you have read Upaychat'''s ",
                          style: TextStyle(fontFamily: 'Doomsday',
                              fontSize:16,color: MyColors.grey_color
                          )),
                      TextSpan(
                          text: 'Privacy Policy.',
                          style: TextStyle(fontFamily: 'Doomsday',
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

                shape: CustomUiWidgets.basicgreen_buttonshape(),
                onPressed:(){

                  RegisterValidation.checkbasicdetailforregister(context,firstnamecontroller,lastnamecontroller,emailcontroller,passwordcontroller);

                },
                child: Text('Continue',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
              ),),
          ],),

        ),
      ],
    ));
  }
}