import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:upaychat/Pages/all_done_file.dart';
import 'package:upaychat/api/payapi.dart';
import 'package:upaychat/models/common_models.dart';
import 'package:upaychat/Pages/payment_requestfile.dart';

class PayorRequestFile extends StatefulWidget{
  final int userid;
  final String username;
  const  PayorRequestFile({Key key,this.username,this.userid}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PayorRequestFileState();
  }
}

class PayorRequestFileState extends State<PayorRequestFile>{
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
    PaystackPlugin.initialize(
        publicKey: "pk_test_0efccd4aca53377768eb4de542044acb7fc4f780");
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
          CustomUiWidgets.payrequestscreen_header(context),
          payrequestscreen_bodypart(context),
        ],
      ),

    );

  }
  Container   payrequestscreen_bodypart(BuildContext context){
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
padding: EdgeInsets.only(left: 6,right: 3),
                child:Row(children: <Widget>[

                  Expanded(flex:4,child:Text(widget.username,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color),)),
                  Expanded( flex:1,child:Row(children: <Widget>[Text(StringMessage.dollar,style: TextStyle(fontSize: 16,fontFamily: 'Doomsday',color: Colors.black)
                    ,),Expanded(child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Doomsday'),
                    controller: amountcontroller,
                    keyboardType: TextInputType.number,
                    cursorColor: MyColors.base_green_color,
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

                  hintText: ' Whats is it for ?',

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
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentRequestFile(
                              userid:
                              widget.userid,
                              username: widget.username,
                            )));
                          },
                          child: Text('Request',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
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
                            // //_callpaymentgateway(context,'public');

                            if(amountcontroller.text.isEmpty||amountcontroller.text==null){
                              CommonUtills.errortoast(context,StringMessage.enter_amount);
                            }
                            else if(descriptioncontroller.text.isEmpty||descriptioncontroller.text==null){
                              CommonUtills.errortoast(context,'whats it is ?');

                            }
                            else{
                              _open_privacydialogbox();
                            }},
                          child: Text('Pay',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),),

                    ),


                  ],)


              )

            ],)),



          ]),

    );

  }
  _callpaymentgateway(BuildContext context, String s) async{
    try{
      setState(() {
        isGeneratingCode = !isGeneratingCode;
      });

      Map accessCode = await createAccessCode(
          "sk_test_6f93086a279175bd9dc72a661c519801d808f918");

      setState(() {
        isGeneratingCode = !isGeneratingCode;
      });

      Charge charge = Charge()
        ..amount = 10000
        ..accessCode = accessCode["data"]["access_code"]
        ..email = 'johnsonoye34@gmail.com';
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method:
        CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
        charge: charge,
      );
      if (response.status == true) {
        _showDialog();
      } else {
        _showErrorDialog();
      }


    }catch(e)
    {
      print(e);
    }
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }
  Dialog successDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_box,
                color: hexTocolor("#41aa5e"),
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Payment has successfully',
                style: TextStyle(fontFamily: 'Doomsday',
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'been made',
                style: TextStyle(fontFamily: 'Doomsday',
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Your payment has been successfully",
                style: TextStyle(fontFamily: 'Doomsday',fontSize: 13),
              ),
              Text("processed.", style: TextStyle(fontFamily: 'Doomsday',fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Dialog errorDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Failed to process payment',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Doomsday',
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Error in processing payment, please try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Doomsday',fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  Color  hexTocolor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  createAccessCode(String skTest) async {
    // skTest -> Secret key
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $skTest'
    };
    Map data = {"amount": 600, "email": "johnsonoye34@gmail.com"};
    String payload = json.encode(data);
    http.Response response = await http.post(
        'https://api.paystack.co/transaction/initialize',
        headers: headers,
        body: payload);
    return jsonDecode(response.body);
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
      CommonModels result=await _payapi.search(amountcontroller.text.toString(), privacy, descriptioncontroller.text.toString(), widget.userid.toString(),'pay');
      if(result.status=="true"){
        CommonUtills.showprogressdialogcomplete(context, false);
        double avlbbalance=double.parse(PrefrencesManager.getString(StringMessage.walletbalance));
        double paidpayment=double.parse(amountcontroller.text.toString());
        PrefrencesManager.setString(StringMessage.walletbalance, (avlbbalance-paidpayment).toString());
        Navigator.of(context).pop();
       String msg='You sent  ${'\$'+amountcontroller.text.toString()}\n to ${widget.username}';
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AllDoneFile(
          msg: msg,
        )));
      //  Navigator.of(context).pushNamed("/alldone");
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