import 'package:http/http.dart' as http;
import '../Models/adminListModel.dart';
import '../Utilities/App_Cred.dart';

class filterApi{

  Future<List<adminListModel>> filterByRoll(String roll) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}filterUsersByRoll');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'roll': roll,
    });
    print(response.body);
    final adminModel = adminListModelFromJson(response.body);
    return adminModel;
  }

  Future<List<adminListModel>> filterByName(String name) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}filterUsersByName');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'name': name,
    });
    print(response.body);
    final adminModel = adminListModelFromJson(response.body);
    return adminModel;
  }

  Future<List<adminListModel>> filterByDepart(String depart,String shift,String batch) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}filterUsersBydepart');
    final response = await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'depart': depart,
      'shift': shift,
      'batch': batch
    });
    print(response.body);
    final adminModel = adminListModelFromJson(response.body);
    return adminModel;
  }

}