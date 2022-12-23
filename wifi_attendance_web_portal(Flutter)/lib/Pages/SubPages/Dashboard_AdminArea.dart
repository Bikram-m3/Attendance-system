import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/Pages/SubPages/adminList.dart';
import 'package:wifi_attendance_web/Pages/SubPages/subjectList.dart';

import 'addAdmins.dart';

class DashboardAdminArea extends StatefulWidget {
  final String routeName;
  const DashboardAdminArea({Key? key,required this.routeName}) : super(key: key);

  @override
  State<DashboardAdminArea> createState() => _DashboardAdminAreaState();
}

class _DashboardAdminAreaState extends State<DashboardAdminArea> {

  @override
  void initState() {
    super.initState();

    pageUpdate();

  }

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
                  Text('Admin List',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black)),
                  Text('Add Admins',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                ],),
            ),

            const Expanded(
              child: TabBarView(children: [
                adminList(),
                addAdmins(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  void pageUpdate() {
  }
}