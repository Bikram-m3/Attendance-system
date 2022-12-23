import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/CustomWidgits/SideBar.dart';
import 'package:wifi_attendance_web/Sessons/loginSesson.dart';

import '../RoutesPath/route_delegate.dart';
import '../RoutesPath/route_handeler.dart';
import '../Sessons/Hive/hive_storage_service.dart';



class Dashboard extends StatefulWidget {
  String routeName;

  Dashboard({Key? key, required this.routeName}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
            leading: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Image.asset('Assets/Images/logo.png',)),
            title: const Text('NCIT Dashboard', style: TextStyle(
              fontWeight: FontWeight.w600,
            ),),
            actions: [Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
        child: IconButton(
            onPressed: (){
              _logOut();
  }, icon: const Icon(Icons.logout),splashRadius: 20,splashColor: Colors.black38,))],
    ),
    body: Row(
    children: [
    SideBar(context,widget.routeName),
    Expanded(child: RouteHandeler().getRouteWidget(widget.routeName),)
    ],
    ),
    );
  }

  _logOut() async {
    await HiveDataStorageService.logOutUser();
    loginSesson().logout();
    AppRouterDelegate().setPathName(RouteData.login.name, loggedIn: false);
  }
}


