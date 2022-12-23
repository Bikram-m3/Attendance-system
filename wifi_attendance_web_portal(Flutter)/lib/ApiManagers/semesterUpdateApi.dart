import 'package:http/http.dart' as http;

import '../Utilities/App_Cred.dart';

class SemsesterUpdateApi{

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