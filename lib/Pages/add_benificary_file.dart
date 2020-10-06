import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Pages/pay_or_requestfile.dart';
import 'package:upaychat/api/usersearch_fapi.dart';
import 'package:upaychat/models/usersearchmodels.dart';

class AddBenificiaryFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddBenificiaryFileState();
  }
}

class AddBenificiaryFileState extends State<AddBenificiaryFile>{
  bool dataloaded=false;
  BuildContext cont;
  List<UserList> userlist;
  List<UserList> searchuserlist;
  String msg;
  bool isdatafound=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userlist=new List();
    searchuserlist=new List();
    _callallusersbenificary();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    this.cont=context;
    return Scaffold(   body: Container(
      color: MyColors.base_green_color_20,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _body(context)),

    ),);
  }

  _body(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CustomUiWidgets.benificiaryscreen_header(context),
          dataloaded==true? Container(
            margin: EdgeInsets.only(top: 10,left: 8,right: 8),
            child:
            isdatafound==true? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
                        child: TextFormField(
                          onChanged: (value){
                            filterSearchResults(value);
                          },
                          style: TextStyle(fontFamily: 'Doomsday'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(  borderRadius: BorderRadius.all(Radius.circular(5.0)),),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: MyColors.base_green_color, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),

                            hintText: 'Name, @username,phone, or email',

                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(10, 00, 10, 0),
                        child:   Container(width: double.infinity
                            ,
                            padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                            decoration: BoxDecoration(
                                border: Border.all(color: MyColors.grey_color,width: 1.0)
                            ),
                            child:  Row(children: <Widget>[
                              Expanded(

                                  child:

                                  Align( alignment: Alignment.centerLeft,child:
                                  Image.asset(CustomImages.social_media_greeen,height: 30,width: 30,))),

                              Expanded(flex:6,child:
                              Align( alignment: Alignment.topLeft,
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Scan Code",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Doomsday'),),
                                      Text("Quicly pay or request money",textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize:8,fontFamily: 'Doomsday'),)
                                    ],)

                              )),


                            ],)),
                      ),

                      SizedBox(height: 25,),
                      Text('   Top People',textAlign: TextAlign.start,style: TextStyle(color: MyColors.grey_color,fontFamily: 'Doomsday'),),
                      /*SizedBox(height: 5,),
                      Container(


                          child: ListView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                return Column(children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    child:   Container(width: double.infinity
                                        ,
                                        padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: MyColors.grey_color,width: 1.0)
                                        ),
                                        child:  Row(children: <Widget>[
                                          Expanded(

                                              child:

                                              Align( alignment: Alignment.centerLeft,child:
                                              Image.asset(CustomImages.round_grey_user,height: 30,width: 30,))),

                                          Expanded(flex:6,child:
                                          Align( alignment: Alignment.topLeft,
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("Scan Code",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text("Quicly pay or request money",textAlign: TextAlign.left,style: TextStyle(color:MyColors.grey_color,fontSize:8),)
                                                ],)

                                          )),


                                        ],)),
                                  ),
                                  Container(color: MyColors.light_grey_divider_color,height: 1,),

                                ],);
                              })),*/
                      SizedBox(height: 5,),
                      Container(
                          margin: EdgeInsets.only(left: 10,right: 10),

                          child: ListView.builder(
                              itemCount: userlist.length
                              ,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                return Column(children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    child:  InkWell(onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PayorRequestFile(
                                        userid:
                                        userlist[index].user_id,
                                        username: userlist[index].username,
                                      )));
                                      /* Navigator.pushNamed(context,"/payorrequestfile",arguments: PayorRequestFile(
                                       userid:
                                          userlist[index].user_id,
                                        username: userlist[index].username,
                                      ));*/
                                    }, child:Container(width: double.infinity
                                        ,
                                        padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 3),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: MyColors.grey_color,width: 1.0)
                                        ),
                                        child:  Row(children: <Widget>[
                                          Expanded(

                                              child:

                                              Align( alignment: Alignment.centerLeft,child:
                                              Container(margin: EdgeInsets.only(top: 15),
                                                  height:30.0,
                                                  width: 30.0,
                                                  decoration: new BoxDecoration(
                                                    color: Colors.white,


                                                    borderRadius:
                                                    new BorderRadius.all(const Radius.circular(80.0)),
                                                  ),
                                                  child:ClipRRect(
                                                    borderRadius: new BorderRadius.circular(80.0),
                                                    child: FadeInImage(
                                                      height: 30,
                                                      width: 30,

                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(""), placeholder: AssetImage(CustomImages.default_profilepic,),),)))),

                                          Expanded(flex:6,child:
                                          Align( alignment: Alignment.topLeft,
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(userlist[index].firstname+" "+userlist[index].lastname,textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color,fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text(userlist[index].username??"",textAlign: TextAlign.left,style: TextStyle(fontFamily: 'Doomsday',color:MyColors.grey_color,fontSize:8),)
                                                ],)

                                          )),


                                        ],))),
                                  ),
                                  Container(color: MyColors.light_grey_divider_color,height: 1,),

                                ],);
                              }))
                    ])):Center(child: Text(msg,style: TextStyle(fontFamily: 'Doomsday',color: Colors.black),),),

          ):Container(child: CommonUtills.progressdialogbox()),
        ],
      ),

    );
  }

  void _callallusersbenificary() async {
    try{

      UserSearchapi _searchapi= new UserSearchapi();
      UserSearchModels result=await _searchapi.search();
      if(result.status=="true"){
        for(int i=0;i<result.userlist.length;i++){
          if(result.userlist[i].user_id!=PrefrencesManager.getInt(StringMessage.id)){
            userlist.add(result.userlist[i]);
          }
        }
        setState(() {

          searchuserlist=result.userlist;
          dataloaded=true;
          if(userlist.length>0){
            isdatafound=true;
          }
          else{
            isdatafound=false;
          }

        });

      }
      else{
        CommonUtills.showprogressdialogcomplete(context, false);
        CommonUtills.errortoast(context,result.message);
      }
    }
    catch(e)
    {
      print(e);
      CommonUtills.errortoast(context,StringMessage.networkservererror);
    }

  }

  void filterSearchResults(String query) {
    try {
      if(userlist.length>0){
        if (query.isNotEmpty) {
          List<UserList> dummyListData = List<UserList>();
          searchuserlist.forEach((UserList model) {
            if ((model.username??'username').toLowerCase().contains(query.toLowerCase()) ||
                (model.firstname??'username').toLowerCase().contains(query.toLowerCase()) ||
                (model.mobile??'000000').toLowerCase().contains(query.toLowerCase())||
                (model.email??'demo@gmail.com').toLowerCase().contains(query.toLowerCase())
            ) {
              dummyListData.add(model);
            }
          });
          setState(() {
            userlist = [];
            userlist.addAll(dummyListData);
          });
          return;
        }
        else {
          List<UserList> dummyListData = List<UserList>();
          List<UserList> dummySearchList = List<UserList>();
          //dummySearchList.addAll(categorieslist_sec);
          searchuserlist.forEach((UserList model) {
            dummyListData.add(model);
          });
          setState(() {
            userlist = [];


            userlist.addAll(dummyListData);
          });
        }
        return;
      }

    }catch(e)
    {
      print(e.toString());
    }
  }
}
