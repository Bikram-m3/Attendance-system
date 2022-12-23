import 'package:flutter/material.dart';

import '../RoutesPath/route_delegate.dart';
import '../RoutesPath/route_handeler.dart';

Widget SideBar(BuildContext context,String title){

  bool size=true;
  if(MediaQuery.of(context).size.width<=830){
    size=false;
  }

bool user=false,atten=false,setting=false,dash= false,depart=false,admin=false,userList=false,sem=false;


    switch(title){
      case 'add_users' :
        user=true;
        break;
      case 'attendance_details':
        atten=true;
        break;
      case 'users':
        userList=true;
        break;
      case 'department':
        depart=true;
        break;
      case 'sem_update':
        sem=true;
        break;
      case 'adminArea':
        admin=true;
        break;
      case 'settings':
        setting=true;
        break;
      default:
        dash=true;
        break;
  }




  return Container(
    height: MediaQuery.of(context).size.height,
    width: size ? 200 : 60,
    padding: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.6),
      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
    ),


    child: Column(
      mainAxisAlignment: size ? MainAxisAlignment.start : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

         ListTile(
          leading: const Icon(Icons.dashboard),
          title: setTitle(size,"Dashboard"),
           tileColor: dash ? Colors.black : Colors.blue,
           onTap: (){
             AppRouterDelegate().setPathName(RouteData.dashboard.name);
           },
        ),

        ListTile(
          leading: const Icon(Icons.view_comfortable_rounded),
          title: setTitle(size,"Attendance"),
          tileColor: atten ? Colors.black : Colors.blue,
          onTap: (){
            AppRouterDelegate().setPathName(RouteData.attendance_details.name);
          },
        ),

        ListTile(
          leading: const Icon(Icons.account_circle),
          title: setTitle(size,"Users"),
          tileColor: userList ? Colors.black : Colors.blue,
          onTap: (){
            AppRouterDelegate().setPathName(RouteData.users.name);
          },
        ),

        ListTile(
          leading: const Icon(Icons.add_circle_outline),
          title: setTitle(size,"Add Users"),
          tileColor: user ? Colors.black : Colors.blue,
          onTap: (){
            AppRouterDelegate().setPathName(RouteData.add_users.name);
          },
        ),

        ListTile(
          leading: const Icon(Icons.book),
          title: setTitle(size,"Subject"),
          tileColor: depart ? Colors.black : Colors.blue,
          onTap: (){
            AppRouterDelegate().setPathName(RouteData.department.name);
          },
        ),

        ListTile(
          leading: const Icon(Icons.upgrade),
          title: setTitle(size,"Semester"),
          tileColor: sem ? Colors.black : Colors.blue,
          onTap: (){
            AppRouterDelegate().setPathName(RouteData.semester.name);
          },
        ),

        ListTile(
          leading: const Icon(Icons.admin_panel_settings_rounded),
          title: setTitle(size,"Admin Area"),
          tileColor: admin ? Colors.black : Colors.blue,
          onTap: (){
            AppRouterDelegate().setPathName(RouteData.adminArea.name);
          },
        ),

        ListTile(
          leading: const Icon(Icons.settings),
          title: setTitle(size,"Settings"),
          tileColor: setting ? Colors.black : Colors.blue,
          onTap: (){
            AppRouterDelegate().setPathName(RouteData.settings.name);
          },
        ),

      ],
    ),
  );
}

Widget setTitle(bool size,String title){
  return size ? Text(title,style: const TextStyle(fontWeight: FontWeight.w400)) : const Text("");
}
