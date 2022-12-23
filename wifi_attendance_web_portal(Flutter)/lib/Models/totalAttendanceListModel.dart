import 'dart:convert';

List<totalAttendanceListModel> totalAttendanceListModelFromJson(String str) => List<totalAttendanceListModel>.from(json.decode(str).map((x) => totalAttendanceListModel.fromJson(x)));

class totalAttendanceListModel{

  String? AUID;
  String? teacherID;
  int? sem;
  String? sub;
  int? year;
  int? month;
  int? day;
  String? depart;
  String? shift;
  String? batch;

  totalAttendanceListModel(
      this.AUID,
      this.teacherID,
      this.sem,
      this.sub,
      this.year,
      this.month,
      this.day,
      this.depart,
      this.shift,
      this.batch);

  totalAttendanceListModel.fromJson(Map<String, dynamic> json) {
    AUID = json['AUID'];
    teacherID = json['teacherID'];
    sem = json['sem'];
    sub = json['sub'];
    depart = json['depart'];
    shift = json['shift'];
    batch = json['Batch'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AUID'] = this.AUID;
    data['teacherID']=this.teacherID;
    data['sem']=this.sem;
    data['sub']=this.sub;
    data['depart']=this.depart;
    data['shift']=this.shift;
    data['Batch']=this.batch;
    data['day']=this.day;
    data['month']=this.month;
    data['year']=this.year;
    return data;
  }

}