import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';

class PublicTransFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PublicTransFileState();
  }
}
class PublicTransFileState extends State<PublicTransFile>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 5,bottom: 5,left: 3,right: 3),
      child: ListView.separated(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 15,
        separatorBuilder: (BuildContext context, int index) => Divider( height: 3, color: MyColors.grey_color),
        itemBuilder: (context,index){return Container(
          margin: EdgeInsets.only(top: 5,bottom: 5,left: 2,right: 2),
          child: (Row(children: <Widget>[
            Expanded(flex:1,child:  Image.asset(CustomImages.default_profilepic,height: 80,),),
            Expanded(flex:5,child: Container(alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.start,children: <Widget>[Text.rich(
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


                ),
                  SizedBox(height: 5,),
                  Row(children: <Widget>[
                    Text("1h ",style: TextStyle(color: MyColors.grey_color,fontSize: 10),),
                    Image.asset(CustomImages.unselected_globe,height: 10,width: 15,)
                  ],),
                  SizedBox(height: 5,),
                  Text("Luv ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Row(children: <Widget>[
                    Image.asset(CustomImages.unlike,height:25,width:30,),SizedBox(width: 5,),
                    Image.asset(CustomImages.comment,height: 25,width: 30,)
                  ],),

                ],)),)

          ],)),

        );},),

    );
  }
}