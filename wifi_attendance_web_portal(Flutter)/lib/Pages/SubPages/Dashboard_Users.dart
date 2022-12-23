import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/ApiManagers/UsersApi.dart';
import 'package:wifi_attendance_web/ApiManagers/filterApi.dart';

import '../../Models/adminListModel.dart';

class DashboardUsers extends StatefulWidget {
  final String routeName;
  const DashboardUsers({Key? key,required this.routeName}) : super(key: key);

  @override
  State<DashboardUsers> createState() => _DashboardUsersState();
}

class _DashboardUsersState extends State<DashboardUsers> {


@override
void initState() {
}

final TextEditingController _nameController=TextEditingController();
final TextEditingController _rollController=TextEditingController();
final TextEditingController _batchController = TextEditingController();

var departmentItems = ['BECE', 'BECIVIL', 'BEIT', 'BCA', 'BEELX','BESE'];
var shiftdropDownItems = ['Morning','Day'];
var byItems = ['Roll or ID', 'Department', 'Name'];
String byValue = 'Roll or ID', Value = '',filterdepartdropdownValue = 'BECE',fullName = '',
    rollNo = '',shiftdropdownValue = 'Morning',batch = '';

late Future<List<adminListModel>> _filterData;
late List<adminListModel> Dataa;
late adminListModel singleData;

int Page=0;
bool isEnabled=false,isEdit=true;
String name='',phone='';


  @override
  Widget build(BuildContext context) {

    if(Page==0){
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Search By :",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 8,
            ),
            DropdownButton(
                value: byValue,
                items: byItems.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (String? newvalue) {
                  setState(() {
                    byValue = newvalue!;
                  });
                }),
            const SizedBox(
              width: 20,
            ),
            customOption(byValue),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              child: const Text('Filter'),
              onPressed: () {
                _rollController.clear();
                _batchController.clear();
                _nameController.clear();
                setState(() {
                  Page=1;
                  _loadData(byValue, rollNo, filterdepartdropdownValue, shiftdropdownValue, batch, fullName);
                });
              },
            ),
          ],
        ),
      );
    }else if(Page==1){
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
        ),
        child: Column(
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
                        Page=0;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<List<adminListModel>>(
                  future: _filterData,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child:const Center(child: Text("No Record Found !!!",style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      Dataa = snapshot.data!;
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
                                                        Page=2;
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
                                                                      Page=0;
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
              ),
            ),
          ],
        ),
      );
    }else{

      TextEditingController nameController = TextEditingController(text: singleData.name);
      TextEditingController phoneController=TextEditingController(text: singleData.phone);
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
        ),
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
                        Page=1;
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
                      if(name==''){
                        name=singleData.name!;
                        if(phone==''){
                          phone=singleData.phone!;
                        }
                      }else{if(phone==''){
                        phone=singleData.phone!;
                      }}
                      UsersApi().updateUsers(name, phone, singleData.username!)
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
                                        Page=0;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            })
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

                    checkUser(singleData.role!) ? const SizedBox(
                      height: 30,
                    ) : const SizedBox(),
                    checkUser(singleData.role!) ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Department :-",style: TextStyle(fontWeight: FontWeight.w600),),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(singleData.depart!,style:const TextStyle(fontWeight: FontWeight.w600),),

                        const SizedBox(width: 100,),

                        const Text("Semester :-",style: TextStyle(fontWeight: FontWeight.w600),),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(singleData.sem!,style:const TextStyle(fontWeight: FontWeight.w600),),

                        const SizedBox(width: 100,),

                        const Text("Shift :-",style: TextStyle(fontWeight: FontWeight.w600),),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(singleData.shift!,style:const TextStyle(fontWeight: FontWeight.w600),),

                      ],
                    ) : const SizedBox(),

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
                              name = text;
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
                              phone = text;
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

  //change filter option according to conditions...........................
Widget customOption(String options){
  if(options=='Department'){
    return Row(
      children: [
        const Text(
          "Department :",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 8,
        ),
        DropdownButton(
            value: filterdepartdropdownValue,
            items: departmentItems.map((String item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (String? newvalue) {
              setState(() {
                filterdepartdropdownValue = newvalue!;
              });
            }),
        const SizedBox(
          width: 10,
        ),
        //shift dropdown...........
        const Text(
          "Shift :",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 8,
        ),
        DropdownButton(
            value: shiftdropdownValue,
            items: shiftdropDownItems.map((String item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                shiftdropdownValue = value!;
              });
            }),
        const SizedBox(
          width: 10,
        ),
        //shift dropdown...........
        const Text(
          "Batch :",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          width: 100,
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54),
            color: Colors.white.withOpacity(0.3),
          ),
          child: TextField(
            autofocus: true,
            controller: _batchController,
            style: const TextStyle(color: Colors.black),
            onChanged: (text) {
              batch = text;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '(E.g:-2017)',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),

      ],
    );
  }else if(options=='Name'){
    return Row(
      children: [
        const Text(
          "Full Name :",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          width: 200,
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54),
            color: Colors.white.withOpacity(0.3),
          ),
          child: TextField(
            autofocus: true,
            controller: _nameController,
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
    );
  }else{
    return Row(
      children: [
        const Text(
          "Roll or ID :",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          width: 150,
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54),
            color: Colors.white.withOpacity(0.3),
          ),
          child: TextField(
            autofocus: true,
            controller: _rollController,
            textCapitalization: TextCapitalization.characters,
            style: const TextStyle(color: Colors.black),
            onChanged: (text) {
              rollNo = text;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '(E.g:- 171221)',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }
}

//data loader function...........................
void _loadData(String by,String roll,String depart,String shift,String batch,String name) {
  if(by=='Roll or ID'){
    _filterData = filterApi().filterByRoll(roll);
  }else if(by=='Department'){
    _filterData = filterApi().filterByDepart(depart, shift, batch);
  }else{
    _filterData = filterApi().filterByName(name);
  }
}

bool checkUser(int rolee){
    if(rolee==0){
      return true;
    }else{
      return false;
    }
}


  Widget customRole(int role) {
    if (role == 2) {
      return const Text(
        "Admin", style: TextStyle(fontWeight: FontWeight.w600),);
    } else if (role == 1) {
      return const Text(
        "Teacher", style: TextStyle(fontWeight: FontWeight.w600),);
    } else {
      return const Text(
        "Student", style: TextStyle(fontWeight: FontWeight.w600),);
    }
  }
}
