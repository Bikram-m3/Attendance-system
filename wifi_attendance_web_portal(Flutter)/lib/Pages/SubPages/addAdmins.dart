import 'package:flutter/material.dart';

import '../../ApiManagers/UsersApi.dart';

class addAdmins extends StatefulWidget {
  const addAdmins({Key? key}) : super(key: key);

  @override
  State<addAdmins> createState() => _addAdminsState();
}

class _addAdminsState extends State<addAdmins> {

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _rollController=TextEditingController();
  final TextEditingController _phoneController=TextEditingController();

  String fullName = '', departdropdownValue = 'BECE',rollNo = '',
      phoneNo = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //name textfield..........................................
          const Text(
            "Full Name :",
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
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),

          //admin id section.............................
          const SizedBox(
            height: 30,
          ),
          const Text(
            "ADMIN ID :",
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
                hintText: 'Admin ID No.(E.g:- 171221)',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),

          //Phone section.............................
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Phone No. :",
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
                hintText: 'Phone No.',
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
          ),

          //button section.......................................
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              String username= rollNo+'_a';
              String role='2';
              UsersApi().AddTeachers(fullName,username,rollNo,phoneNo,role).then((
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
                        setState((){
                          _nameController.clear();
                          _rollController.clear();
                          _phoneController.clear();
                        });
                      },
                    ),],
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
                  "Add Admin",
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
