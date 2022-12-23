import 'dart:convert';

List<attendanceListModel> attendanceListModelFromJson(String str) => List<attendanceListModel>.from(json.decode(str).map((x) => attendanceListModel.fromJson(x)));

class attendanceListModel{

  String? username;
  int? roll;
  String? name;
  String? teacherID;
  int? attend;
  int? sem;
  String? sub;
  int? year;
  int? month;
  int? day;
  String? depart;
  String? shift;
  String? batch;
  String? auid;

  attendanceListModel(
      this.username,
      this.roll,
      this.name,
      this.teacherID,
      this.attend,
      this.sem,
      this.sub,
      this.year,
      this.month,
      this.day,
      this.depart,
      this.shift,
      this.batch,
      this.auid);

  attendanceListModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    roll = json['roll'];
    name = json['name'];
    teacherID = json['teacherID'];
    attend = json['attend'];
    sem = json['sem'];
    sub = json['sub'];
    year = json['year'];
    month = json['month'];
    day = json['day'];
    shift = json['shift'];
    depart = json['depart'];
    batch = json['Batch'];
    auid = json['AUID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['roll'] = this.roll;
    data['name'] = this.name;
    data['teacherID']=this.teacherID;
    data['attend']=this.attend;
    data['sem']=this.sem;
    data['sub']=this.sub;
    data['year']=this.year;
    data['month']=this.month;
    data['day']=this.day;
    data['shift']=this.shift;
    data['depart']=this.depart;
    data['Batch']=this.batch;
    data['AUID']=this.auid;
    return data;
  }

}