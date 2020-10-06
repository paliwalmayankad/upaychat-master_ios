import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/payment_list_file.dart';
import 'package:upaychat/Pages/request_payment_file.dart';

class PendingFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PendingFileState();
  }
}
class PendingFileState extends State<PendingFile> with SingleTickerProviderStateMixin {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
        length: 2,
        child:  Scaffold(
          appBar: new AppBar(backgroundColor: MyColors.base_green_color,
            title: new Text("Pending Request",style: TextStyle(fontFamily: 'Doomsday',color: Colors.white),textAlign: TextAlign.center,),

          ),
          body: Container(
            color: MyColors.base_green_color_20,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:  RequestPaymentFile(),

          ),));
  }

  _body(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[


          payrequestscreen_bodypart(context),
        ],
      ),

    );

  }
  static Container   payrequestscreen_bodypart(BuildContext context){
    bool _obscureText = true;

    String _password;

    // Toggles the password show status
    double height=MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 10,left: 0,right: 0),
      child:

      Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
            Container(color: MyColors.light_grey_divider_color,height: 2,),
            Container(
                color: Colors.white,

                child:Row(children: <Widget>[

                  Expanded(flex:4,child:Text("Gunjanar",style: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color),)),
                  Expanded( flex:1,child:TextFormField(
                    textAlign: TextAlign.center,
                    cursorColor: MyColors.base_green_color,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,

                      hintText: '&0',

                    ),
                  )),])
            ),
            Container(  color: MyColors.light_grey_divider_color,height: 2,),
            SizedBox(height: 5,),
            Container(color: MyColors.light_grey_divider_color,height: 2,),
            Container(height:height/1.8 ,color: Colors.white,width: double.infinity,
              child: TextFormField(
                cursorColor: MyColors.base_green_color,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  hintText: ' Whts it for ?',

                ),
              ),
            ),
            Container(color: MyColors.light_grey_divider_color,height: 2,),
            Container(height:height/8,child:Column(children: <Widget>[
              Container(height: 20,color: MyColors.base_green_color_20,alignment: Alignment.centerRight,child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(CustomImages.selected_globe,height: 10,width: 10,),
                  SizedBox(width: 2,),
                  Text("Public",style:TextStyle(color: MyColors.grey_color),),
                  SizedBox(width:4,),
                ],),),
              Container( height:height/11.6,width: double.infinity,color: MyColors.base_green_color,
                  child:Row(children: <Widget>[
                    Expanded(flex: 35,
                      child: Container(
                        width:double.infinity,
                        alignment: Alignment.center,
                        child:   FlatButton(
                          textColor: Colors.white,
                          highlightColor: MyColors.base_green_color_20,
                          padding: EdgeInsets.only(top: 15,bottom: 15),
                          splashColor: MyColors.base_green_color_20,
                          color:MyColors.base_green_color,
                          disabledColor: MyColors.base_green_color,

                          shape: RoundedRectangleBorder(
                            side: BorderSide(color:MyColors.base_green_color),
                            borderRadius:     BorderRadius.circular(0.0),
                          ),
                          onPressed:(){
                            Navigator.of(context).pushNamed("/paymentreq");
                          },
                          child: Text('Request',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),),

                    ),

                    Expanded(flex:1,
                        child: Container(width: 1.0,margin: EdgeInsets.only(top: 3,bottom: 3),color: MyColors.grey_color,)

                    ),
                    Expanded(flex: 35,
                      child: Container(alignment: Alignment.center,
                        width:double.infinity,

                        child:   FlatButton(
                          textColor: Colors.white,
                          highlightColor: MyColors.base_green_color_20,
                          padding: EdgeInsets.only(top: 15,bottom: 15),
                          splashColor: MyColors.base_green_color_20,
                          color:MyColors.base_green_color,
                          disabledColor: MyColors.base_green_color,

                          shape: RoundedRectangleBorder(
                            side: BorderSide(color:MyColors.base_green_color),
                            borderRadius:     BorderRadius.circular(0.0),
                          ),
                          onPressed:(){

                            _open_privacydialogbox(context);
                          },
                          child: Text('Pay',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),),

                    ),


                  ],)


              )

            ],)),



          ]),

    );

  }

  static void _open_privacydialogbox(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            child: SizedBox.expand(
                child: Column(children: <Widget>[

                  SizedBox(height: 8,),
                  Row(children: <Widget>[
                    Expanded(flex:1,child:
                    Text("Cancel",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,fontSize: 14,color: MyColors.base_green_color,fontWeight: FontWeight.bold),)),

                    Expanded(flex:2,child:Text("Who can See this ?",textAlign: TextAlign.center,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontSize: 10),)),
                    Expanded(flex:1,child:Container()),

                  ],),
                  SizedBox(height: 15,),

                  Container(alignment: Alignment.center,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                      SizedBox(height: 10,),
                      Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.centerRight,child:
                            Image.asset(CustomImages.selected_globe,height: 20,width: 20,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.centerLeft,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("public",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Visible to everyone on the internet",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
                              ],)

                        )),


                      ],),
                      SizedBox(height: 10,),
                      Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.center,child:
                            Image.asset(CustomImages.friends,height: 30,width: 30,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Friends",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Visible to sender ,receipent, and their Upaychat friends only",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
                              ],)

                        )),


                      ],),
                      SizedBox(height: 10,),
                      Row(children: <Widget>[
                        Expanded(

                            child:

                            Align( alignment: Alignment.center,child:
                            Image.asset(CustomImages.green_lock,height: 20,width: 20,))),

                        Expanded(flex:6,child:
                        Align( alignment: Alignment.topLeft,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Private",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Visible to sender and receipent only",textAlign: TextAlign.left,style: TextStyle(decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
                              ],)

                        )),


                      ],),
                      SizedBox(height: 10,),
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
                            Navigator.of(context).pushNamed('/alldone');
                          },
                          child: Text('Confirm',style: TextStyle(fontSize: 14,color: Colors.white),),
                        ),),
                    ],),)



                ],)),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0,1), end: Offset(0,0)).animate(anim),
          child: child,
        );
      },
    );
  }


}

