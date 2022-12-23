import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/Pages/SubPages/addStudents.dart';
import 'package:wifi_attendance_web/Pages/SubPages/addTeachers.dart';

class AddUsers extends StatefulWidget {
  final String routeName;
  const AddUsers({Key? key, required this.routeName}) : super(key: key);
  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> with TickerProviderStateMixin {



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
                  Text('Add Students',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                  Text('Add Teachers',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black)),
                ],),
            ),

            const Expanded(
              child: TabBarView(children: [
                addStudents(),
                addTeachers(),
              ]),
            )
          ],
        ),
      ),
    );
  }

}
