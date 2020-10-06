import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/api/banklistapi.dart';
import 'package:upaychat/models/banklistmodels.dart';

import 'add_card_file.dart';

class BankListFile extends StatefulWidget{
  @override
  createState() {
    // TODO: implement createState
    return BankListFileState();
  }}

class BankListFileState extends State<BankListFile>{
  bool isloaded=false;
  bool showmsg=false;
  List<BankDetailData> banklist;
  String msg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    banklist=new List();
    _callbanklistapi();
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

    ));
  }

  _body(BuildContext context) {
    return Container(child: Column(
      children: <Widget>[
       banklistheader(context),
        banklistcreen_boady(context),

      ],
    ));
  }

  banklistheader(BuildContext context) {
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: MediaQuery.of(context).size.width,height: 100,

      child:Row(children: <Widget>[
        Expanded(flex: 1,
          child: Container(
            width:double.infinity,
            alignment: Alignment.bottomLeft,
            child:   FlatButton(
              textColor: Colors.white,
              highlightColor: MyColors.base_green_color_20,
              padding: EdgeInsets.only(top: 15,bottom:0),
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
              child:FlatButton(
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
                child: Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Doomsday'),),
              ),
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
              child: Text('Your Banks',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Doomsday'),),
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCardFile(

                from: 'add',
              ))).then((data){
                  if(data!=null){
                    _callbanklistapi();
                  }

              });
            },
            child: Text('Add Bank',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Doomsday'),),),
          ),

        ),

      ],),);
  }

  banklistcreen_boady(BuildContext context) {
    return Container( child: isloaded==true? Container(

      margin: EdgeInsets.only(top: 10,left: 8,right: 8),
      child:
      showmsg==false? ListView.builder(
          itemCount: banklist.length
          ,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
            return Column(children: <Widget>[
              Container(
                color: Colors.white,
                child:  InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCardFile(
                  bankdata: banklist[index],
                    from: 'edit',
                  ))).then((data){
                    if(data!=null){
                      _callbanklistapi();
                    }

                  });

                }, child:Container(width: double.infinity
                    ,
                    padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColors.grey_color,width: 1.0)
                    ),
                    child:  Row(children: <Widget>[


                      Expanded(flex:10,child:
                      Align( alignment: Alignment.topLeft,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(banklist[index].account_no,textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Doomsday'),),
                              SizedBox(height: 2,),
                              Text(banklist[index].bank_name,textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize:14,fontFamily: 'Doomsday'),),
                              SizedBox(height: 2,),
                              Row(children: <Widget>[
                                Expanded(child:Text(banklist[index].account_holder_name,textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Doomsday'),),),
                                 ],)
                            ],)

                      )),
                      Expanded(

                          child:

                          Align( alignment: Alignment.centerLeft,child:
                          Container(margin: EdgeInsets.only(top: 0),
                              height:25.0,
                              width: 30.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,


                                borderRadius:
                                new BorderRadius.all(const Radius.circular(80.0)),
                              ),
                              child:Image.asset(CustomImages.brown_forward,height: 25,width: 20,)))),


                    ],))),
              ),
              Container(color: MyColors.light_grey_divider_color,height: 1,),

            ],);
          }):   Text(msg,textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
    ):Center(child:Container(child: CommonUtills.progressdialogbox())));
  }

  void _callbanklistapi() async{
     try{
       setState(() {
         banklist.clear();
         isloaded=false;
         showmsg=false;
       });
           BankListApi _banklistapi=new BankListApi();
           BankListModels results= await _banklistapi.search();
           if(results.status=="true"){
             if(results.banklist.length>0){
               banklist=results.banklist;
             }
             else{
               setState(() {
                 showmsg=true;
                 msg="No data found";
               });
             }
             setState(() {
               isloaded=true;
             });


           }
           else{
                    setState(() {
                      isloaded=true;
                      showmsg=true;
                      msg=results.message;
                    });
           }



     }
    catch(e)
    {
      print(e);
    }
  }
}