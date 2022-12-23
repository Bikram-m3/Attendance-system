import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wifi_attendance_web/Utilities/App_Cred.dart';
import '../Models/deviceIDModel.dart';
import '../Models/subjectModel.dart';

class SubjectApi {
  Future<List<subjectModel>> fetchsubjects() async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}course');
    final response =
        await client.get(url, headers: {'API-KEY': AppCredential.API_KEY});

    final subjectModel = subjectModelFromJson(response.body);

    return subjectModel;
  }

  Future<List<subjectModel>> filtersubjects(String depart, String sem) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}filtercourse');
    final response =
    await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'depart': depart,
      'sem': sem,
    });

    final subjectModel = subjectModelFromJson(response.body);

    return subjectModel;
  }

  Future<String> addsubjects(String depart, String sem, String sub) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}addsubjects');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'depart': depart,
      'sem': sem,
      'sub': sub
    });
    String data = response.body;
    return data;
  }

  Future<String> editsubjects(String depart, String sem, String sub,String olddepart, String oldsem, String oldsub) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}updatesubjects');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'depart': depart,
      'sem': sem,
      'sub': sub,
      'olddepart': olddepart,
      'oldsem': oldsem,
      'oldsub': oldsub,
    });
    String data = response.body;
    return data;
  }


  Future<String> deletesubjects(String depart, String sem, String sub) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}deletesubjects');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'depart': depart,
      'sem': sem,
      'sub': sub
    });
    String data = response.body;
    return data;
  }

  Future<List<deviceIDModel>> fetchUID() async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}deviceID');
    final response =
    await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
    });

    final deviceiDModel = deviceIDModelFromJson(response.body);

    print(deviceiDModel.length);
    return deviceiDModel;
  }

  Future<String> semesterUpdate(String depart, String shift, String oldsem, String newsem) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}updateuserssem');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'depart': depart,
      'shift': shift,
      'oldsem': oldsem,
      'newsem': newsem,
    });
    String data = response.body;
    return data;
  }

}
