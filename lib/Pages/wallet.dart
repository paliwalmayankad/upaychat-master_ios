import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:http/http.dart' as http;
import 'package:upaychat/api/add_money_to_wallet_api.dart';
import 'package:upaychat/api/withdrawamountreqapi.dart';
import 'package:upaychat/models/addmoneytowalletmodels.dart';
import 'package:upaychat/models/common_models.dart';

class Wallet extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WalletFileState();
  }
}

class WalletFileState extends State<Wallet>{
  bool isGeneratingCode = false;
  TextEditingController amountcontroller;
  double amount;
  String showamount="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountcontroller=TextEditingController();
    PaystackPlugin.initialize(
        publicKey: "pk_test_0efccd4aca53377768eb4de542044acb7fc4f780");
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold( body: Container(
      color: MyColors.base_green_color_20,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:_body(context),

    ),);
  }


  _body(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

          child:Row(children: <Widget>[
            Expanded(flex: 1,
              child: Container(
                width:double.infinity,
                alignment: Alignment.bottomCenter,
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
                    },
                    child: Row(children: <Widget>[
                      Icon(Icons.arrow_back_ios,color: Colors.white,),
                    ],)
                ),),

            ),
            Expanded(flex: 2,
              child: Container(
                width:double.infinity,
                alignment: Alignment.bottomCenter,
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
                  onPressed:(){},
                  child: Text('Wallet',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                ),),

            ),
            Expanded(
              child: Container(),

            ),

          ],),),
        Expanded(child: Container(padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
            child:SingleChildScrollView(
                scrollDirection: Axis.vertical,

                child:  Expanded(child: Column(children: <Widget>[



                  ///// Show WalletPAyment
                  Text(StringMessage.dollar+PrefrencesManager.getString(StringMessage.walletbalance),style: TextStyle(color: MyColors.base_green_color,fontSize: 30,fontWeight: FontWeight.bold),),
                  Text('(Available balance)',style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 12),),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(8, 13, 5, 0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: amountcontroller,

                      style: TextStyle(fontFamily: 'Doomsday'),
                      decoration: InputDecoration(

                        border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(5.0)),),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),

                        hintText: 'add money to wallet',

                      ),
                    ),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 25),
                    child:   FlatButton(
                      textColor: Colors.white,
                      highlightColor: MyColors.base_green_color_20,
                      padding: EdgeInsets.only(top: 15,bottom: 15,left: 60,right: 60),
                      splashColor: MyColors.base_green_color_20,
                      color:MyColors.base_green_color,
                      disabledColor: MyColors.base_green_color,

                      shape:  CustomUiWidgets.basicgreen_buttonshape(),
                      onPressed:(){
                        try {

                          if (amountcontroller.text
                              .toString()
                              .isEmpty ||
                              amountcontroller.text.toString() == null) {
                            CommonUtills.errortoast(
                                context, StringMessage.enter_amount);
                          }
                          else if (double.parse(
                              amountcontroller.text.toString()) == 0 || double.parse(
                              amountcontroller.text.toString()) < 0) {
                            CommonUtills.errortoast(
                                context, StringMessage.enter_correntamount);
                          }


                          else {
                            amount=double.parse(
                                amountcontroller.text.toString());


                            double charge=((amount*5)/100);
                            double totalamount= amount+charge;
                            if(amount>1000000){
                              CommonUtills.errortoast(context, 'you cannot add more then \$ 1000000');
                            }
                            else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return  Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)), //this right here
                                    child: Container(
                                      decoration: new BoxDecoration(
                                          color: MyColors.base_green_color_20,
                                          borderRadius: new BorderRadius.all(const Radius.circular(10))
                                      ),
                                      height: 280.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(child:Text('Amount Detail',style: TextStyle(color: MyColors.base_green_color,fontWeight: FontWeight.bold,fontSize: 18),)),
                                            SizedBox(height: 15,),
                                            Row(children: <Widget>[
                                              Expanded(flex:2,child: Text('Amount to be sent',style: TextStyle(fontFamily: 'Doomsday',color: Colors.black87,fontSize: 14,),),),
                                              Expanded(flex:1,child: Text(StringMessage.dollar+amount.toString(),style: TextStyle(fontFamily: 'Doomsday',color: Colors.black87,fontSize: 14,),),),

                                            ],),
                                            SizedBox(height: 15),
                                            Container(height: 1,color: MyColors.grey_color,),

                                            SizedBox(height: 15),
                                            Row(children: <Widget>[
                                              Expanded(flex:2,child: Text('Charge (5%)',style: TextStyle(fontFamily: 'Doomsday',color:  Colors.black87,fontSize: 14),),),
                                              Expanded(flex:1,child: Text(StringMessage.dollar+charge.toString(),style: TextStyle(color:  Colors.black87,fontSize: 14),),),


                                            ],),
                                            SizedBox(height: 15),
                                            Container(height: 1,color: MyColors.grey_color,),

                                            SizedBox(height: 15),
                                            Row(children: <Widget>[
                                              Expanded(flex:2,child: Text('Total Payment',style: TextStyle(fontFamily: 'Doomsday',color:  Colors.black87,fontSize: 14),),),
                                              Expanded(flex:1,child: Text(StringMessage.dollar+totalamount.toString(),style: TextStyle(fontFamily: 'Doomsday',color:  Colors.black87,fontSize: 14),),),


                                            ],),
                                            SizedBox(height: 15),
                                            FlatButton(
                                              textColor: Colors.white,
                                              highlightColor: MyColors.base_green_color_20,
                                              padding: EdgeInsets.only(top: 15,bottom: 15,left: 60,right: 60),
                                              splashColor: MyColors.base_green_color_20,
                                              color:MyColors.base_green_color,
                                              disabledColor: MyColors.base_green_color,

                                              shape:  CustomUiWidgets.basicgreen_buttonshape(),
                                              onPressed:(){
                                                try {



                                                  _callpaymentgateway(context, 'public',totalamount,amount);
                                                  // Navigator.of(context).pop();
                                                  //_showDialog(amount);

                                                }catch(e){
                                                  print(e);
                                                  CommonUtills.errortoast(
                                                      context, StringMessage.enter_correntamount);
                                                }
                                                //Navigator.of(context).pushNamed('/home');
                                              },
                                              child: Text('Pay',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }





                            //  _callpaymentgateway(context, 'public',amount);
                            //_showDialog(amount);
                          }
                        }catch(e){
                          print(e);
                          CommonUtills.errortoast(
                              context, StringMessage.enter_correntamount);
                        }
                        //Navigator.of(context).pushNamed('/home');
                      },
                      child: Text('Add money',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
                    ),),
                  Container(color: Colors.white,
                    margin: EdgeInsets.only(top: 15,bottom: 15,),
                    child: Column(children: <Widget>[
                      Container(width: double.infinity
                          ,
                          padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                          child:InkWell(onTap: (){
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed("/addbenificary");
                          } ,child: Row(children: <Widget>[
                            Expanded(

                                child:

                                Align( alignment: Alignment.centerLeft,child:
                                Image.asset(CustomImages.green_person,height: 30,width: 30,))),

                            Expanded(flex:6,child:
                            Align( alignment: Alignment.topLeft,child:Text("Pay",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                            Expanded(child:
                            Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                          ],))),
                      Container(color: MyColors.light_grey_divider_color,height: 1,),
                      InkWell(onTap:(){
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("/addbenificary");

                      },
                          child:(
                              Container(width: double.infinity
                                  ,
                                  padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                                  child:  Row(children: <Widget>[
                                    Expanded(

                                        child:

                                        Align( alignment: Alignment.centerLeft,child:
                                        Image.asset(CustomImages.green_card,height: 30,width: 30,))),

                                    Expanded(flex:6,child:
                                    Align( alignment: Alignment.topLeft,child:Text("Request for money",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                                    Expanded(child:
                                    Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                                  ],)))),
                      Container(color: MyColors.light_grey_divider_color,height: 1,),
                      Container(width: double.infinity
                          ,
                          padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                          child:InkWell(onTap: (){
                            createdialogforwithdraw();
                          } ,child: Row(children: <Widget>[
                            Expanded(

                                child:

                                Align( alignment: Alignment.centerLeft,child:
                                Image.asset(CustomImages.selected_bell,height: 30,width: 30,))),

                            Expanded(flex:6,child:
                            Align( alignment: Alignment.topLeft,child:Text("Withdraw Request",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 15),))),
                            Expanded(child:
                            Align( alignment: Alignment.centerRight,child: Image.asset(CustomImages.brown_forward,height: 30,width: 30,)))

                          ],))),
                      Container(color: MyColors.light_grey_divider_color,height: 1,),


                    ],),
                  ),


                ],),
                )))),


      ],
    );
  }

  _callpaymentgateway(BuildContext context, String s, double totalamount,double amount) async{

    try{
      setState(() {
        isGeneratingCode = !isGeneratingCode;
      });
      CommonUtills.showprogressdialogcomplete(context, true);
      Map accessCode = await createAccessCode(
          "sk_test_6f93086a279175bd9dc72a661c519801d808f918");

      setState(() {
        isGeneratingCode = !isGeneratingCode;
      });
      Navigator.of(context).pop();
      CommonUtills.showprogressdialogcomplete(context, false);
      Charge charge = Charge()
        ..amount = (totalamount*100).toInt()
        ..accessCode = accessCode["data"]["access_code"]..currency="USD"
        ..email = PrefrencesManager.getString(StringMessage.email);
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method:
        CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
        charge: charge,
      );
      if (response.status == true) {
        _showDialog(totalamount,response,amount);
      } else {
        _showErrorDialog();
      }


    }catch(e)
    {
      print(e);
      CommonUtills.errortoast(context,e.toString());
    }
  }
  void _showDialog(double totalamount, CheckoutResponse response,double amount) async {
    //// call api for add money to wallet
    CommonUtills.showprogressdialogcomplete(context, true);
    AddMoneyWalletApi _walletapi = new AddMoneyWalletApi();
    AddMoneytoWalletModels results = await _walletapi.search(totalamount,amount,"paystack",response.reference,"","");
    if(results.status=="true"){
      CommonUtills.showprogressdialogcomplete(context, false);
      setState(() {
        amountcontroller.text="";
        PrefrencesManager.setString(StringMessage.walletbalance, results.balance.toString());
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return successDialog(context);
        },
      );

    }
    else{
      CommonUtills.showprogressdialogcomplete(context, false);
      CommonUtills.errortoast(context,results.message);
    }



    // flutter defined function

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

  void createdialogforwithdraw() {
    TextEditingController withdrawamountcontroller=new TextEditingController();
    showDialog(
        context: context,
        builder: (context) {

          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              elevation: 0.0,
              backgroundColor: Colors.transparent,

              child:StatefulBuilder(  // You need this, notice the parameters below:
                  builder: (BuildContext context, StateSetter setState) {
                    return //this right here
                      Container(
                        height: 300.0,
                        width:250,
                        child: Container(
                          height: 300,
                          width: 250,
                          child: SizedBox.expand(
                              child: Column(children: <Widget>[

                                SizedBox(height: 15,),
                                Row(children: <Widget>[
                                  Expanded(flex:2,child:Text("Request to withdraw amount",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),)),

                                ],),
                                SizedBox(height: 15,),

                                Container(alignment: Alignment.center,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                                    SizedBox(height: 10,),
                                    Container(
                                      height: 50,
                                      color: Colors.white,
                                      margin: EdgeInsets.fromLTRB(8, 13, 5, 0),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        controller: withdrawamountcontroller,
                                        style: TextStyle(fontFamily: 'Doomsday'),

                                        decoration: InputDecoration(

                                          border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                                            borderRadius: BorderRadius.all(Radius.zero),
                                          ),

                                          hintText: 'enter amount',

                                        ),
                                      ),
                                    ),
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
                                          if(withdrawamountcontroller.text.toString().isEmpty||withdrawamountcontroller.text.toString()==null){
                                            CommonUtills.errortoast(context, "Enter amount");
                                          }

                                          else{
                                            double withdrawamountpayment=double.parse(withdrawamountcontroller.text.toString());
                                            double walletamount=double.parse(PrefrencesManager.getString(StringMessage.walletbalance));
                                            if(withdrawamountpayment>walletamount){
                                              CommonUtills.errortoast(context, "cannot not request more then wallet balance");
                                            }
                                            else{
                                              Navigator.of(context).pop();
                                              _requestforpayment(withdrawamountpayment);
                                            }
                                          }




                                        },
                                        child: Text('Confirm',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Doomsday'),),
                                      ),),
                                  ],),)



                              ],)),
                          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),





                      );}));



        });}

  void _requestforpayment(double withdrawamountpayment) async {
   try{
     CommonUtills.showprogressdialogcomplete(context, true);
     WithdrawAmountRequestApi _request = new WithdrawAmountRequestApi();
     CommonModels result=await _request.search(withdrawamountpayment.toString());
        if(result.status=="true"){
          double avlbbalance=double.parse(PrefrencesManager.getString(StringMessage.walletbalance));
          double paidpayment=withdrawamountpayment;
          setState(() {
            PrefrencesManager.setString(StringMessage.walletbalance, (avlbbalance-paidpayment).toString());

          });
           CommonUtills.showprogressdialogcomplete(context, false);
          CommonUtills.successtoast(context,result.message);
        }
        else{
          CommonUtills.showprogressdialogcomplete(context, false);
          CommonUtills.errortoast(context, result.message);
        }

   }
   catch(e){
     print(e);
     CommonUtills.showprogressdialogcomplete(context, false);
     CommonUtills.errortoast(context, StringMessage.networkservererror);
   }


  }
}