import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wifi_attendance_web/ApiManagers/attendanceApi.dart';
import 'package:wifi_attendance_web/ApiManagers/testApi.dart';
import 'package:wifi_attendance_web/Models/attendanceListModel.dart';

import '../../ApiManagers/SubjectApi.dart';
import '../../Models/subjectModel.dart';
import '../../Models/totalAttendanceListModel.dart';

class DashboardAttendance extends StatefulWidget {
  final String routeName;

  const DashboardAttendance({Key? key, required this.routeName}) : super(key: key);

  @override
  State<DashboardAttendance> createState() => _DashboardAttendanceState();
}

class _DashboardAttendanceState extends State<DashboardAttendance> {
  int Page = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();

  var departmentItems = ['BECE', 'BECIVIL', 'BEIT', 'BCA', 'BEELX', 'BESE'];
  var dropDownItems = ['1', '2', '3', '4', '5', '6', '7', '8'];
  var shiftdropDownItems = ['Morning', 'Day'];
  var byItems = ['Department', 'Roll'];
  String byValue = 'Department',
      Value = '',
      filterdepartdropdownValue = 'BECE',
      fullName = '',
      rollNo = '',
      shiftdropdownValue = 'Morning',
      batch = '',
      filterdropdownValue = '1',
      subValue = '';

  late Future<List<attendanceListModel>> _attendanceData;
  late Future<List<attendanceListModel>> _singleAttendanceData;
  List<attendanceListModel> Dataa = [];
  List<attendanceListModel> sortedData = [];
  late attendanceListModel singleData;
  late Future<List<subjectModel>> _subjectData;
  List<subjectModel> subData = [];
  List<attendanceListModel> filterData = [];
  List<attendanceListModel> singleSotedData = [];
  List<totalAttendanceListModel> singleTotalData=[];

  List<attendanceListModel> singleFilterData = [];
  List<totalAttendanceListModel> totalAttendanceData = [];

  int set = 0,totalPresent=0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData(byValue, rollNo, filterdepartdropdownValue, shiftdropdownValue,
        batch, filterdropdownValue, subValue);
  }

  @override
  Widget build(BuildContext context) {
    if (Page == 0) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<subjectModel>>(
              future: _subjectData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: Text("Failed to load subjects..!!!",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  );
                } else if (snapshot.hasData) {
                  subData = snapshot.data!;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
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
                                  return DropdownMenuItem(
                                      value: item, child: Text(item));
                                }).toList(),
                                onChanged: (String? newvalue) {
                                  setState(() {
                                    byValue = newvalue!;
                                  });
                                }),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        customOption(byValue),
                        const SizedBox(
                          height: 40,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            onSurface: Colors.grey,
                          ),
                          child: const Text('Filter'),
                          onPressed: () {
                            _nameController.clear();
                            _rollController.clear();
                            _batchController.clear();

                            if (byValue == 'Department') {
                              setState(() {
                                Page = 1;
                                _loadData(
                                    byValue,
                                    rollNo,
                                    filterdepartdropdownValue,
                                    shiftdropdownValue,
                                    batch,
                                    filterdropdownValue,
                                    subValue);
                              });
                              //Future<List<attendanceListModel>> data= attendanceApi().getAttendanceList(filterdepartdropdownValue, '1', shiftdropdownValue, 'C', batch);
                            }else{
                              setState(() {
                                Page = 1;
                                _loadData(
                                    byValue,
                                    rollNo,
                                    filterdepartdropdownValue,
                                    shiftdropdownValue,
                                    batch,
                                    filterdropdownValue,
                                    subValue);
                              });
                            }
                          },
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
          ],
        ),
      );
    } else if (Page == 1) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.only(left: 40, right: 40),
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
                        Page = 0;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<List<attendanceListModel>>(
                  future: _attendanceData,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: Text("No Record Found !!!",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      Dataa.clear();
                      Dataa = snapshot.data!;
                      print(Dataa.length);
                      FilterData(Dataa);

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: Colors.black38,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Department :- ${filterData[0].depart}" ??
                                        '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Semester :- ${filterData[0].sem}" ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Subject :- ${filterData[0].sub}" ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Shift :- ${filterData[0].shift}" ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Batch :- ${filterData[0].batch}" ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: Colors.black38,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: SizedBox(
                                width: 760,
                                height: 540,
                                child: ListView.builder(
                                    itemCount: filterData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 60, right: 60),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            leading: const Icon(
                                              Icons.account_circle_rounded,
                                              size: 38,
                                            ),
                                            title: Text(
                                              "${filterData[index].name} ( ${filterData[index].roll} )      Total P. = ${countAtten(filterData[index].roll!)}" ??
                                                  '',
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                            trailing: SizedBox(
                                              width: 60,
                                              child: Row(
                                                children: [
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.white,
                                                      backgroundColor:
                                                          Colors.teal,
                                                      onSurface: Colors.grey,
                                                    ),
                                                    child: const Text('View'),
                                                    onPressed: () {
                                                      setState(() {
                                                        Page = 2;
                                                        selectedIndex = index;
                                                        totalPresent=countAtten(filterData[index].roll!);
                                                        sortData(filterData[index].roll!);
                                                        singleData =
                                                            filterData[index];
                                                        singleDataafilter(
                                                            filterData[index]
                                                                .roll!);

                                                      });
                                                    },
                                                  ),
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
    } else {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.only(left: 40, right: 40),
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
                        Page = 1;

                        _loadData(
                            byValue,
                            filterData[0].roll.toString(),
                            filterData[0].depart!,
                            filterData[0].shift!,
                            filterData[0].batch!,
                            filterData[0].sem.toString(),
                            filterData[0].sub!);
                      });
                    },
                  ),
                ],
              ),
            ),

            Expanded(
                child:Center(
                  child: FutureBuilder<List<totalAttendanceListModel>>(
                    future: attendanceApi().getTotalAttendanceList(singleData.teacherID!, singleData.depart!, singleData.sem.toString(),singleData.shift!,singleData.sub!, singleData.batch!),
                    builder: (context,snapshot){
                      if(snapshot.hasError){
                        return Container();
                      }else if(snapshot.hasData){
                        totalAttendanceData=snapshot.data!;
                        sortTotalAttendance();
                        return Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 2,
                                    color: Colors.black38,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Department :- ${filterData[0].depart}" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Semester :- ${filterData[0].sem}" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Subject :- ${filterData[0].sub}" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Shift :- ${filterData[0].shift}" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "TeacherID :- ${filterData[0].teacherID}" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 2,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 2,
                                    color: Colors.black38,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Name :- ${filterData[selectedIndex].name}" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          "Roll :- ${filterData[selectedIndex].roll}" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          "Total P. :-  $totalPresent" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          "Total class :-  ${totalAttendanceData.length}" ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 2,
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: SizedBox(
                                width: 760,
                                height: 440,
                                child: ListView.builder(
                                    itemCount: singleTotalData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 60, right: 60),
                                        child: Container(
                                          margin:
                                          const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              "Month :- ${monthSelector(singleTotalData[index].month!)} ( ${singleTotalData[index].year} )  ,   T.P. = ${presentCounter(singleTotalData[index].month!)} ,  T.C. = ${totalClassCounter(singleTotalData[index].month!)}" ??
                                                  '',
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        );

                      }else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
            ),
          ],
        ),
      );
    }
  }

  //data loader function...........................
  void _loadData(String by, String roll, String depart, String shift,
      String batch, String sem, String sub) {
    if (Page == 0) {
      _subjectData = SubjectApi().fetchsubjects();
    } else if (Page == 1) {
      if (by == 'Department') {
        _attendanceData =
            attendanceApi().getAttendanceList(depart, sem, shift, sub, batch);
      } else {
        _attendanceData = attendanceApi().getSingleAttendanceList(sem, sub, roll);
      }
    } else {

    }
  }

  //change filter option according to conditions...........................
  Widget customOption(String options) {
    if (set == 0) {
      subValue = getSubs().first;
      set = 1;
    }
    if (options == 'Department') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
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

              //semester dropdown....................
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
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //subject dropdown....................
              const Text(
                "Subject :",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                  value: subValue,
                  items: getSubs().map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      subValue = value.toString();
                    });
                  }),
              const SizedBox(
                width: 30,
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
          ),
        ],
      );
    } else {
      return Column(
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

              //semester dropdown....................
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

              //subject dropdown....................
              const Text(
                "Subject :",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              DropdownButton(
                  value: subValue,
                  items: getSubs().map((item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      subValue = value.toString();
                    });
                  }),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Roll :",
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
          ),
        ],
      );
    }
  }

  List<String> getSubs() {
    List<String> temp = [];
    if (subData.isNotEmpty) {
      for (int i = 0; i < subData.length; i++) {
        if (subData[i].faculty == filterdepartdropdownValue) {
          if (subData[i].sem.toString() == filterdropdownValue) {
            temp.add(subData[i].subject!);
          }
        }
      }
    }
    if (temp.isEmpty) {
      temp.add(" ");
      return temp;
    } else {
      return temp;
    }
  }

  void FilterData(List<attendanceListModel> dat) {
    filterData.clear();
    for (int i = 0; i < dat.length; i++) {
      int c = 0;
      if (filterData.isEmpty) {
        filterData.add(dat[i]);
      } else {
        for (int y = 0; y < filterData.length; y++) {
          if (dat[i].roll.toString() == filterData[y].roll.toString()) {
            c++;
          }
        }
        if (c == 0) {
          filterData.add(dat[i]);
        }
      }
    }
  }

  int countAtten(int roll) {
    int c = 0;
    for (int i = 0; i < Dataa.length; i++) {
      if (Dataa[i].roll == roll) {
        c++;
      }
    }
    return c;
  }

  void singleDataafilter(int roll) {
    for (int i = 0; i < Dataa.length; i++) {
      if (Dataa[i].roll == roll) {
        singleFilterData.add(Dataa[i]);
      }
    }
  }

  void sortData(int roll){
    singleSotedData.clear();
    sortedData.clear();
    for(int i=0;i<Dataa.length;i++){
      if(Dataa[i].roll==roll){
        sortedData.add(Dataa[i]);
      }

    }
    sortedData.sort((a,b)=>a.month!.compareTo(b.month!));


    for(int i=0;i<sortedData.length;i++){
      int c = 0;
      if (singleSotedData.isEmpty) {
        singleSotedData.add(sortedData[i]);
      }else {
        for (int y = 0; y < singleSotedData.length; y++) {

          if (sortedData[i].month == singleSotedData[y].month ) {
            c++;
          }
        }
        if (c == 0) {
          singleSotedData.add(sortedData[i]);
        }
      }
    }
  }

  void sortTotalAttendance(){
    singleTotalData.clear();
    totalAttendanceData.sort((a,b)=>a.month!.compareTo(b.month!));

    for(int i=0;i<totalAttendanceData.length;i++){
      int c = 0;
      if (singleTotalData.isEmpty) {
        singleTotalData.add(totalAttendanceData[i]);
      }else {
        for (int y = 0; y < singleTotalData.length; y++) {

          if (totalAttendanceData[i].month == singleTotalData[y].month ) {
            c++;
          }
        }
        if (c == 0) {
          singleTotalData.add(totalAttendanceData[i]);
        }
      }
    }
    print("4..............${singleTotalData.length}");

  }



  String monthSelector(int month){
    String temp;
    switch(month){
      case 1:
        temp='January';
            return temp;
            break;
      case 2:
        temp='February';
        return temp;
        break;
      case 3:
        temp='March';
        return temp;
        break;
      case 4:
        temp='April';
        return temp;
        break;
      case 5:
        temp='May';
        return temp;
        break;
      case 6:
        temp='June';
        return temp;
        break;
      case 7:
        temp='July';
        return temp;
        break;
      case 8:
        temp='August';
        return temp;
        break;
      case 9:
        temp='September';
        return temp;
        break;
      case 10:
        temp='October';
        return temp;
        break;
      case 11:
        temp='November';
        return temp;
        break;
      default :
        temp='December';
        return temp;
        break;
    }
  }
  
  int presentCounter(int month){
    int counter=0;
    for(int i=0;i<sortedData.length;i++){
      if(sortedData[i].month==month){
        counter++;
      }
    }
    return counter;
  }

  int totalClassCounter(int month){
    int counter=0;
    for(int i=0;i<totalAttendanceData.length;i++){
      if(totalAttendanceData[i].month==month){
        counter++;
      }
    }
    return counter;
  }


}
