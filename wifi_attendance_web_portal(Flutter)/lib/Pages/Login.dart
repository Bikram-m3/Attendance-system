import 'package:flutter/material.dart';
import 'package:wifi_attendance_web/CustomWidgits/LoginForm.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 70,),
              //for logo only.........................
              Container(
                height: 150,
                width: 150,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Image.asset('Assets/Images/logo.png',fit: BoxFit.fill,),
              ),

              //app name..............................
              const Text('NCIT Attendance Portal',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),),

              const SizedBox(height: 20,),

              //for login form.............................
              const LoginForm(),

              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

