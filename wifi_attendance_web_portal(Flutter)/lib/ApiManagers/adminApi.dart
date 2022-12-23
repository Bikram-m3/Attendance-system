
import 'package:http/http.dart' as http;
import '../Models/adminListModel.dart';
import '../Models/countModel.dart';
import '../Utilities/App_Cred.dart';

class adminApi{
  Future<List<adminListModel>> fetchAdminList() async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}adminList');
    final response =
    await client.get(url, headers: {'API-KEY': AppCredential.API_KEY});
    //print(response.body);
    final adminModel = adminListModelFromJson(response.body);

    print(adminModel);
    return adminModel;
  }


  Future<http.Response> changePass(String uid,String cPass,String Npass) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}changepassword');
    final response =
    await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'username': uid,
      'oldpassword': cPass,
      'newpassword': Npass,
    });
    return response;
  }


  Future<List<countModel>> countList() async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}counts');
    final response =
    await client.get(url, headers: {'API-KEY': AppCredential.API_KEY});

    final counModel = countModelFromJson(response.body);


    return counModel;
  }
}