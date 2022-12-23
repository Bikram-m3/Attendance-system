import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/ApiManagers/adminApi.dart';
import 'package:wifi_attendance_web/Pages/SubPages/Dashboard_AdminArea.dart';

import '../../ApiManagers/SubjectApi.dart';
import '../../ApiManagers/UsersApi.dart';
import '../../Models/adminListModel.dart';
import '../../Models/subjectModel.dart';

class adminList extends StatefulWidget {
  const adminList({Key? key}) : super(key: key);

  @override
  State<adminList> createState() => _adminListState();
}

class _adminListState extends State<adminList> {
  late Future<List<adminListModel>> _adminData;
  late List<adminListModel> Dataa;
  late adminListModel singleData;
  int pageToggle=0;
  bool isEnabled=false,isEdit=true;

 // late final TextEditingController _nameController;
  //late final TextEditingController _phoneController;

  String fullName = '', phoneNo = '';

  @override
  void initState() {
    _loadData();
  }
  void _loadData() {
    _adminData = adminApi().fetchAdminList();
  }


  @override
  Widget build(BuildContext context) {
    if(pageToggle==0){
      return Center(
        child: FutureBuilder<List<adminListModel>>(
          future: _adminData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(child: Text("No Record Found !!!",style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              );
            } else if (snapshot.hasData) {
              Dataa = snapshot.data!;
              print(Dataa[0].name);
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.black38,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: 630,
                        height: 525,
                        child: ListView.builder(
                            itemCount: Dataa.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                const EdgeInsets.only(left: 60, right: 60),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.account_circle_rounded,
                                      size: 38,
                                    ),
                                    title: Text(
                                      Dataa[index].name ?? '',
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor: Colors.teal,
                                              onSurface: Colors.grey,
                                            ),
                                            child: const Text('View'),
                                            onPressed: () {
                                              setState(() {
                                                pageToggle=1;
                                                singleData = Dataa[index];
                                              });
                                            },
                                          ),
                                          IconButton(
                                              icon: const Icon(
                                                Icons.delete_forever,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Container(
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: const [
                                                              Icon(
                                                                Icons.cached_sharp,
                                                                color: Colors.green,
                                                                size: 80,
                                                              ),
                                                              Text("Are You Sure ?"),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              primary: Colors.white,
                                                              backgroundColor: Colors.teal,
                                                              onSurface: Colors.grey,
                                                            ),
                                                            child: const Text('Yes'),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                              setState(() {
                                                                UsersApi().deleteUsers(singleData.username!).then((value) => {
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (context) {
                                                                        return AlertDialog(
                                                                          content: Container(
                                                                            height: 150,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                            ),
                                                                            child: Column(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.cloud_done_rounded,
                                                                                  color: Colors.green,
                                                                                  size: 80,
                                                                                ),
                                                                                Text(value),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: [
                                                                            TextButton(
                                                                              style: TextButton.styleFrom(
                                                                                primary: Colors.white,
                                                                                backgroundColor: Colors.teal,
                                                                                onSurface: Colors.grey,
                                                                              ),
                                                                              child: const Text('OK'),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      })
                                                                });
                                                                _loadData();
                                                                pageToggle=0;
                                                              });
                                                            },
                                                          ),
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              primary: Colors.white,
                                                              backgroundColor: Colors.teal,
                                                              onSurface: Colors.grey,
                                                            ),
                                                            child: const Text('No'),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });




                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }else{

      TextEditingController nameController = TextEditingController(text: singleData.name);
      TextEditingController phoneController=TextEditingController(text: singleData.phone);

      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.only(left: 40,right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: const Text('Back'),
                    onPressed: () {
                      setState(() {
                        pageToggle=0;
                      });
                    },
                  ),
                  isEdit?TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: const Text('Edit'),
                    onPressed: () {
                      setState(() {
                        isEnabled=true;
                        isEdit=false;
                      });

                    },
                  ):TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: const Text('Save'),
                    onPressed: () {
                      if(fullName==''){
                        fullName=singleData.name!;
                        if(phoneNo==''){
                          phoneNo=singleData.phone!;
                        }
                      }else{
                        if(phoneNo==''){
                          phoneNo=singleData.phone!;
                        }
                      }
                      UsersApi().updateUsers(fullName, phoneNo, singleData.username!)
                          .then((value) => {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.cloud_done_rounded,
                                        color: Colors.green,
                                        size: 80,
                                      ),
                                      Text(value),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.teal,
                                      onSurface: Colors.grey,
                                    ),
                                    child: const Text('OK'),
                                    onPressed: () {
                                      setState(() {
                                        isEnabled=false;
                                        isEdit=true;
                                        _loadData();
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            })
                      });
                      setState(() {
                        isEnabled=false;
                        isEdit=true;
                        pageToggle=0;
                        _loadData();
                      });

                    },
                  ),
                ],
              ),
            ),
            Expanded(child: Container(
              child: Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.account_circle_rounded,size: 60,),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("UserName :-",style: TextStyle(fontWeight: FontWeight.w600),),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(singleData.username!,style:const TextStyle(fontWeight: FontWeight.w600),),

                        const SizedBox(width: 100,),

                        const Text("Role :-",style: TextStyle(fontWeight: FontWeight.w600),),
                        const SizedBox(
                          width: 8,
                        ),
                        customRole(singleData.role!),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Full Name :",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 8,
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
                            enabled: isEnabled,
                            controller: nameController,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (text) {
                              fullName = text;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Full Name',
                              hintStyle: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text(
                        "Phone No. :",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 8,
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
                          enabled: isEnabled,
                          controller: phoneController,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (text) {
                            phoneNo = text;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone No.',
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                        ),
                      ),
                    ],),
                  ],
                ),
              ),
            )),
          ],
        ),
      );
    }
  }
}

Widget customRole(int role){
  if(role==2){
    return const Text("Admin",style: TextStyle(fontWeight: FontWeight.w600),);
  }else if(role==1){
    return const Text("Teacher",style: TextStyle(fontWeight: FontWeight.w600),);
  }else{
    return const Text("Student",style: TextStyle(fontWeight: FontWeight.w600),);
  }
}
