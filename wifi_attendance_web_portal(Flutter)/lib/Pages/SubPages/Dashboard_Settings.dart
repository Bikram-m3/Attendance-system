import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/Pages/SubPages/changePassword.dart';
import 'package:wifi_attendance_web/Pages/SubPages/sendNotifications.dart';

class DashboardSettings extends StatefulWidget {
  final String routeName;
  const DashboardSettings({Key? key,required this.routeName}) : super(key: key);

  @override
  State<DashboardSettings> createState() => _DashboardSettingsState();
}

class _DashboardSettingsState extends State<DashboardSettings> {
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
                  Text('Send Notifications',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                  Text('Change Password',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black)),
                ],),
            ),

            const Expanded(
              child: TabBarView(children: [
                sendNotifications(),
                changePassword(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
