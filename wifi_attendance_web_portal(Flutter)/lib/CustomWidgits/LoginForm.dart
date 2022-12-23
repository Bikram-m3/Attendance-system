import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/Pages/Dashboard.dart';
import 'package:wifi_attendance_web/Sessons/loginSesson.dart';

import '../ApiManagers/loginApi.dart';
import '../RoutesPath/route_delegate.dart';
import '../RoutesPath/route_handeler.dart';
import '../Sessons/Hive/hive_storage_service.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final focus = FocusNode();
  bool _hide = true;
  String username = '', password = '';
  int result = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 450,
      padding: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //username field................
            Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white.withOpacity(0.3),
              ),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                focusNode: focus,
                autofocus: true,
                controller: _userController,
                onChanged: (text) {
                  username = text;
                },
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.black38),
                  prefixIcon: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // password field...............
            Container(
              width: 400,
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white.withOpacity(0.3),
              ),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hide,
                controller: _passwordController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        _hide ? Icons.visibility : Icons.visibility_off,
                        size: 17,
                      ),
                      splashRadius: 10,
                      padding: const EdgeInsets.all(2),
                      onPressed: () {
                        setState(() {
                          _hide = !_hide;
                        });
                      },
                    )),
                onChanged: (text) {
                  password = text;
                },
              ),
            ),
            //login button..................
            InkWell(
              onTap: () {
                if (username.isNotEmpty && password.isNotEmpty) {
                  loginApi().usersLogin(username, password).then((value) => {
                        if(value.statusCode== 200){
                          pageLoader(value.body)

                        }else{
                          showDialog(context: context, builder:(context){
                            return AlertDialog(
                              content: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.not_interested,color: Colors.red,size: 80,),
                                    Text(value.body),
                                  ],
                                ),
                              ),
                              actions: [TextButton(
                                style:TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.teal,
                                  onSurface: Colors.grey,
                                ),
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState((){
                                    _userController.clear();
                                    _passwordController.clear();
                                  });
                                },
                              ),],
                            );
                          })


                        }
                      });

                  print(result);
                }
              },
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black87.withOpacity(0.7),
                ),
                child: const Center(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),

            // TextButton(
            //     onPressed: () { print("tapped.........");},
            //     child: const Text("Forgot Password ?",
            //         style: TextStyle(
            //             fontWeight: FontWeight.w600, color: Colors.black87)))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _userController;
    focus;
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _userController.clear();
      _userController.dispose();
      _passwordController.clear();
      _passwordController.dispose();
      focus.unfocus();
    }
    super.dispose();
  }

  pageLoader(String body) async {
    String uid=body.replaceAll('"', '');
    print(uid);
    loginSesson().save(uid);
    await HiveDataStorageService.logUserIn();

    AppRouterDelegate().setPathName(RouteData.dashboard.name);
     setState((){
      _userController.clear();
      _passwordController.clear();
    });
  }
}
