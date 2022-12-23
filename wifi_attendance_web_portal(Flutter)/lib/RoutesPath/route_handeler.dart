import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/Pages/Dashboard.dart';
import 'package:wifi_attendance_web/Pages/SubPages/Dashboard_Add_Users.dart';
import 'package:wifi_attendance_web/Pages/SubPages/Dashboard_AdminArea.dart';
import 'package:wifi_attendance_web/Pages/SubPages/Dashboard_Attendance.dart';
import 'package:wifi_attendance_web/Pages/SubPages/Dashboard_Department.dart';
import 'package:wifi_attendance_web/Pages/SubPages/Dashboard_Settings.dart';
import 'package:wifi_attendance_web/Pages/SubPages/Dashboard_Users.dart';
import 'package:wifi_attendance_web/Pages/SubPages/semesterUpdaterPage.dart';

import '../Pages/SubPages/Dashboard_Main.dart';
import '../Pages/unknown_screen.dart';


enum RouteData {
  /// For routes for which we want to show unkown page that are not being parsed
  unkownRoute,

  /// For routes that are parsed but not data is found for them eg. /user/?userName=abc and abc doesnt exist
  notFound,

  login,
  dashboard,
  add_users,
  attendance_details,
  department,
  adminArea,
  semester,
  users,
  settings,


}

/// Class to handle route path related informations
class RouteHandeler {
  static final RouteHandeler _instance = RouteHandeler._();
  factory RouteHandeler() => _instance;
  RouteHandeler._();

  /// Returns [WidgetToRender, PathName]
  /// [WidgetToRender] - Renders specified widget
  /// [PathName] - Re-directs to [PathName] if invalid path is entered
  Widget getRouteWidget(String? routeName) {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        /// Getting first endpoint
        final pathName = uri.pathSegments.elementAt(0).toString();

        /// Getting route data for specified pathName
        routeData = RouteData.values.firstWhere(
                (element) => element.name == pathName,
            orElse: () => RouteData.notFound);

        print("2.....................................${routeData}");

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case RouteData.dashboard:
              return DashboardMain(
                routeName: routeName,
              );

            case RouteData.add_users:
              return AddUsers(
                routeName: routeName,
              );

            case RouteData.attendance_details:
              return DashboardAttendance(
                routeName: routeName,
              );

            case RouteData.department:
              return Department(
                routeName: routeName,
              );

            case RouteData.adminArea:
              return DashboardAdminArea(
                routeName: routeName,
              );

            case RouteData.users:
              return DashboardUsers(
                routeName: routeName,
              );

            case RouteData.semester:
              return semesterUpdaterPage(
                routeName: routeName,
              );

            case RouteData.settings:
              return DashboardSettings(
                routeName: routeName,
              );

            default:
              return DashboardMain(
                routeName: routeName,
              );
          }
        } else {
          return const UnknownScreen();
        }
      } else {
        return DashboardMain(
          routeName: routeName,
        );
      }
    } else {
      return const UnknownScreen();
    }
  }
}
