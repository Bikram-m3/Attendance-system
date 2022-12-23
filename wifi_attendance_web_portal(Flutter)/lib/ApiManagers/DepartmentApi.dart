import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wifi_attendance_web/Models/courseModel.dart';
import 'package:wifi_attendance_web/Utilities/App_Cred.dart';


class DepartmentApi{

   Future<List<DepartModel>> fetchDepartment() async {

    var client =http.Client();
    var url = Uri.parse('${AppCredential.API_URL}depart');
    final response = await client.get(
        url, headers: {'API-KEY': AppCredential.API_KEY});

    final departModel = departModelFromJson(response.body);
    print(departModel.first.dipart);
    return departModel;
  }
}