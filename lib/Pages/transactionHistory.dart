import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/payment_list_file.dart';
import 'package:upaychat/Pages/request_payment_file.dart';
import 'package:upaychat/api/pendingrequestapi.dart';
import 'package:upaychat/api/transcationrequesthistoryapi.dart';
import 'package:upaychat/models/pendingrequestmodels.dart';
import 'package:upaychat/models/transcationmodels.dart';

class TransactionHistory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransactionHistoryState();
  }
}
class TransactionHistoryState extends State<TransactionHistory> with SingleTickerProviderStateMixin {
  bool isloaded=false;
  bool isdata=false;
  String msg;
  List<Transcationdata> transcationlist;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _callapiforpendingfile();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
        length: 2,
        child:  Scaffold(
          appBar: new AppBar(backgroundColor: MyColors.base_green_color,
            title: new Text("Transaction History",style: TextStyle(fontFamily: 'Doomsday',color: Colors.white),textAlign: TextAlign.center,),

          ),
          body: Container(
            color: MyColors.base_green_color_20,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:   Flexible(child:Container(
                margin:  EdgeInsets.only(top: 2,bottom: 10,left: 5,right: 5),
                child: isloaded==true? Container(padding: EdgeInsets.only(top: 3,bottom: 3,left: 2,right: 2),
                    child:
                    isloaded==true&&isdata==true?  ListView.builder(
                        itemCount:transcationlist.length,
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
                            Align( alignment: Alignment.topLeft,child:Text(transcationlist[index].message,textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 16),))),

                          ],),
                            Container(alignment: Alignment.centerRight,child: Text(CustomUiWidgets.timesagofeacture(transcationlist[index].timestamp),textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontSize: 12),),)
                          ],));}):Text(msg,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 16),)






                ):Container(child:  CommonUtills.progressdialogbox()))),)//TransactionData(),

          ),);
  }

  void _callapiforpendingfile() async {

    try{
      TransactionHistoryRequestApi _reuqestapi= new TransactionHistoryRequestApi();
      transcationsModels results= await _reuqestapi.search();
      if(results.status=="true"){
        if(results.transcationdata.length>0){
          transcationlist=results.transcationdata;
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

}

