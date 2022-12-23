import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wifi_attendance_web/Utilities/App_Cred.dart';
import 'RoutesPath/route_delegate.dart';
import 'RoutesPath/route_information_parser.dart';
import 'Sessons/Hive/hive_storage_service.dart';
import 'firebase_options.dart';


void configOneSignel()
{
  OneSignal.shared.setAppId(AppCredential.ONESIGNAL_ID);

}


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  configOneSignel();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isUserLoggedIn = await HiveDataStorageService.getUser();
  runApp(App(isLoggedIn: isUserLoggedIn));
}

class App extends StatelessWidget {
  final bool isLoggedIn;
  const App({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NCIT Attendance Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: 'Open Sans')),
      routeInformationParser: RoutesInformationParser(),
      routerDelegate: AppRouterDelegate(isLoggedIn: isLoggedIn),

    );
  }
}
