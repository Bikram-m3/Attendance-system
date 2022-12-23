import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Utilities/App_Cred.dart';


class testApi{
  Future<String> attendanceList() async{
    String depart='BECE',sem='1',sub='C';
    List<String> listdata=['171221_m','171200_m','171211_m','171212_m'];
    List<String> deviceList=['2f324f97-56e5-42bf-8691-70f17b75a680','device-2'];

    var url=Uri.parse('${AppCredential.API_URL}attendanceUpdate');
    final response= await post(
      url,
      headers: <String, String>{
        'API-KEY': AppCredential.API_KEY,
        'Content-Type': 'application/json'
      },
      body:jsonEncode({
        'depart': depart,
        'sem':sem,
        'sub':sub,
        'teacherID':'17122_t',
        'year':'2022',
        'month':'9',
        'day':'10',
        'users': listdata,
        'devices': deviceList,
      }),
    );
    print(response.body);
    return response.body;
  }
}
