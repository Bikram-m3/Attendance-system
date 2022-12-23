/// Class to define path structure
class RoutePath {
  final String? pathName;
  final bool isUnknown;

  RoutePath.dashboard(this.pathName) : isUnknown = false;
  RoutePath.otherPage(this.pathName) : isUnknown = false;
  RoutePath.unknown()
      : pathName = null,
        isUnknown = true;

  bool get isDashboardPage => pathName == null;
  bool get isOtherPage => pathName != null;
}
