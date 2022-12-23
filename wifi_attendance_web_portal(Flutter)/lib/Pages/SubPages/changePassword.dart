import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/ApiManagers/adminApi.dart';
import 'package:wifi_attendance_web/Sessons/loginSesson.dart';

class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {

  final TextEditingController _newPassController=TextEditingController();
  final TextEditingController _rePassController=TextEditingController();
  final TextEditingController _currentPassController=TextEditingController();

  String newPass = '',
      currentPass = '',rePass='',err='',UID='';

  bool change=false;



  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData(){
    loginSesson().getId().then((value) => UID=value!);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          change ? Text(err,style: const TextStyle(fontWeight: FontWeight.w600,color: Colors.red),) :
          const SizedBox(height: 20,),

          const Text(
            "Current Password :",
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
              controller: _currentPassController,
              style: const TextStyle(color: Colors.black),
              onChanged: (text) {
                currentPass = text;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Current Password',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),


          const SizedBox(
            height: 30,
          ),
          const Text(
            "New Password :",
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
              controller: _newPassController,
              textCapitalization: TextCapitalization.characters,
              style: const TextStyle(color: Colors.black),
              onChanged: (text) {
                newPass = text;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'New Password' ,
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),
          const Text(
            "Re Enter Password :",
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
              controller: _rePassController,
              textCapitalization: TextCapitalization.characters,
              style: const TextStyle(color: Colors.black),
              onChanged: (text) {
                rePass = text;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Re Enter Password' ,
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),


          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {

              if(currentPass.length>6){
                if(newPass.length>6 && rePass.length>6){
                  if(newPass==rePass){
                    adminApi().changePass(UID, currentPass, newPass).then((value){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                              Container(
                                height: 150,
                                decoration:
                                BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  children: [
                                    const Icon(
                                      Icons
                                          .cloud_done_rounded,
                                      color: Colors
                                          .green,
                                      size: 80,
                                    ),
                                    Text(value.body),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton
                                      .styleFrom(
                                    primary: Colors
                                        .white,
                                    backgroundColor:
                                    Colors
                                        .teal,
                                    onSurface:
                                    Colors
                                        .grey,
                                  ),
                                  child:
                                  const Text(
                                      'OK'),
                                  onPressed:
                                      () {
                                    Navigator.of(
                                        context)
                                        .pop();
                                  },
                                ),
                              ],
                            );
                          });
                    });

                  }else{
                    setState(() {
                      err="New Password didn't matched..!!";
                      change=true;
                    });
                  }
                }else{
                  setState(() {
                    err="New Password Must be greater than 6 digits";
                    change=true;
                  });
                }

              }else{
                setState(() {
                  err="Enter valid current Password..!!";
                  change=true;
                });
              }

              print(newPass);
              print(rePass);
              print(currentPass);
              _currentPassController.clear();
              _newPassController.clear();
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
                  "Change Password",
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
  }
}
