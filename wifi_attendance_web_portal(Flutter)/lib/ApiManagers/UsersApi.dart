import '../Models/adminListModel.dart';
import '../Utilities/App_Cred.dart';
import 'package:http/http.dart' as http;

class UsersApi{
  Future<String> AddTeachers(String name, String username, String roll,String phone,String role) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}teacherregister');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'name': name,
      'username': username,
      'roll': roll,
      'phone': phone,
      'role': role,
    });
    //print(response.body);
    String data = response.body;
    return data;
  }


  Future<String> AddStudents(String name, String username, String roll,String phone,String role,String depart,String shift,String batch,String sem) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}studentregister');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'name': name,
      'username': username,
      'roll': roll,
      'phone': phone,
      'role': role,
      'depart': depart,
      'shift': shift,
      'batch': batch,
      'sem': sem,
    });
    print(response.body);
    String data = response.body;
    return data;
  }


  Future<String> updateUsers(String name, String phone, String username) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}updateusers');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'name': name,
      'phone': phone,
      'username': username,
    });
    String data = response.body;
    return data;
  }

  Future<String> deleteUsers(String username) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}deleteusers');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'username': username
    });
    String data = response.body;
    return data;
  }

  Future<String> changeUsersPassword(String username) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}deleteusers');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'username': username
    });
    String data = response.body;
    return data;
  }

}