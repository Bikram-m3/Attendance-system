import 'package:http/http.dart' as http;
import 'package:wifi_attendance_web/Models/attendanceListModel.dart';

import '../Models/totalAttendanceListModel.dart';
import '../Utilities/App_Cred.dart';

class attendanceApi{

  Future<List<attendanceListModel>> getAttendanceList(String depart, String sem,String shift,String sub,String batch) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}departattendance');
    final response =
    await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'depart': depart,
      'sem': sem,
      'shift':shift,
      'sub':sub,
      'batch':batch,
    });

    final attendanceModel = attendanceListModelFromJson(response.body);
    print(attendanceModel[0].auid);
    return attendanceModel;
  }


  Future<List<attendanceListModel>> getSingleAttendanceList(String sem,String sub,String roll) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}rollattendance');
    final response =
    await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'roll': roll,
      'sem': sem,
      'sub':sub,
    });

    final attendanceModel = attendanceListModelFromJson(response.body);

    return attendanceModel;
  }


  Future<List<totalAttendanceListModel>> getTotalAttendanceList(String teacherID,String depart, String sem,String shift,String sub,String batch) async {
    var client = http.Client();
    var url = Uri.parse('${AppCredential.API_URL}gettotalattend');
    final response =
    await client.get(url, headers: {
      'API-KEY': AppCredential.API_KEY,
      'teacherID':teacherID,
      'depart': depart,
      'sem': sem,
      'shift':shift,
      'sub':sub,
      'batch':batch,
    });

    final totalattendanceModel = totalAttendanceListModelFromJson(response.body);
    return totalattendanceModel;
  }


}