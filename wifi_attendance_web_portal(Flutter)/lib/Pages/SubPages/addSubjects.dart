import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/ApiManagers/DepartmentApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wifi_attendance_web/ApiManagers/SubjectApi.dart';
import 'package:wifi_attendance_web/Models/courseModel.dart';
import 'package:wifi_attendance_web/Utilities/App_Cred.dart';

class addSubjects extends StatefulWidget {
  const addSubjects({Key? key}) : super(key: key);

  @override
  State<addSubjects> createState() => _addSubjectsState();
}

class _addSubjectsState extends State<addSubjects> {
  @override
  void initState() {
    super.initState();
  }

  var dropDownItems = ['1', '2', '3', '4', '5', '6', '7', '8'];
  var departmentItems = ['BECE', 'BECIVIL', 'BEIT', 'BCA', 'BEELX','BESE'];
  late String Result;

  String fullName = '',
      shortName = '',
      dropdownValue = '1',
      departdropdownValue = 'BECE';

  @override
  Widget build(BuildContext context) {
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
                        dropdownValue = value!;
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
              textCapitalization: TextCapitalization.characters,
              style: const TextStyle(color: Colors.black),
              onChanged: (text) {
                shortName = text.toUpperCase();
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Subject Short Name',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              if (shortName.isEmpty) {} else {
                SubjectApi().addsubjects(
                    departdropdownValue, dropdownValue, shortName).then((
                    value) => {
                      showDialog(context: context, builder:(context){
                        return AlertDialog(
                          content: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.cloud_done_rounded,color: Colors.green,size: 80,),
                                Text(value),
                              ],
                            ),
                          ),
                          actions: [TextButton(
                            style:TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),],
                        );
                      })
                });
              }
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
                  "Add Subject",
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

