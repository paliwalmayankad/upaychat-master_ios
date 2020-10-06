import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/imagepicker.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_images.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/CustomWidgets/my_colors.dart';
import 'package:upaychat/Validationandapi/editprofilevalidationandupdate.dart';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';


import 'package:upaychat/CommonUtills/common_utills.dart';
import 'package:upaychat/CommonUtills/prefrences_manager.dart';
import 'package:upaychat/CommonUtills/string_files.dart';
import 'package:upaychat/CustomWidgets/custom_ui_widgets.dart';
import 'package:upaychat/Pages/add_user_profile.dart';
import 'package:upaychat/Pages/login_file.dart';
import 'package:upaychat/Pages/mobile_number_file.dart';
import 'package:upaychat/api/login_api.dart';
import 'package:upaychat/api/network_utils.dart';
import 'package:upaychat/firebase/firebaseauthentication.dart';
import 'package:upaychat/models/loginmodels.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile>with TickerProviderStateMixin,ImagePickerListener
{
  File _image;
  ImagePickerHandler imagePicker;
  AnimationController _controller;
  TextEditingController firstnamecontroller,lastnamecontroller,usernamecontroller,emailcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = new AnimationController(
      vsync: this,

      duration: const Duration(milliseconds: 500),
    );


    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();
    firstnamecontroller=new TextEditingController();
    lastnamecontroller=new TextEditingController();
    usernamecontroller=new TextEditingController();
    emailcontroller=new TextEditingController();
    String img= PrefrencesManager.getString(StringMessage.profileimage);
    setState(() {
      firstnamecontroller.text=PrefrencesManager.getString(StringMessage.firstname);
      lastnamecontroller.text=PrefrencesManager.getString(StringMessage.lastname);
      usernamecontroller.text=PrefrencesManager.getString(StringMessage.username);
      emailcontroller.text=PrefrencesManager.getString(StringMessage.email);
    });
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
                      child: Text('Edit Profile',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
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
                      checkemailorusernameempty(context, firstnamecontroller, lastnamecontroller, _image);

                    },
                    child: Text('Save',style: TextStyle(fontFamily: 'Doomsday',fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                    ),),
                  ),

                ),

              ],),),
            Expanded(child:  Container(
              margin:  EdgeInsets.only(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:Column(
                    children: <Widget>[
                      ///
                      Container(height: 150,width: MediaQuery.of(context).size.width/3,
                        child: Stack(children: <Widget>[
                          Positioned(
                            child:InkWell(
                                onTap: (){

                                  imagePicker.showDialog(context);
                                },
                                child: _image==null?Container(

                                    margin: EdgeInsets.only(top: 15),
                                    height:110.0,
                                    width: 180.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,


                                      borderRadius:
                                      new BorderRadius.all(const Radius.circular(80.0)),
                                    ),
                                    child:ClipRRect(
                                        borderRadius: new BorderRadius.circular(80.0),
                                        child:

                                        FadeInImage(
                                          height:110,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              PrefrencesManager.getString(StringMessage.profileimage)),
                                          placeholder: AssetImage(
                                              CustomImages.default_profilepic),))):
                                new Container(margin: EdgeInsets.only(top: 15),
                                    height:110.0,
                                    width: 180.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,


                                      borderRadius:
                                      new BorderRadius.all(const Radius.circular(80.0)),
                                    ),
                                    child:ClipRRect(
                                      borderRadius: new BorderRadius.circular(80.0),
                                      child: Image.file(_image,fit: BoxFit.cover,height: 120,width: 100,),))),
                          ),
                          Positioned(bottom: 25,
                            right: 10,
                            child:InkWell(
                                onTap: (){

                                  imagePicker.showDialog(context);
                                },
                                child: Image.asset(CustomImages.edit_photo,height: 20,)),
                          ),

                        ],),
                      ),

                      SizedBox(height: 2,),
                      InkWell(
                          onTap: (){

                            imagePicker.showDialog(context);
                          },
                          child:  Text("Change Profile Photo",style: TextStyle(fontFamily: 'Doomsday',color: MyColors.base_green_color),)),

                      SizedBox(height: 5,),
                      Container(margin: EdgeInsets.only(left: 5,right: 5),child: Column(children: <Widget>[
                        TextFormField(

                          controller: firstnamecontroller,
                          cursorColor: MyColors.grey_color,style: TextStyle(fontFamily: 'Doomsday',color: MyColors.grey_color),
                          decoration: InputDecoration(
                            labelText: 'First Name',labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 13,fontFamily: 'Doomsday'),
                            contentPadding:EdgeInsets.all(0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.grey_color),

                            ),



                          ),
                        ),
                        SizedBox(height: 2,),
                        TextFormField(
                          controller: lastnamecontroller,

                          cursorColor: MyColors.grey_color,style: TextStyle(color: MyColors.grey_color,fontFamily: 'Doomsday'),
                          decoration: InputDecoration(
                            labelText: 'Last Name',labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 13,fontFamily: 'Doomsday'),
                            contentPadding:EdgeInsets.all(0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.grey_color),

                            ),



                          ),
                        ),
                        SizedBox(height: 2,),
                        TextFormField(
                          controller: usernamecontroller,
                          enabled: false,
                          cursorColor: MyColors.grey_color,style: TextStyle(color: MyColors.grey_color,fontFamily: 'Doomsday'),
                          decoration: InputDecoration(
                            labelText: 'Username',labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 13,fontFamily: 'Doomsday'),
                            contentPadding:EdgeInsets.all(0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.grey_color),

                            ),



                          ),
                        ),
                        SizedBox(height: 2,),
                        TextFormField(
                          controller: emailcontroller,
                          enabled: false,

                          cursorColor: MyColors.grey_color,style: TextStyle(color: MyColors.grey_color,fontFamily: 'Doomsday'),
                          decoration: InputDecoration(
                            labelText: 'Email',labelStyle: TextStyle(color: MyColors.grey_color,fontSize: 13,fontFamily: 'Doomsday'),
                            contentPadding:EdgeInsets.all(0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColors.grey_color),

                            ),



                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(alignment: Alignment.centerLeft,child:Text("you can be paid using your username, email, or \n phone number.",textAlign: TextAlign.left,style: TextStyle(color: MyColors.grey_color,fontSize: 9,fontFamily: 'Doomsday'),)),
                      ],),)




                    ]),),)),


          ],
        ));
  }

  @override
  userImage(File _image) {
    // TODO: implement userImage
    setState(() {

      if(_image!=null) {
        this._image = _image;

      } //_scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Photo uploaded successfully'),));
    });
  }

  void checkemailorusernameempty(BuildContext context, TextEditingController firstnamecontroller, TextEditingController lastnamecontroller, File image)async {
    if (true == await CommonUtills.checkNetworkStatus(context)) {
      // CommonUtills.successtoast(context, StringMessage.login_successfully);
      if(CommonUtills.isempty(context, firstnamecontroller, StringMessage.firstname_error, 3)){
        CommonUtills.errortoast(context, StringMessage.firstname_error);
      }
      else if(CommonUtills.isempty(context, lastnamecontroller, StringMessage.lastname_error, 3)){
        CommonUtills.errortoast(context, StringMessage.lastname_error);
      }

      else{
        CommonUtills.showprogressdialogcomplete(context, true);
        try {

          String token=PrefrencesManager.getString(StringMessage.token);
          Map<String, String> headers = {'Accept': 'application/json',
            'Authorization':'Bearer $token'
          };
          var uri = Uri.parse(NetworkUtils.base_url+'updateprofile');
          var request = new http.MultipartRequest("POST", uri);

          // multipart that takes file
          var multipartFileSign;
          if(image!=null){
            var stream = new http.ByteStream(
                DelegatingStream.typed(image.openRead()));

            var length = await image.length();
            multipartFileSign= new http.MultipartFile(
                'profile_image', stream, length,
                filename: image.path);

            // add file to multipart
            request.files.add(multipartFileSign);
          }


          request.headers.addAll(headers);

          request.fields['firstname'] = firstnamecontroller.text.toString();
          request.fields['lastname'] = lastnamecontroller.text.toString();


          // send
          var response = await request.send();

          print(response.statusCode);


          // listen for response
          response.stream.transform(utf8.decoder).listen((value) {
            try {
              print(value);
              final body = json.decode(value);

              String status=body['status'];
              String msg=body['message'];

              if(status=="true"){
                CommonUtills.showprogressdialogcomplete(context, false);
                CommonUtills.successtoast(context, "Saved");
                String image=body['profile_image'];
               setState(() {
                 PrefrencesManager.setString(StringMessage.firstname, firstnamecontroller.text.toString());
                 PrefrencesManager.setString(StringMessage.lastname, lastnamecontroller.text.toString());
                 PrefrencesManager.setString(StringMessage.profileimage, body['profile_image']);

               });



              }
              else{
                CommonUtills.showprogressdialogcomplete(context, false);
                CommonUtills.errortoast(context, msg);
              }

            } catch (e) {
              print(e);
              CommonUtills.showprogressdialogcomplete(context, false);
            }
          });
        }catch(e){
          print(e);
          CommonUtills.showprogressdialogcomplete(context, false);
        }

      }



    }
    else {
      CommonUtills.errortoast(context, StringMessage.network_error);
    }
  }
}