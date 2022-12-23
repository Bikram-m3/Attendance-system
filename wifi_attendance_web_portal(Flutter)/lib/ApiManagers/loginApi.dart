import 'package:http/http.dart' as http;

import '../Utilities/App_Cred.dart';

class loginApi{
  Future<http.Response> usersLogin(String username,String password) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}weblogin');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'username': username,
      'password': password,
    });
    String data = response.body;
    return response;
  }
}