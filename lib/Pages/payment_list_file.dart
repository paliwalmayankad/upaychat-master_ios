import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';

class PaymentListFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentListFileState();
  }
}
class PaymentListFileState extends State<PaymentListFile>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Container(height:130,margin: EdgeInsets.only(top: 5,bottom: 5,left: 4,right: 4,),
        child: Row(children: <Widget>[
          Expanded(flex:1,child: Image.asset(CustomImages.default_profilepic,height: 45,width: 45,)
            ,),
          Expanded(flex:5,child: Card(elevation: 2,color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 5,bottom: 5,left: 2,right: 2),
              child: (Row(children: <Widget>[

                Expanded(flex:1,child: Container(alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.start,children: <Widget>[Text.rich(
                      TextSpan(
                        text: "you  ",
                        style: TextStyle(fontSize:14,color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'paid ',
                              style: TextStyle(
                                  fontSize:14,color: MyColors.grey_color
                              )),
                          TextSpan(
                              text: "Drawin ",
                              style: TextStyle(
                                  fontSize:14,color: Colors.black
                              )),

                          // can add more TextSpans here...
                        ],
                      ),


                    ),
                      SizedBox(height: 5,),
                      Text("Here for that some awesome history. ",style: TextStyle(color: MyColors.grey_color,fontSize: 10),),
                      SizedBox(height: 5,),
                      Row(children: <Widget>[
                        Expanded(child:
                        Text("1h ",style: TextStyle(color: MyColors.grey_color,fontSize: 10),)),
                        Expanded( child: Text("#3 ",style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.end,),),
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


                            },
                            child: Text('Take back',style: TextStyle(fontSize: 14,color: MyColors.base_green_color),),
                          ),)),
                        Expanded(child:    Container(
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

                            },
                            child: Text('Remind',style: TextStyle(fontSize: 14,color: Colors.white),),
                          ),)),



                      ],),

                    ],)),)

              ],)),

            ),

          )),
        ],),
      ),
    );

  }

}