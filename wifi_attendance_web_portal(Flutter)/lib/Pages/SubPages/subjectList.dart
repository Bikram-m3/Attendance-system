import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/ApiManagers/SubjectApi.dart';
import '../../Models/subjectModel.dart';

class subjectList extends StatefulWidget {
  const subjectList({Key? key}) : super(key: key);

  @override
  State<subjectList> createState() => _subjectListState();
}

class _subjectListState extends State<subjectList> {
  late Future<List<subjectModel>> _subjectData;

  int pageToggle = 0;

  late List<subjectModel> Dataa;
  late subjectModel singleData;
  late TextEditingController _shortnameController;

  var dropDownItems = ['1', '2', '3', '4', '5', '6', '7', '8'];
  var departmentItems = ['BECE', 'BECIVIL', 'BEIT', 'BCA', 'BEELX','BESE'];
  String fullName = '', dropdownValue = '', departdropdownValue = '',
  filterdropdownValue = '1',
  filterdepartdropdownValue = 'BECE';
  int loader=0;

  @override
  void initState() {
    super.initState();
    _loadData(filterdepartdropdownValue,filterdropdownValue);
  }

  _loadData(String depart,String sem) {
    if(loader==0){
      _subjectData = SubjectApi().fetchsubjects();
    }else{
      _subjectData = SubjectApi().filtersubjects(depart, sem);
    }
  }

  setValue() {
    if (dropdownValue == '') {
      dropdownValue = singleData.sem.toString();
      departdropdownValue = singleData.faculty.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pageToggle == 0) {
      return Center(
        child: FutureBuilder<List<subjectModel>>(
          future: _subjectData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          width: 30,
                        ),
                        const Text(
                          "Semester :",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        DropdownButton(
                            value: filterdropdownValue,
                            items: dropDownItems.map((String item) {
                              return DropdownMenuItem(value: item, child: Text(item));
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                filterdropdownValue = value!;
                              });
                            }),
                        const SizedBox(
                          width: 30,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            onSurface: Colors.grey,
                          ),
                          child: const Text('Filter'),
                          onPressed: () {
                            setState(() {
                              _loadData(filterdepartdropdownValue,filterdropdownValue);
                              loader=1;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.black38,
                    ),
                    const Center(
                      child: Text("No Subject Found !!!",style: TextStyle(fontWeight: FontWeight.w600),),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              Dataa = snapshot.data!;
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          width: 30,
                        ),
                        const Text(
                          "Semester :",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        DropdownButton(
                            value: filterdropdownValue,
                            items: dropDownItems.map((String item) {
                              return DropdownMenuItem(value: item, child: Text(item));
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                filterdropdownValue = value!;
                              });
                            }),
                        const SizedBox(
                          width: 30,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            onSurface: Colors.grey,
                          ),
                          child: const Text('Filter'),
                          onPressed: () {
                            setState(() {
                              _loadData(filterdepartdropdownValue,filterdropdownValue);
                              loader=1;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.black38,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: 600,
                        height: 525,
                        child: ListView.builder(
                            itemCount: Dataa.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 60, right: 60),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.account_balance_wallet,
                                      size: 40,
                                    ),
                                    title: Text(
                                      Dataa[index].subject ?? '',
                                      style: const TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.w200),
                                    ),
                                    trailing: SizedBox(
                                      width: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                setState(() {
                                                  pageToggle = 1;
                                                  singleData = Dataa[index];
                                                });
                                              }),
                                          IconButton(
                                              icon: const Icon(
                                                Icons.delete_forever,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  String? depart =
                                                          Dataa[index].faculty,
                                                      sem =
                                                          Dataa[index].sem.toString(),
                                                      sub = Dataa[index].subject;
                                                  SubjectApi()
                                                      .deletesubjects(
                                                          depart!, sem, sub!)
                                                      .then((value) => {
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
                                                                          Text(value),
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
                                                                              setState(() {
                                                                                _loadData(filterdepartdropdownValue,filterdropdownValue);
                                                                                pageToggle = 0;
                                                                              });
                                                                          Navigator.of(
                                                                                  context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                })
                                                          });
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


    } else {
      setValue();
      _shortnameController = TextEditingController(text: singleData.subject);
//for edit section......................................................................
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 400,
              child: Row(
                children: [
                  const Text(
                    "Semester :",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  DropdownButton(
                      value: dropdownValue,
                      items: dropDownItems.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!.toString();
                        });
                      }),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    "Department :",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  DropdownButton(
                      value: departdropdownValue,
                      items: departmentItems.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newvalue) {
                        setState(() {
                          departdropdownValue = newvalue!;
                        });
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Subject Short Name :",
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
                controller: _shortnameController,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(color: Colors.black),
                onChanged: (text) {
                  fullName = text.toUpperCase();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black38),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            //update button.........................................
            InkWell(
              onTap: () {
                String? olddepart = singleData.faculty,
                    oldsem = singleData.sem.toString(),
                    oldsub = singleData.subject;

                SubjectApi()
                    .editsubjects(departdropdownValue, dropdownValue, fullName,
                        olddepart!, oldsem, oldsub!)
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
                                          _loadData(filterdepartdropdownValue,filterdropdownValue);
                                          pageToggle = 0;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              })
                        });
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
                    "Update",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            //back button............................................
            InkWell(
              onTap: () {
                setState(() {
                  _loadData(filterdepartdropdownValue,filterdropdownValue);
                  pageToggle = 0;
                });
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
                    "Back",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
