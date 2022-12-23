import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/Pages/SubPages/subjectList.dart';
import 'package:wifi_attendance_web/Pages/SubPages/addSubjects.dart';

class Department extends StatefulWidget {
  const Department({Key? key,required this.routeName}) : super(key: key);
  final String routeName;

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
              ),
              child: const TabBar(
                indicator: BoxDecoration(
                  color: Colors.black45,
                ),
                tabs: [
                  Text('Subject List',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black)),
                  Text('Add Subjects',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                ],),
            ),

            Expanded(
              child: TabBarView(children: [
                subjectList(),
                addSubjects(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
