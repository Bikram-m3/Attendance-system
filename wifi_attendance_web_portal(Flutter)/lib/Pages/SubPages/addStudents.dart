import 'package:flutter/material.dart';

import '../../ApiManagers/UsersApi.dart';

class addStudents extends StatefulWidget {
  const addStudents({Key? key}) : super(key: key);

  @override
  State<addStudents> createState() => _addStudentsState();
}

class _addStudentsState extends State<addStudents> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();

  var dropDownItems = ['Morning', 'Day'];
  var departmentItems = ['BECE', 'BECIVIL', 'BEIT', 'BCA', 'BEELX','BESE'];
  String fullName = '',
      rollNo = '',
      phoneNo = '',
      batch = '',
      dropdownValue = 'Morning',
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
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  "Shift :",
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
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Student Full Name :",
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
              controller: _nameController,
              style: const TextStyle(color: Colors.black),
              onChanged: (text) {
                fullName = text;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Student Full Name',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Student Roll No. :",
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
              controller: _rollController,
              textCapitalization: TextCapitalization.characters,
              style: const TextStyle(color: Colors.black),
              onChanged: (text) {
                rollNo = text;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Student Roll No.(E.g:- 171221)',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Student Batch No. :",
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
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Student Phone No. :",
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
              controller: _phoneController,
              style: const TextStyle(color: Colors.black),
              onChanged: (text) {
                phoneNo = text;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Student Phone No.',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              String username;
              if (dropdownValue == 'Morning') {
                username = rollNo + '_m';
              } else {
                username = rollNo + '_d';
              }
              String role = '0';
              String sem='1';
              UsersApi()
                  .AddStudents(fullName, username, rollNo, phoneNo, role,
                      departdropdownValue, dropdownValue,batch,sem)
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      setState(() {
                                        _nameController.clear();
                                        _rollController.clear();
                                        _phoneController.clear();
                                        _batchController.clear();
                                      });
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
                  "Add Student",
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
