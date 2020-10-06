import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/api/addupdatebankdetail.dart';
import 'package:upaychat/models/banklistmodels.dart';
import 'package:upaychat/models/common_models.dart';

class AddCardFile extends StatefulWidget {
  final String from;
  final BankDetailData bankdata;
  const  AddCardFile({Key key,this.from,this.bankdata}):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddCardFileState();
  }
}

class AddCardFileState extends State<AddCardFile>
{
  TextEditingController banknamecontroller,accountholdernamecontroller,accountnumbercontroller,confirmaccountnumbercontroller;
  String status="Continue";
  String msg="Add a bank";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    banknamecontroller=new TextEditingController();
    accountholdernamecontroller=new TextEditingController();
    accountnumbercontroller=new TextEditingController();
    confirmaccountnumbercontroller=new TextEditingController();
    if(widget.from=='edit'){
      setState(() {
        banknamecontroller.text=widget.bankdata.bank_name;
        accountholdernamecontroller.text=widget.bankdata.account_holder_name;
        accountnumbercontroller.text=widget.bankdata.account_no;
        confirmaccountnumbercontroller.text=widget.bankdata.account_no;
        status="Update";
        msg="Update bank detail";
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(
      color: MyColors.base_green_color_20,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _body(context)),

    ),);
  }


  _body(BuildContext context) {
    return Container(child: Column(
      children: <Widget>[
        CustomUiWidgets.addcardcreen_header(context),
        Container(
            margin:  EdgeInsets.only(left: 20,right:20),
            child:Container(margin: EdgeInsets.only(top: 20,bottom: 10,left: 5,right: 5),
              child:
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:Column(children: <Widget>[
                    Image.asset(CustomImages.green_lock,height: 80,width: 65,),
                    SizedBox(height: 10,),
                    Text(msg,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 16,fontFamily: 'Doomsday'),),
                    SizedBox(height: 10,),
                    Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(0, 00, 0, 0),
                      child: TextFormField(
                        cursorColor: MyColors.base_green_color,
                        controller: banknamecontroller,
                        style: TextStyle(fontFamily: 'Doomsday'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(3.0)),),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          ),

                          hintText: 'Bank Name',

                        ),
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(0, 00, 0, 0),
                      child: TextFormField(
                        cursorColor: MyColors.base_green_color,
                        controller: accountholdernamecontroller,
                        style: TextStyle(fontFamily: 'Doomsday'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(3.0)),),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          ),

                          hintText: 'Account Holder Name',

                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(0, 00, 0, 0),
                      child: TextFormField(
                        cursorColor: MyColors.base_green_color,
                        controller: accountnumbercontroller,
                        style: TextStyle(fontFamily: 'Doomsday'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(3.0)),),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          ),

                          hintText: 'Account Number',

                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(0, 00, 00, 0),
                      child: TextFormField(
                        cursorColor: MyColors.base_green_color,
                        controller: confirmaccountnumbercontroller,
                        style: TextStyle(fontFamily: 'Doomsday'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(3.0)),),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          ),

                          hintText: 'Confirm Account Number',

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

                        shape:  CustomUiWidgets.basicgreen_buttonshape(),
                        onPressed:(){

                          _validatefieldandaddorupdateaccount();
                        },
                        child: Text(status,style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Doomsday'),),
                      ),),

                  ],)),


            )), /*SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child:Column(
    children: <Widget>[
    SizedBox(height: 15,),
    TextFormField(
    cursorColor: MyColors.base_green_color,


    decoration: InputDecoration(fillColor: Colors.white,filled: true,
    contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 4,right: 4),
    labelText: "Card Number",

    labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 12),

    focusedBorder: OutlineInputBorder(

    borderSide: BorderSide(color:MyColors.grey_color, width: 1.0),

    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: MyColors.grey_color, width: 1.0),
    ),
    ),

    ),
    SizedBox(height: 15,),
    Container(margin: EdgeInsets.only(right: 25), child: Row(children: <Widget>[
    Expanded(flex:1,child:   TextFormField(
    cursorColor: MyColors.base_green_color,


    decoration: InputDecoration(fillColor: Colors.white,filled: true,
    contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 4,right: 4),
    labelText: "Expiration Date",

    labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 12),

    focusedBorder: OutlineInputBorder(

    borderSide: BorderSide(color:MyColors.grey_color, width: 1.0),

    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: MyColors.grey_color, width: 1.0),
    ),
    ),

    ),),

    Expanded(flex:1,child:  Container(margin: EdgeInsets.only(left: 5), child:TextFormField(
    cursorColor: MyColors.base_green_color,

    decoration: InputDecoration(fillColor: Colors.white,filled: true,
    contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 4,right: 4),
    labelText: "Security Code",

    labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 12),

    focusedBorder: OutlineInputBorder(

    borderSide: BorderSide(color:MyColors.grey_color, width: 1.0),

    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: MyColors.grey_color, width: 1.0),
    ),
    ),

    )),),
    ],)),

    SizedBox(height: 15,),
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
    //  Navigator.of(context).pushNamed('/home');
    },
    child: Text('Add',style: TextStyle(fontSize: 14,color: Colors.white),),
    ),),


    ]))),*/

      ],
    ));
  }

  void _validatefieldandaddorupdateaccount() {
    try{
      String bankname=banknamecontroller.text.toString();
      String accountholdername=accountholdernamecontroller.text.toString();
      String accountnumber=accountnumbercontroller.text.toString();
      String confirmaccountnumber=confirmaccountnumbercontroller.text.toString();
      if(bankname.isEmpty||bankname==null){
        CommonUtills.errortoast(context, "Enter bank name");
      }
      else if(accountholdername.isEmpty||accountholdername==null){
        CommonUtills.errortoast(context, "Enter account holder name");
      }
      else if(accountnumber.isEmpty||accountnumber==null){
        CommonUtills.errortoast(context, "Enter account number");
      }
      else if(confirmaccountnumber.isEmpty||confirmaccountnumber==null){
        CommonUtills.errortoast(context, "Enter confirm account number");
      }
      else if(confirmaccountnumber!=accountnumber){
        CommonUtills.errortoast(context, "Account number not matched");
      }
      else{
        if(widget.from=='edit'){
          _callapiforaddupdate('updatebank');
        }
        else{
          _callapiforaddupdate('addbank');
        }
      }


    }catch(e)
    {
      print(e);
    }

  }

  void _callapiforaddupdate(String status) async {
    try{
      CommonUtills.showprogressdialogcomplete(context, true);
      AddUpdateBankDetailApi _addbankdetail=new AddUpdateBankDetailApi();
      CommonModels _result;
      if(widget.from=="edit"){
        _result=await _addbankdetail.search(status, widget.bankdata.id.toString(), banknamecontroller.text.toString(), accountholdernamecontroller.text.toString(), accountnumbercontroller.text.toString());

      }
      else{
        _result=await _addbankdetail.search(status, '', banknamecontroller.text.toString(), accountholdernamecontroller.text.toString(), accountnumbercontroller.text.toString());

      }

      if(_result.status=="true"){
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.successtoast(context, _result.message);
        Navigator.of(context).pop('yes');

      }
      else{
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.errortoast(context, _result.message);
      }




    }
    catch(e){
      print(e);
      CommonUtills.showprogressdialogcomplete(context, false);
      CommonUtills.errortoast(context, StringMessage.networkservererror);
    }

  }
}