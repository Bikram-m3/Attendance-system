import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wifi_attendance_web/ApiManagers/SubjectApi.dart';
import 'package:wifi_attendance_web/Utilities/App_Cred.dart';

import '../../Models/deviceIDModel.dart';

class sendNotifications extends StatefulWidget {
  const sendNotifications({Key? key}) : super(key: key);

  @override
  State<sendNotifications> createState() => _sendNotificationsState();
}

class _sendNotificationsState extends State<sendNotifications> {

  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _contentController=TextEditingController();
  late Future<List<deviceIDModel>> _deviceListLoader;

  String title='',content='';


  @override
  void initState() {
    super.initState();
  _deviceListLoader=SubjectApi().fetchUID();
  }

  Future<Response> sendNotification(String contents, String heading,List<String> devices) async{

    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": AppCredential.ONESIGNAL_ID,//kAppId is the App Id that one get from the OneSignal When the application is registered.
        "include_player_ids": devices,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.
        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color":"FF9976D2",
        "small_icon":"ic_stat_onesignal_default",
        "headings": {"en": heading},
        "contents": {"en": contents},
      }),
    );
  }


  List<String> getdeviceList(List<deviceIDModel> dat){
    List<String> temp=[];
    for(int i=0;i<dat.length;i++){
      temp.add(dat[i].uid!);
    }
    return temp;
  }
  
  




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<deviceIDModel>>(
      future: _deviceListLoader,
        builder: (context,snapshot){
      if(snapshot.hasError){
        return const Center(
          child: Text("No Subject Found !!!",style: TextStyle(fontWeight: FontWeight.w600),),
        );
      }else if(snapshot.hasData){
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notification Title :",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 300,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black54),
                  color: Colors.white.withOpacity(0.3),
                ),
                child: TextField(
                  autofocus: true,
                  controller: _titleController,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (text) {
                    title = text;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Notification Title',
                    hintStyle: TextStyle(color: Colors.black38),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Notification Body :",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 300,
                height: 200,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black54),
                  color: Colors.white.withOpacity(0.3),
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: _contentController,
                  maxLines: null,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (text) {
                    content = text;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write Content Here....',
                    hintStyle: TextStyle(color: Colors.black38),
                  ),

                ),
              ),



              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  _contentController.clear();
                  _titleController.clear();
                  print(title);
                  print(content);
                  sendNotification(content, title,getdeviceList(snapshot.data!));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  margin: const EdgeInsets.only(left: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black87.withOpacity(0.7),
                  ),
                  child: const Center(
                    child: Text(
                      "Send",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
          ,
        );
      }else{
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
