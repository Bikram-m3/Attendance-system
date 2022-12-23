import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
      ),
      child: const Center(
        child: Text("404 Page Not Found..!!!",style: TextStyle(
          fontWeight: FontWeight.w600
        ),),
      ),
    );
  }
}

