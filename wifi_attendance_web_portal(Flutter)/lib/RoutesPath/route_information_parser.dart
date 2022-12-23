import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/RoutesPath/route_path.dart';

/// parseRouteInformation will convert the given route information into parsed data to pass to RouterDelegate.
class RoutesInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    // converting the url into custom class T (RoutePath)
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return RoutePath.dashboard('/');
    }

    /// For query params- pass the complete path
    if (uri.queryParameters.isNotEmpty) {
      return RoutePath.otherPage(
          routeInformation.location!.replaceFirst("/", ""));
    }

    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();

      return RoutePath.otherPage(pathName);
    } else if (uri.pathSegments.length == 2) {
      final complexPath = "${uri.pathSegments.elementAt(0)}/${uri.pathSegments.elementAt(1)}";
      return RoutePath.otherPage(complexPath.toString());
    } else {
      return RoutePath.otherPage(uri.pathSegments.toString());
    }
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/error');
    }
    if (configuration.isDashboardPage) {
      return const RouteInformation(location: '/');
    }
    if (configuration.isOtherPage) {
      return RouteInformation(location: '/${configuration.pathName}');
    }

    return const RouteInformation(location: null);
  }
}
