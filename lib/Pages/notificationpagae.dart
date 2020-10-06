import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/api/notificationapi.dart';
import 'package:upaychat/models/notificationmodels.dart';

class NotificationFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotificationState();
  }
}
class NotificationState extends State<NotificationFile>
{
  List<NotificationData> notificationlist;
  bool isloaded=false;
  bool isdata=false;
  String msg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationlist=new List();
    _callnotificationdata();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      child: Text('Notification',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                    ),),

                ),
                Expanded(
                  child: Container( padding: EdgeInsets.only(), alignment: Alignment.bottomRight,child:FlatButton(
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

                    },
                    child: Text('',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                    ),),
                  ),

                ),

              ],),),
            Flexible(child:Container(
                margin:  EdgeInsets.only(top: 2,bottom: 10,left: 5,right: 5),
                child: isloaded==true? Container(padding: EdgeInsets.only(top: 3,bottom: 3,left: 2,right: 2),
                    child:
                    isloaded==true&&isdata==true?  ListView.builder(
                        itemCount:notificationlist.length,
                        shrinkWrap: true,

                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){

                          return Container(decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(4.0))),padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),margin:  EdgeInsets.only(top: 5,bottom: 0,left: 0,right: 0),child: Column(children: <Widget>[Row(children: <Widget>[
                            /*Expanded(

                      child:

                      Align( alignment: Alignment.centerLeft,child:
                      Image.asset(CustomImages.selected_bell,height: 30,width: 30,))),*/

                            Expanded(flex:6,child:
                            Align( alignment: Alignment.topLeft,child:Text(notificationlist[index].notification,textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 16),))),

                          ],),
                            Container(alignment: Alignment.centerRight,child: Text(CustomUiWidgets.timesagofeacture(notificationlist[index].timestamp),textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontSize: 12),),)
                          ],));}):Text(msg,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 16),)






                ):Container(child:  CommonUtills.progressdialogbox()))),


          ],
        ));
  }

  void _callnotificationdata() async{

    try {
      Notificationapi _notificationapi = new Notificationapi();

      NotificationModels results = await _notificationapi.search();
      if (results.status == "true") {

        if(results.banklist.length>0){
          notificationlist=results.banklist;
          setState(() {
            isdata=true;
          });
        }
        else{
          msg="No data found";
        }
        setState(() {
          isloaded=true;
        });

      }
      else {
        setState(() {
          isloaded=true;
          msg=results.message;
        });

      }
    }catch(e)
    {
      print(e);
      CommonUtills.errortoast(context, e.toString());
      setState(() {
        isloaded=true;
        msg="No data found";
      });
    }

  }
}