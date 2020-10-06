import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/api/cancelrequestapi.dart';
import 'package:upaychat/api/faqapi.dart';
import 'package:upaychat/models/faqmodels.dart';

class FaqFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FaqFileState();
  }
}
class FaqFileState extends State<FaqFile>{
  bool isloaded=false;
  bool isdata=false;
  String msg;
  List<FaqData> faqlist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callapilistforfaq();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: 2,
      child:  Scaffold(
          appBar: new AppBar(backgroundColor: MyColors.base_green_color,
            title: new Text("Faq's",style: TextStyle(fontFamily: 'Doomsday',color: Colors.white),textAlign: TextAlign.center,),

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
                        itemCount:faqlist.length,
                        shrinkWrap: true,

                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){

                          return Container(decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(4.0))),padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),margin:  EdgeInsets.only(top: 5,bottom: 0,left: 0,right: 0),child: Column(children: <Widget>[
                            InkWell(onTap:(){
                            setState(() {
                              if(faqlist[index].show==false){
                                faqlist[index].show=true;
                              }
                              else{
                                faqlist[index].show=false;
                              }
                            });
                          },child:Text("${faqlist[index].id.toString()}."+faqlist[index].question,textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 16),)),
                           faqlist[index].show==true? Container(margin:EdgeInsets.only(left: 10),alignment: Alignment.centerRight,child: Text("Ans: "+faqlist[index].answer,textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontSize: 12),),):SizedBox()



                          ],));}):Text(msg,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black,fontSize: 16),)






                ):Container(child:  CommonUtills.progressdialogbox()))),)//TransactionData(),

      ),);
  }


    void _callapilistforfaq() async {

      try{
        FaqApi _reuqestapi= new FaqApi();
        FaqModels results= await _reuqestapi.search();
        if(results.status=="true"){
          if(results.faqlist.length>0){
            faqlist=results.faqlist;
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