import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/Pages/all_done_file.dart';
import 'package:upaychat/api/payapi.dart';
import 'package:upaychat/models/common_models.dart';
import 'package:upaychat/Pages/payment_requestfile.dart';
class PaymentRequestFile extends StatefulWidget{
  final int userid;
  final String username;
  const  PaymentRequestFile({Key key,this.username,this.userid}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentRequestFileState();
  }
}

class PaymentRequestFileState extends State<PaymentRequestFile>
{
  bool isGeneratingCode = false;
  bool isprivacypublic = true;
  bool isprivacyfriends = false;
  bool isisprivacyprivate= false;

  TextEditingController amountcontroller,descriptioncontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountcontroller=new TextEditingController();
    descriptioncontroller=new TextEditingController();
    setState(() {
      if(PrefrencesManager.getString(StringMessage.defaultprivacy)=="public"){
        setState(() {
          isprivacypublic=true;
          isprivacyfriends=false;
          isisprivacyprivate=false;
        });
      }
      else if(PrefrencesManager.getString(StringMessage.defaultprivacy)=='friends'){
        isprivacypublic=false;
        isprivacyfriends=true;
        isisprivacyprivate=false;
      }
      else {
        isprivacypublic=false;
        isprivacyfriends=false;
        isisprivacyprivate=true;
      }
    });


  }
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
          CustomUiWidgets.paymentrequestscreen_header(context),
          paymentrequestscreen_bodypart(context),
        ],
      ),

    );
  }
  paymentrequestscreen_bodypart(BuildContext context){
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
padding: EdgeInsets.only(left: 8,right: 3),
                child:Row(children: <Widget>[

                  Expanded(flex:4,child:Text(widget.username,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color),)),
                  Expanded( flex:1,child:Row(children:<Widget> [Text(StringMessage.dollar,style: TextStyle(fontSize: 16,fontFamily: 'Doomsday',color: Colors.black)
                    ,),Expanded(child:  TextFormField(
                    textAlign: TextAlign.center,
                    cursorColor: MyColors.base_green_color,
                    controller: amountcontroller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontFamily: 'Doomsday'),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,

                      hintText: "0",

                    ),
                  ),)],)),])
            ),
            Container(  color: MyColors.light_grey_divider_color,height: 2,),
            SizedBox(height: 5,),
            Container(color: MyColors.light_grey_divider_color,height: 2,),
            Container(height:height/1.8 ,color: Colors.white,width: double.infinity,padding: EdgeInsets.only(left: 3,right: 3),
              child: TextFormField(
                cursorColor: MyColors.base_green_color,
                textAlign: TextAlign.start,
                style: TextStyle(fontFamily: 'Doomsday'),
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
                controller: descriptioncontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  hintText: ' Whtas is it for ?',

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
                  Text(PrefrencesManager.getString(StringMessage.defaultprivacy),style:TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color),),
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
                            if(amountcontroller.text.isEmpty||amountcontroller.text==null){
                              CommonUtills.errortoast(context,StringMessage.enter_amount);
                            }
                            else if(descriptioncontroller.text.isEmpty||descriptioncontroller.text==null){
                              CommonUtills.errortoast(context,'whats is it for ?');

                            }
                            else{
                              _open_privacydialogbox();
                            }
                          },
                          child: Text('Confirm Request',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),),

                    ),




                  ],)


              )

            ],)),



          ]),

    );

  }

  void _open_privacydialogbox() {
    showDialog(
        context: context,
        builder: (context) {

          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,

              child:StatefulBuilder(  // You need this, notice the parameters below:
                  builder: (BuildContext context, StateSetter setState) {
                    return //this right here
                      Container(
                        height: 350.0,
                        width:250,
                        child: Container(
                          height: 350,
                          width: 250,
                          padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                          child: SizedBox.expand(
                              child: Column(children: <Widget>[

                                SizedBox(height: 8,),
                                Row(children: <Widget>[

                                  Expanded(flex:1,child:Text("Who can See this ?",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color:Colors.black,fontSize:14,fontWeight: FontWeight.bold),)),

                                ],),
                                SizedBox(height: 15,),

                                Container(alignment: Alignment.center,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                                    SizedBox(height: 10,),
                                    InkWell(onTap: (){
                                      setState(() {
                                        isprivacypublic=true;
                                        isisprivacyprivate=false;
                                        isprivacyfriends=false;
                                        PrefrencesManager.setString(StringMessage.defaultprivacy,'public');
                                      });


                                    },child:  Row(children: <Widget>[
                                      Expanded(

                                          child:

                                          Align( alignment: Alignment.centerLeft,child:
                                          Image.asset(CustomImages.selected_globe,height: 20,width: 20,))),

                                      Expanded(flex:6,child:
                                      Align( alignment: Alignment.centerLeft,
                                          child:
                                          /* InkWell(onTap: (){
                              _callpaymentgateway(context,'public');
                            },child:*/
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text("public",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 15),),
                                              Text("Visible to everyone on the internet",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: Colors.black45,fontSize:8),)
                                            ],)

                                      )),
                                      isprivacypublic==true? Expanded(

                                          child:

                                          Align( alignment: Alignment.centerRight,child:
                                          Image.asset(CustomImages.selected_single_tick,height: 20,width: 20,))):Expanded(child: Container(),),


                                    ],)),
                                    SizedBox(height: 10,),
                                    DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.0,
                                      dashLength: 4.0,
                                      dashColor: Colors.black,
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                    SizedBox(height: 10,),
                                    InkWell(onTap: (){
                                      setState(() {
                                        isprivacypublic=false;
                                        isprivacyfriends=true;
                                        isisprivacyprivate=false;
                                        PrefrencesManager.setString(StringMessage.defaultprivacy,'friends');

                                      });},
                                        child:   Row(children: <Widget>[
                                          Expanded(

                                              child:

                                              Align( alignment: Alignment.centerLeft,child:
                                              Image.asset(CustomImages.friends,height: 30,width: 30,))),

                                          Expanded(flex:6,child:
                                          Align( alignment: Alignment.topLeft,
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("Friends",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text("Visible to sender ,receipent, and their Upaychat friends only",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: Colors.black45,fontSize:8),)
                                                ],)

                                          )),
                                          isprivacyfriends==true? Expanded(

                                              child:

                                              Align( alignment: Alignment.centerRight,child:
                                              Image.asset(CustomImages.selected_single_tick,height: 20,width: 20,))):Expanded(child: Container(),),


                                        ],)),
                                    SizedBox(height: 10,),
                                    DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.0,
                                      dashLength: 4.0,
                                      dashColor: Colors.black,
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                    SizedBox(height: 10,),
                                    InkWell(
                                        onTap: (){setState(() {
                                          isprivacypublic=false;
                                          isisprivacyprivate=true;
                                          isprivacyfriends=false;
                                          PrefrencesManager.setString(StringMessage.defaultprivacy,'private');
                                        });},
                                        child:   Row(children: <Widget>[
                                          Expanded(

                                              child:

                                              Align( alignment: Alignment.centerLeft,child:
                                              Image.asset(CustomImages.green_lock,height: 20,width: 20,))),

                                          Expanded(flex:6,child:
                                          Align( alignment: Alignment.topLeft,
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("Private",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text("Visible to sender and receipent only",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: Colors.black45,fontSize:8),)
                                                ],)

                                          )),
                                          isisprivacyprivate==true? Expanded(

                                              child:

                                              Align( alignment: Alignment.centerRight,child:
                                              Image.asset(CustomImages.selected_single_tick,height: 20,width: 20,))):Expanded(child: Container(),),


                                        ],)),
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
                                          if(isprivacyfriends){
                                            _callapiforpay("friends");
                                          }
                                          else
                                          if(isisprivacyprivate){
                                            _callapiforpay("private");
                                          }
                                          else{
                                            _callapiforpay("public");
                                          }

                                        },
                                        child: Text('Confirm',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
                                      ),),
                                  ],),)



                              ],)),
                          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),





                      );}));

        });}

  void _callapiforpay(String privacy) async {
    Navigator.of(context).pop();
    try{
      CommonUtills.showprogressdialogcomplete(context, true);
      PayApirequest _payapi=new PayApirequest();
      CommonModels result=await _payapi.search(amountcontroller.text.toString(), privacy, descriptioncontroller.text.toString(), widget.userid.toString(),'request');
      if(result.status=="true"){
        CommonUtills.showprogressdialogcomplete(context, false);
        Navigator.of(context).pop();

        String msg='You requested  ${'\$'+amountcontroller.text.toString()} \n from ${widget.username}';
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AllDoneFile(
          msg: msg,
        )));
        //   Navigator.of(context).pushNamed("/alldone");
      }
      else{
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.errortoast(context, result.message);
      }

    }
    catch(e){
      print(e);
      CommonUtills.showprogressdialogcomplete(context, false);
      CommonUtills.errortoast(context, e.toString());
    }




  }}
