import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/api/cancelrequestapi.dart';
import 'package:upaychat/api/pendingrequestapi.dart';
import 'package:upaychat/api/requestpayapi.dart';
import 'package:upaychat/models/common_models.dart';
import 'package:upaychat/models/pendingrequestmodels.dart';

class RequestPaymentFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RequestPaymentFileState();
  }
}
class RequestPaymentFileState extends State<RequestPaymentFile> {
  List<PendingRequestData> pendingrequest;
  bool isloaded=false;
  bool isdata=false;
  String userid;
  bool isprivacypublic = true;
  bool isprivacyfriends = false;
  bool isisprivacyprivate= false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pendingrequest=new List();
    userid=(PrefrencesManager.getInt(StringMessage.id)).toString();
    _callapiforpendingfile();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:


        isloaded==true?   Container(
          height: double.infinity,
            color: MyColors.base_green_color_20,
            child: isdata==true?ListView.builder(
                itemCount:pendingrequest.length
                ,
                shrinkWrap: true,

                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  return Container(height:120,margin: EdgeInsets.only(top: 5,bottom: 5,left: 4,right: 4,),
                    child: Row(children: <Widget>[
                      Expanded(flex:1,child: Container(

                          margin: EdgeInsets.only(top: 15),
                          height:50,
                          width: 45,
                          decoration: new BoxDecoration(
                            color: Colors.white,


                            borderRadius:
                            new BorderRadius.all(const Radius.circular(40.0)),
                          ),
                          child:ClipRRect(
                              borderRadius: new BorderRadius.circular(40.0),
                              child:

                              FadeInImage(
                                height:50,
                                width: 45,
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    pendingrequest[index].to_userimage),
                                placeholder: AssetImage(
                                    CustomImages.default_profilepic),)))
                        ,),
                      Expanded(flex:5,child: Card(elevation: 2,color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.only(top: 5,bottom: 5,left: 2,right: 2),
                          child: (Row(children: <Widget>[

                            Expanded(flex:1,child: Container(alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 15,right: 15),
                                child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.start,children: <Widget>[
                                  /*Text.rich(
                      TextSpan(
                        text: "Roise 100 ",
                        style: TextStyle(fontSize:14,color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'charged ',
                              style: TextStyle(
                                  fontSize:14,color: MyColors.grey_color
                              )),
                          TextSpan(
                              text: "Hayle06 ",
                              style: TextStyle(
                                  fontSize:14,color: Colors.black
                              )),

                          // can add more TextSpans here...
                        ],
                      ),


                    ),*/
                                  Text(pendingrequest[index].message,style: TextStyle(fontFamily: 'Doomsday',fontSize:14,color: Colors.black)),
                                  SizedBox(height: 3,),
                                  Text(pendingrequest[index].caption,style: TextStyle(fontFamily: 'Doomsday',fontSize:12,color: MyColors.grey_color)),
                                  SizedBox(height: 3,),
                                  Row(children: <Widget>[
                                    Expanded(child:
                                    Text(CustomUiWidgets.timesagofeacture(pendingrequest[index].timestamp),style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 10),)),
                                    Expanded( child: Text(StringMessage.dollar+pendingrequest[index].amount,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.end,),),
                                  ],),
                                  SizedBox(height: 5,),

                                  Row(children: <Widget>[


                                    Expanded(child: Container(
                                      width:double.infinity,
                                      margin: EdgeInsets.only(left:4,right: 4,top: 00),
                                      child:  FlatButton(
                                        textColor: Colors.white,
                                        highlightColor: MyColors.base_green_color_20,
                                        padding: EdgeInsets.only(top:4,bottom: 4),
                                        splashColor: MyColors.base_green_color,
                                        color:MyColors.base_green_color_20,
                                        disabledColor: MyColors.base_green_color_20,

                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color:MyColors.light_grey_divider_color,width: 2,),

                                          borderRadius:     BorderRadius.circular(8.0),
                                        ),
                                        onPressed:(){
                                          _callapiforcancel(pendingrequest[index],index);

                                        },
                                        child: Text('cancel',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: MyColors.base_green_color),),
                                      ),)),
                                    (userid==pendingrequest[index].touser_id )? Expanded(child:    Container(
                                      width:double.infinity,
                                      margin: EdgeInsets.only(left: 4,right: 4),
                                      child:   FlatButton(
                                        textColor: Colors.white,
                                        highlightColor: MyColors.base_green_color_20,
                                        padding: EdgeInsets.only(top: 4,bottom: 4),
                                        splashColor: MyColors.base_green_color_20,
                                        color:MyColors.base_green_color,
                                        disabledColor: MyColors.base_green_color,

                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color:MyColors.base_green_color),
                                          borderRadius:     BorderRadius.circular(8.0),
                                        ),
                                        onPressed:(){

                                          _open_privacydialogbox(pendingrequest[index],index);

                                        },
                                        child: Text('Pay',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
                                      ),)):SizedBox(),



                                  ],),

                                ],)),)

                          ],)),

                        ),

                      )),
                    ],),
                  );}):Container(child: Center(child: Text('NO Request Found',style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 18,fontWeight: FontWeight.bold),),))):Container(child: Center(child: CommonUtills.progressdialogbox(),))
    );
  }

  void _callapiforpendingfile() async {

    try{
      PendingRequestApi _reuqestapi= new PendingRequestApi();
      PendingRequestModels results= await _reuqestapi.search();
      if(results.status=="true"){
        if(results.pendingrequestlist.length>0){
          pendingrequest=results.pendingrequestlist;
          setState(() {
            isloaded=true;
            isdata=true;
          });
        }
        else{
          setState(() {
            isloaded=true;
            isdata=false;
          });
        }

      }
      else{
        CommonUtills.errortoast(context, results.message);
        Navigator.of(context).pop();
      }


    }
    catch(e)
    {
      print(e);
      CommonUtills.showprogressdialogcomplete(context, false);
      CommonUtills.errortoast(context, e.toString());
    }

  }

  void _callapiforcancel(PendingRequestData listdata, int index) async
  {
    try
    {
      CommonUtills.showprogressdialogcomplete(context, true);
      cancelRequestApi _cancelrequestapi =new cancelRequestApi();
      CommonModels results=await _cancelrequestapi.search(listdata.id.toString());
      if(results.status=="true"){
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.successtoast(context,results.message);
        setState(() {
          pendingrequest.removeAt(index);
        });
      }
      else{
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.errortoast(context,results.message);
      }


    }catch(e)
    {
      print(e);
      CommonUtills.showprogressdialogcomplete(context, false);
      CommonUtills.errortoast(context, e.toString());
    }

  }

  void _callapiforpay(PendingRequestData listdata, int index,String privacy) async
  {
    try
    {
      CommonUtills.showprogressdialogcomplete(context, true);
      RequestforPayapi _requestrequestapi =new RequestforPayapi();
      CommonModels results=await _requestrequestapi.search(listdata.id.toString(),privacy,listdata.message);
      if(results.status=="true"){
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.successtoast(context,results.message);
        setState(() {
          pendingrequest.removeAt(index);
        });
      }
      else{
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.errortoast(context,results.message);
      }


    }catch(e)
    {
      print(e);
      CommonUtills.showprogressdialogcomplete(context, false);
      CommonUtills.errortoast(context, e.toString());
    }
  }
  void _open_privacydialogbox(PendingRequestData listdata, int index) {
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
                        height: 300.0,
                        width:250,
                        child: Container(
                          height: 300,
                          width: 250,
                          child: SizedBox.expand(
                              child: Column(children: <Widget>[

                                SizedBox(height: 8,),
                                Row(children: <Widget>[
                                  Expanded(flex:1,child:
                                  Text("Cancel",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,fontSize: 14,color: MyColors.base_green_color,fontWeight: FontWeight.bold),)),

                                  Expanded(flex:2,child:Text("Who can See this ?",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: MyColors.grey_color,fontSize: 10),)),
                                  Expanded(flex:1,child:Container()),

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
                                              Text("public",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                              Text("Visible to everyone on the internet",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
                                            ],)

                                      )),
                                      isprivacypublic==true? Expanded(

                                          child:

                                          Align( alignment: Alignment.centerRight,child:
                                          Image.asset(CustomImages.selected_single_tick,height: 20,width: 20,))):Expanded(child: Container(),),


                                    ],)),
                                    SizedBox(height: 10,),
                                    InkWell(onTap: (){
                                      setState(() {
                                        isprivacypublic=false;
                                        isprivacyfriends=true;
                                        isisprivacyprivate=false;

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
                                                  Text("Friends",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text("Visible to sender ,receipent, and their Upaychat friends only",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
                                                ],)

                                          )),
                                          isprivacyfriends==true? Expanded(

                                              child:

                                              Align( alignment: Alignment.centerRight,child:
                                              Image.asset(CustomImages.selected_single_tick,height: 20,width: 20,))):Expanded(child: Container(),),


                                        ],)),
                                    SizedBox(height: 10,),
                                    InkWell(
                                        onTap: (){setState(() {
                                          isprivacypublic=false;
                                          isisprivacyprivate=true;
                                          isprivacyfriends=false;
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
                                                  Text("Private",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text("Visible to sender and receipent only",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color:MyColors.grey_color,fontSize:8),)
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
                                            Navigator.of(context).pop();
                                            _callapiforpay( listdata,  index,"friends");
                                          }
                                          else
                                          if(isisprivacyprivate){
                                            Navigator.of(context).pop();
                                            _callapiforpay( listdata,  index,"private");
                                          }
                                          else{
                                            Navigator.of(context).pop();
                                            _callapiforpay( listdata,  index,"public");
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
}