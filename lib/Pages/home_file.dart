import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/public_trans_file.dart';
import 'package:upaychat/api/mytranscationapi.dart';
import 'package:upaychat/api/wallet_api.dart';
import 'package:upaychat/api/mylikedislikeapi.dart';
import 'package:upaychat/api/addmycommentapi.dart';
import 'package:upaychat/models/common_models.dart';
import 'package:upaychat/models/mytransmodels.dart';
import 'package:upaychat/models/walletmodels.dart';

class HomeFile extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeFileState();
  }
}

class HomeFileState extends State<HomeFile>
{
  int _currentSelection = 0;
  int segmentedControlValue = 0;
  bool publictranspressed=true,personalpressed=false,privatepressed=false;
  static Widget Screenview;
  GlobalKey<ScaffoldState> scaffoldState= GlobalKey<ScaffoldState>();
  List<MyTransData> totaltranslist;
  List<MyTransData> publictranslist;
  List<MyTransData> privatetranslist;
  List<MyTransData> friendslist;
  bool isloading=false;
  bool isprivatedata=false;
  bool ispublicdata=false;
  bool isfriendsdata=false;
  AppLifecycleState _notification;

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Screenview=PublicTransFile();
    totaltranslist=new List();
    publictranslist=new List();
    privatetranslist=new List();
    friendslist=new List();
    _calltranscationapi();
    _callmywalletapi();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldState,
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: MyColors.base_green_color_20,
        height: double.infinity,
        width: double.infinity,
        child: _body(context),

      ),
      drawer: homenavigationdrawer(context,scaffoldState,Screenview),

    );
  }
  Container
  homenavigationdrawer(BuildContext context, GlobalKey<ScaffoldState> scaffoldState, Widget screenview){
    double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return Container(
        color: MyColors.navigation_bg_color,
        child: new Container
          (width: 230,height: double.infinity, color: MyColors.navigation_bg_color,
            child:
            Container(alignment: Alignment.topCenter,margin: EdgeInsets.only(left: 10,top:statusbarHeight ), child:
            SingleChildScrollView(scrollDirection: Axis.vertical, child:
            Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();

                  },
                  child: Container(height: 200 ,margin: EdgeInsets.only(left: 00),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                            onTap:(){
                              Navigator.of(context).pushNamed("/editprofile");

                            },
                            child: Stack(children: <Widget>[
                              Positioned(

                                  child:Container(margin: EdgeInsets.only(top: 15),
                                      height:80.0,
                                      width: 80.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,


                                        borderRadius:
                                        new BorderRadius.all(const Radius.circular(80.0)),
                                      ),
                                      child:ClipRRect(
                                        borderRadius: new BorderRadius.circular(80.0),
                                        child: FadeInImage(
                                          height: 80,
                                          width: 80,

                                          fit: BoxFit.fill,
                                          image: NetworkImage(PrefrencesManager.getString(StringMessage.profileimage)), placeholder: AssetImage(CustomImages.default_profilepic,),),))
                                // child: Image.asset(CustomImages.default_profilepic,height:80,),
                              ),
                              Positioned(bottom:0,
                                right: 0,
                                child: Image.asset(CustomImages.edit_photo,height: 20,),
                              ),

                            ],))
                        ,SizedBox(height:10,),
                        Text(PrefrencesManager.getString(StringMessage.firstname)+PrefrencesManager.getString(StringMessage.lastname),style: TextStyle(fontFamily: 'Doomsday',color: MyColors.navigation_textcolor),textAlign: TextAlign.center,),
                        SizedBox(height:3,),
                        Text(PrefrencesManager.getString(StringMessage.email),style: TextStyle(fontFamily: 'Doomsday',color: MyColors.navigation_textcolor),textAlign: TextAlign.center,),
                        SizedBox(height: 20,),
                        InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed("/wallet");
                            },
                            child:Container(margin: EdgeInsets.only(left: 3,right: 3),child:Row(children: <Widget>[
                              Expanded(flex:2,child:  Text(StringMessage.dollar+PrefrencesManager.getString(StringMessage.walletbalance),style: TextStyle(fontFamily: 'Doomsday',color: MyColors.navigation_textcolor),textAlign: TextAlign.start,),
                              ),
                              Expanded(flex:2,child:  Container(margin: EdgeInsets.only(right: 5),child:Text("Manage Balance",style: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color,fontSize: 12),textAlign: TextAlign.end,)),
                              ),
                            ],)))


                      ],),),),
                Container(height: 1,color: MyColors.grey_color,),
                SizedBox(height: 5,),

                InkWell(onTap: ()
                {
                  Navigator.of(context).pop();
                  //
                  // addState(phoneass.Home);
                },
                  child:
                  Container(child:
                  Row(  children: <Widget>[
                    Image.asset(CustomImages.selected_home,height: 30,width: 30,),
                    SizedBox(width: 10,),
                    Text('Home',style: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color,fontSize: 14),)

                  ],)),),
                Container(margin: EdgeInsets.only(top: 3,left: 40),height: 1,color: MyColors.grey_color,),
                SizedBox(height: 13,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/editprofile");
                    //addState(phoneass.profile);




                  }, child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.round_grey_user,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Profile',style: TextStyle(fontFamily: 'Doomsday',color:Colors.white,fontSize: 14),)

                ],)),),
                Container(margin: EdgeInsets.only(top: 3,left: 40),height: 1,color: MyColors.grey_color,),


                SizedBox(height: 13,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/wallet");

                  },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.grey_dollar_note,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Wallet',style: TextStyle(fontFamily: 'Doomsday',color:Colors.white,fontSize: 14),)

                ],)),),
                Container(margin: EdgeInsets.only(top: 3,left: 40),height: 1,color: MyColors.grey_color,),

                SizedBox(height: 13,),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/transaction");

                  },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.grey_dollar_note,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Transaction History',style: TextStyle(fontFamily: 'Doomsday',color:Colors.white,fontSize: 14),)

                ],)),),
                Container(margin: EdgeInsets.only(top: 3,left: 40),height: 1,color: MyColors.grey_color,),

                SizedBox(height: 13,),
                InkWell(
                  onTap: (){
                    // addState(phoneass.message);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/addbenificary").then((value) {
                      _calltranscationapi();
                    });;
                  },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.unselected_search,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Search People',style: TextStyle(fontFamily: 'Doomsday',color:Colors.white,fontSize: 14),)

                ],)),),
                Container(margin: EdgeInsets.only(top: 3,left: 40),height: 1,color: MyColors.grey_color,),

                SizedBox(height: 13,),
                InkWell(onTap: (){
                  //  addState(phoneass.communities);
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/notification");
                },child: Container(child:Row( children: <Widget>[
                  Image.asset(CustomImages.unselected_bell,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Notification',style: TextStyle(fontFamily: 'Doomsday',color: Colors.white,fontSize: 14),)

                ],)),),
                Container(margin: EdgeInsets.only(top: 3,left: 40),height: 1,color: MyColors.grey_color,),

                SizedBox(height: 13,),
                InkWell(onTap: (){
                  Navigator.of(context).pop();

                  Navigator.of(context).pushNamed("/pending");
                  //addState(phoneass.bookmarks);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.unselected_timer_for_wallet,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Pending',style: TextStyle(fontFamily: 'Doomsday',color: Colors.white,fontSize: 14),)

                ],)),),
                Container(margin: EdgeInsets.only(top: 3,left: 40),height: 1,color: MyColors.grey_color,),

                SizedBox(height: 13,),
                InkWell(onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/setting");
                  // addState(phoneass.workout);
                },child: Container(child:Row(  children: <Widget>[
                  Image.asset(CustomImages.unselected_setting,height: 30,width: 30,),
                  SizedBox(width: 10,),
                  Text('Setting & Help',style: TextStyle(fontFamily: 'Doomsday',color: Colors.white,fontSize: 14),)

                ],)),),
                Container(margin: EdgeInsets.only(top: 3,left: 40),height: 1,color: MyColors.grey_color,),







              ],
            ),
            ) ,)));
  }
  _body(BuildContext context) {
    return Container(
        child:Column(children: <Widget>[
          _createmyheader(context),
          isloading==true?
          Expanded(flex:1,child:  SingleChildScrollView(

              child:Column(children: <Widget>[
                publictranspressed==true? Container(
                  margin: EdgeInsets.only(top: 5,bottom: 5,left: 3,right: 3),
                  child: isloading==true&&ispublicdata==true? ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: publictranslist.length,
                    separatorBuilder: (BuildContext context, int index) => Divider( height: 3, color: MyColors.grey_color),
                    itemBuilder: (context,index){

                      return Container(
                        margin: EdgeInsets.only(top: 5,bottom: 5,left: 2,right: 2),
                        child: (Row(children: <Widget>[
                          Container(

                              margin: EdgeInsets.only(top: 15),
                              height:55.0,
                              width: 55.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,


                                borderRadius:
                                new BorderRadius.all(const Radius.circular(80.0)),
                              ),
                              child:ClipRRect(
                                  borderRadius: new BorderRadius.circular(80.0),
                                  child:

                                  FadeInImage(
                                    height:55.0,
                                    width: 55.0,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        publictranslist[index].to_userimage),
                                    placeholder: AssetImage(
                                        CustomImages.default_profilepic),))),
                          Expanded(flex: 1,child:   Container(alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 15,right: 15),
                              child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.start,children: <Widget>[
                                /* Text.rich(
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
                                Text( publictranslist[index].message,
                                    style: TextStyle(fontFamily: 'Doomsday',
                                        fontSize:12,color: Colors.grey
                                    )),

                                SizedBox(height: 4,),

                                Row(children: <Widget>[
                                  Text(CustomUiWidgets.timesagofeacture(publictranslist[index].timestamp,context),style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 10),),
                                  Image.asset(CustomImages.unselected_globe,height: 10,width: 15,)
                                ],),
                                SizedBox(height: 5,),
                                Text(publictranslist[index].caption,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Row(children: <Widget>[
                                  InkWell(
                                      onTap:(){
                                        _createmylikepublic('public',index,publictranslist[index].like);
                                      },
                                      child:  publictranslist[index].like==0?Image.asset(CustomImages.unlike,height:25,width:30,):Image.asset(CustomImages.like,height:25,width:30,)),SizedBox(width: 5,),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(publictranslist[index].showmycomment==false){
                                            publictranslist[index].showmycomment=true;
                                          }
                                          else{
                                            publictranslist[index].showmycomment=false;
                                          }

                                        });

                                      },
                                      child: Image.asset(CustomImages.comment,height: 25,width: 30,))
                                ],),
                                SizedBox(height: 3,),
                                publictranslist[index].showmycomment==true?  Column(children: <Widget>[
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: publictranslist[index].mycommentlist.length,
                                      itemBuilder: ( context,ind){
                                        return Container(
                                          padding: EdgeInsets.only(top: 3,bottom: 3,left: 2,right: 2),
                                          child: Container(margin:EdgeInsets.only(top: 5,bottom: 5,left: 8,right: 8),decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(8))

                                          ), padding: EdgeInsets.only(left: 10,top: 2,right: 2,bottom: 2),
                                              child:Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                                                Text(publictranslist[index].mycommentlist[ind].comment,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color),),
                                                Container(margin: EdgeInsets.only(top: 3,right: 5),alignment: Alignment.centerRight,child: Text(CustomUiWidgets.timesagofeacture(publictranslist[index].mycommentlist[ind].date),style: TextStyle(fontFamily:'Doomsday',color: Colors.black26 ),),),
                                              ],)),

                                        );
                                      }),
                                  SizedBox(height: 5,),
                                  Container(child: Container(

                                    margin: EdgeInsets.only(top: 15),
                                    child:   FlatButton(
                                      textColor: Colors.white,
                                      highlightColor: MyColors.base_green_color_20,
                                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
                                      splashColor: MyColors.base_green_color_20,
                                      color:MyColors.base_green_color,
                                      disabledColor: MyColors.base_green_color,

                                      shape:  CustomUiWidgets.basicgreen_buttonshape(),
                                      onPressed:(){
                                        _createcommentdialogboxandcallapi(publictranslist[index].id.toString(),'public',index);
                                        //Navigator.of(context).pushNamed('/home');
                                      },
                                      child: Text('Add Comment',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
                                    ),) ,)

                                ],):SizedBox()

                              ],)),)

                        ],)),

                      );},):Text('No Data found',style:TextStyle (fontFamily: 'Doomsday'),),

                ):SizedBox(),
                privatepressed==true? Container(
                  margin: EdgeInsets.only(top: 5,bottom: 5,left: 3,right: 3),
                  child:isloading==true&&isfriendsdata==true?ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: friendslist.length,
                    separatorBuilder: (BuildContext context, int index) => Divider( height: 3, color: MyColors.grey_color),
                    itemBuilder: (context,index){return Container(
                      margin: EdgeInsets.only(top: 5,bottom: 5,left: 2,right: 2),
                      child: (Row(children: <Widget>[
                        Container(

                            margin: EdgeInsets.only(top: 15),
                            height:55.0,
                            width: 55.0,
                            decoration: new BoxDecoration(
                              color: Colors.white,


                              borderRadius:
                              new BorderRadius.all(const Radius.circular(80.0)),
                            ),
                            child:ClipRRect(
                                borderRadius: new BorderRadius.circular(80.0),
                                child:

                                FadeInImage(
                                  height:55.0,
                                  width: 55.0,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      friendslist[index].to_userimage),
                                  placeholder: AssetImage(
                                      CustomImages.default_profilepic),))),
                        Expanded(flex:1,child: Container(alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 15,right: 15),
                            child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.start,children: <Widget>[
                              /* Text.rich(
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
                              Text( friendslist[index].message,
                                  style: TextStyle(fontFamily: 'Doomsday',
                                      fontSize:12,color: Colors.grey
                                  )),

                              SizedBox(height: 4,),

                              Row(children: <Widget>[
                                Text(CustomUiWidgets.timesagofeacture(friendslist[index].timestamp),style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontSize: 10),),
                                Image.asset(CustomImages.unselected_globe,height: 10,width: 15,)
                              ],),
                              SizedBox(height: 5,),
                              Text(friendslist[index].caption,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Row(children: <Widget>[
                                InkWell( onTap:(){
                                  _createmylikepublic('friends',index,friendslist[index].like);
                                },child:  friendslist[index].like==0?Image.asset(CustomImages.unlike,height:25,width:30,):Image.asset(CustomImages.like,height:25,width:30,)),SizedBox(width: 5,),
                                InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(friendslist[index].showmycomment==false){
                                          friendslist[index].showmycomment=true;
                                        }
                                        else{
                                          friendslist[index].showmycomment=false;
                                        }

                                      });

                                      //  _createcommentdialogboxandcallapi(publictranslist[index].id.toString());
                                    },
                                    child: Image.asset(CustomImages.comment,height: 25,width: 30,))
                              ],),
                              SizedBox(height: 3,),
                              friendslist[index].showmycomment==true?    Column(children: <Widget>[
                                ListView.builder(
                                    shrinkWrap: true,

                                    scrollDirection: Axis.vertical,
                                    itemCount: friendslist[index].mycommentlist.length,
                                    itemBuilder: ( context,ind){
                                      return  Container(
                                        padding: EdgeInsets.only(top: 3,bottom: 3,left: 2,right: 2),
                                        child: Container(margin:EdgeInsets.only(top: 5,bottom: 5,left: 8,right: 8),decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(8))

                                        ), padding: EdgeInsets.only(left: 10,top: 2,right: 2,bottom: 2),
                                            child:Column(children: <Widget>[
                                              Text(friendslist[index].mycommentlist[ind].comment,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color),),
                                              Container(margin: EdgeInsets.only(top: 3,right: 5),alignment: Alignment.centerRight,child: Text(CustomUiWidgets.timesagofeacture(friendslist[index].mycommentlist[ind].date),style: TextStyle(fontFamily:'Doomsday',color: Colors.black26 ),),),
                                            ],)),

                                      );
                                    }),
                                SizedBox(height: 5,),
                                Container(child: Container(

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
                                      _createcommentdialogboxandcallapi(friendslist[index].id.toString(),'friends',index);
                                      //Navigator.of(context).pushNamed('/home');
                                    },
                                    child: Text('Add Comment',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
                                  ),) ,)

                              ],):SizedBox()

                            ],)),)

                      ],)),

                    );},):Text('No Data found',
                    style: TextStyle(fontFamily: 'Doomsday'),),

                ):SizedBox(),
                personalpressed==true? Container(
                  margin: EdgeInsets.only(top: 5,bottom: 5,left: 3,right: 3),
                  child: isloading==true&&isprivatedata==true?ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    scrollDirection: Axis.vertical,
                    itemCount: privatetranslist.length,
                    separatorBuilder: (BuildContext context, int index) => Divider( height: 3, color: MyColors.grey_color),
                    itemBuilder: (context,index){return Container(
                      margin: EdgeInsets.only(top: 5,bottom: 5,left: 2,right: 2),
                      child: (Row(children: <Widget>[
                        Container(

                            margin: EdgeInsets.only(top: 15),
                            height:55.0,
                            width: 55.0,

                            decoration: new BoxDecoration(
                              color: Colors.transparent,


                              borderRadius:
                              new BorderRadius.all(const Radius.circular(80.0)),
                            ),
                            child:ClipRRect(
                                borderRadius: new BorderRadius.circular(80.0),
                                child:

                                FadeInImage(
                                  height:55.0,
                                  width: 55.0,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      privatetranslist[index].to_userimage),
                                  placeholder: AssetImage(
                                      CustomImages.default_profilepic),))),
                        Expanded(flex:1,child: Container(alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 15,right: 15),
                            child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.start,children: <Widget>[
                              /* Text.rich(
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
                              Text( privatetranslist[index].message,
                                  style: TextStyle(fontFamily: 'Doomsday'
                                      ,
                                      fontSize:12,color: Colors.grey
                                  )),

                              SizedBox(height: 4,),

                              Row(children: <Widget>[
                                Text(CustomUiWidgets.timesagofeacture(privatetranslist[index].timestamp),style: TextStyle(fontFamily: 'Doomsday'
                                    ,color: MyColors.grey_color,fontSize: 10),),
                                Image.asset(CustomImages.unselected_globe,height: 10,width: 15,)
                              ],),
                              SizedBox(height: 5,),
                              Text(privatetranslist[index].caption,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Row(children: <Widget>[
                                InkWell( onTap:(){
                                  _createmylikepublic('private',index,privatetranslist[index].like);
                                },child:  privatetranslist[index].like==0?Image.asset(CustomImages.unlike,height:25,width:30,):Image.asset(CustomImages.like,height:25,width:30,)),SizedBox(width: 5,),
                                InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(privatetranslist[index].showmycomment==false){
                                          privatetranslist[index].showmycomment=true;
                                        }
                                        else{
                                          privatetranslist[index].showmycomment=false;
                                        }

                                      });
                                      //  _createcommentdialogboxandcallapi(publictranslist[index].id.toString());
                                    },
                                    child: Image.asset(CustomImages.comment,height: 25,width: 30,))
                              ],),
                              SizedBox(height: 3,),
                              privatetranslist[index].showmycomment==true?     Column(children: <Widget>[
                                ListView.builder(
                                    shrinkWrap: true,

                                    scrollDirection: Axis.vertical,
                                    itemCount: privatetranslist[index].mycommentlist.length,
                                    itemBuilder: ( context,ind){
                                      return  Container(
                                        padding: EdgeInsets.only(top: 3,bottom: 3,left: 2,right: 2),
                                        child: Container(margin:EdgeInsets.only(top: 5,bottom: 5,left: 8,right: 8),decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(8))

                                        ), padding: EdgeInsets.only(left: 10,top: 2,right: 2,bottom: 2),
                                            child:Column(children: <Widget>[
                                              Text(privatetranslist[index].mycommentlist[ind].comment,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color),),
                                              Container(margin: EdgeInsets.only(top: 3,right: 5),alignment: Alignment.centerRight,child: Text(CustomUiWidgets.timesagofeacture(privatetranslist[index].mycommentlist[ind].date),style: TextStyle(fontFamily:'Doomsday',color: Colors.black26 ),),),
                                            ],)),

                                      );
                                    }),
                                SizedBox(height: 5,),
                                Container(child: Container(


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
                                      _createcommentdialogboxandcallapi(privatetranslist[index].id.toString(),'private',index);
                                      //Navigator.of(context).pushNamed('/home');
                                    },
                                    child: Text('Add Comment',style: TextStyle(fontFamily: 'Doomsday',fontSize: 14,color: Colors.white),),
                                  ),) ,)

                              ],):SizedBox()

                            ],)),)

                      ],)),

                    );},):Text('No Data found',style: TextStyle(fontFamily: 'Doomsday'),),

                ):SizedBox(),
              ],)))
              :Container(child: Center(child: CommonUtills.progressdialogbox(),)),
        ],)

    );

  }

  _createmyheader(BuildContext context) {
    return Container(color: MyColors.base_green_color, alignment: Alignment.bottomCenter, width: double.infinity,height: 100,

      child:Row(children: <Widget>[
        Expanded(
          child: Container(
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
                scaffoldState.currentState.openDrawer();
              },
              child: Image.asset(CustomImages.white_menu,height: 20,width: 25,),
            ),),

        ),
        Expanded(flex: 5,
            child: Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                width:double.infinity,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5),)),

                child:Row(children: <Widget>[
                  Expanded(flex:1,child:
                  InkWell(
                      onTap: (){
                        setState(() {
                          publictranspressed=true;
                          privatepressed=false;
                          personalpressed=false;
                        });
                      },

                      child: publictranspressed==false?Container(margin: EdgeInsets.only(right: 2), padding: EdgeInsets.only(top: 2,bottom: 2),color:MyColors.base_green_color,child: Image.asset(CustomImages.white_globe,height: 20,width: 20,),)
                          :Container(margin: EdgeInsets.only(right: 2),padding: EdgeInsets.only(top: 2,bottom: 2), color:Colors.white,child:Image.asset(CustomImages.selected_globe,height: 20,width: 20,))),),
                  Expanded(flex:1,child:
                  InkWell(
                      onTap: (){
                        setState(() {
                          publictranspressed=false;
                          privatepressed=true;
                          personalpressed=false;
                        });
                      },

                      child: privatepressed==false?Container(margin: EdgeInsets.only(right: 2),padding: EdgeInsets.only(top: 2,bottom: 2), color:MyColors.base_green_color,child: Image.asset(CustomImages.white_doubleperson,height: 20,width: 20,),)
                          :Container(margin: EdgeInsets.only(right: 2),padding: EdgeInsets.only(top: 2,bottom: 2), color:Colors.white,child: Image.asset(CustomImages.doublemangreen,height: 20,width: 20,))),),
                  Expanded(flex:1,child:
                  InkWell(
                      onTap: (){
                        setState(() {
                          publictranspressed=false;
                          privatepressed=false;
                          personalpressed=true;
                        });
                      },

                      child: personalpressed==false?Container(padding: EdgeInsets.only(top: 2,bottom: 2), color:MyColors.base_green_color,child: Image.asset(CustomImages.white_singleman,height: 20,width: 20,),)
                          :Container( padding: EdgeInsets.only(top: 2,bottom: 2),color:Colors.white,child: Image.asset(CustomImages.singlemengreen,height: 20,width: 20,))),),
                ],)
            )

        ),
        Expanded(
          child: Container(
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
                // _calltranscationapi();
                Navigator.of(context).pushNamed("/addbenificary");
              },
              child: Image.asset(CustomImages.unselected_pencil_dollar,height: 20,width: 25,),
            ),),

        ),

      ],),);

  }

  _showmyrelevantList(BuildContext context) {
    return
      Container(
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
                      Image.asset(CustomImages.LOGOIMAGE,height: 10,width: 15,)
                    ],),
                    SizedBox(height: 5,),
                    Text("Luv ",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Row(children: <Widget>[
                      Image.asset(CustomImages.LOGOIMAGE,height: 30,width: 45,),SizedBox(width: 5,),
                      Image.asset(CustomImages.LOGOIMAGE,height: 30,width: 45,)
                    ],),

                  ],)),)

            ],)),

          );},),

      );

  }

  void _callmywalletapi() async {
    try
    {
      //CommonUtills.showprogressdialogcomplete(context, true);

      WalletApi _walletapi = new WalletApi();
      WalletModels results = await _walletapi.search();
      if(results.status=="true"){
        setState(() {
          PrefrencesManager.setString(StringMessage.walletbalance, results.balance+"");
        });

        // CommonUtills.showprogressdialogcomplete(context, false);
        //CommonUtills.successtoast(context, results.balance);

      }
      else{
        // CommonUtills.showprogressdialogcomplete(context, false);
        //CommonUtills.errortoast(context,results.message);
      }


    }
    catch(e)
    {
      print(e);
    }
  }

  void _calltranscationapi()  async{
    try{
      //CommonUtills.errortoast(context, "resumecalled");
      MytranscationApi _mytransapi =new MytranscationApi();
      MytranscationModels result = await _mytransapi.search();
      totaltranslist.clear();
      publictranslist.clear();
      friendslist.clear();
      privatetranslist.clear();

      if(result.status=="true")
      {
        totaltranslist=result.mytransdata;

        if(totaltranslist.length>0)
        {
          for(int i=0;i<totaltranslist.length;i++){
            if(totaltranslist[i].privacy=="public"){
              publictranslist.add(totaltranslist[i]);
            }
            else if(totaltranslist[i].privacy=="friends"){
              friendslist.add(totaltranslist[i]);
            }
            else{
              privatetranslist.add(totaltranslist[i]);
            }
          }

          if(publictranslist.length>0){
            setState(() {
              ispublicdata=true;
            });

          }
          if(privatetranslist.length>0){
            setState(() {
              isprivatedata=true;
            });
          }
          if(friendslist.length>0){
            setState(() {
              isfriendsdata=true;
            });
          }
          if(totaltranslist.length>0){
            setState(() {
              isloading=true;
            });
          }

        }
        else{
          setState(() {
            isloading=true;
            isprivatedata=false;
            isfriendsdata=false;
            ispublicdata=false;
          });
        }





      }
    }
    catch(e){
      print(e);
      setState(() {
        isloading=true;
      });
      CommonUtills.errortoast(context, e.toString());
    }

  }

  void _createcommentdialogboxandcallapi(String id, String privacy,int index) {
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
                                  Expanded(flex:2,child:Text("add your comment",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Doomsday',decoration: TextDecoration.none,color: MyColors.grey_color,fontSize: 16,fontWeight: FontWeight.bold),)),

                                ],),
                                SizedBox(height: 15,),

                                Container(alignment: Alignment.center,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                                    SizedBox(height: 10,),
                                    Container(
                                      height: 80,
                                      color: Colors.white,

                                      margin: EdgeInsets.fromLTRB(8, 13, 5, 0),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.multiline,
                                        controller: withdrawamountcontroller,
                                        style: TextStyle(fontFamily: 'Doomsday'),

                                        decoration: InputDecoration(

                                          border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.zero),),
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: const BorderSide(color: MyColors.base_green_color, width: 2.0),
                                            borderRadius: BorderRadius.all(Radius.zero),
                                          ),

                                          hintText: 'enter comment',

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
                                            CommonUtills.errortoast(context, "Enter comment");
                                          }

                                          else{

                                            Navigator.of(context).pop();
                                            addmycomment(id,withdrawamountcontroller.text.toString(),privacy,index);

                                          }




                                        },
                                        child: Text('Add',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Doomsday'),),
                                      ),),
                                  ],),)



                              ],)),
                          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),





                      );}));



        });
  }

  void addmycomment(String id, String comment, String privacy, int index) async {
    try{
      CommonUtills.showprogressdialogcomplete(context, true);
      AddMyCommentApi _commentapi= new AddMyCommentApi();
      CommonModels results = await _commentapi.search(id, comment);
      if(results.status=="true"){
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.successtoast(context,"comment added");
        setState(() {


          if(privacy=='public'){
            MyComments mycomm=new MyComments();
            mycomm.comment=comment;
            mycomm.date=new DateTime.now().toLocal().toString();
            publictranslist[index].mycommentlist.add(mycomm);
          }
          else if(privacy=="friends"){
            MyComments mycomm=new MyComments();
            mycomm.comment=comment;
            mycomm.date=new DateTime.now().toUtc().toString();
            friendslist[index].mycommentlist.add(mycomm);
          }
          else{
            MyComments mycomm=new MyComments();
            mycomm.comment=comment;
            mycomm.date=new DateTime.now().toUtc().toString();
            privatetranslist[index].mycommentlist.add(mycomm);
          }
        });
       /* setState(() {
          publictranslist= publictranslist.reversed.toList();
          friendslist= friendslist.reversed.toList();
          privatetranslist= privatetranslist.reversed.toList();
          // friendslist.reversed();
          //  privatetranslist
        });*/
      }
      else{
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.errortoast(context,results.message);
      }



    }
    catch(e){
      print(e);
      CommonUtills.showprogressdialogcomplete(context, false);
      CommonUtills.errortoast(context,e.toString());
    }
  }

  void _createmylikepublic(String privacy, int index, int like) async{
    try{
      MyLikedislikeApi _likeapi= new MyLikedislikeApi();
      CommonModels _results;
      if(privacy=="public"){
        setState(() {
          if(like==0){
            publictranslist[index].like=1;
          }
          else{
            publictranslist[index].like=0;
          }

        });
        _results=await _likeapi.search( publictranslist[index].id.toString(), publictranslist[index].like.toString());
      }
      else if(privacy=="friends"){
        setState(() {
          if(like==0){
            friendslist[index].like=1;
          }
          else{
            friendslist[index].like=0;
          }

        });
        _results=await _likeapi.search( friendslist[index].id.toString(), friendslist[index].like.toString());

      }
      else{
        setState(() {
          if(like==0){
            privatetranslist[index].like=1;
          }
          else{
            privatetranslist[index].like=0;
          }

        });
        _results=await _likeapi.search( privatetranslist[index].id.toString(), privatetranslist[index].like.toString());

      }

      /// call API
      if(_results.status=="true"){
        CommonUtills.successtoast(context, "liked");
      }



    }
    catch(e){
      print(e);
      CommonUtills.errortoast(context, e.toString());
    }

  }
}