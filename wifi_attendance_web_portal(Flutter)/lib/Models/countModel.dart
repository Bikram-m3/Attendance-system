import 'dart:convert';

List<countModel> countModelFromJson(String str) => List<countModel>.from(json.decode(str).map((x) => countModel.fromJson(x)));

class countModel {
  String? faculty;
  int? count;

  countModel({this.faculty, this.count});

  countModel.fromJson(Map<String, dynamic> json) {
    faculty = json['faculty'];
    count = json['COUNT(*)'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['faculty'] = faculty;
    data['COUNT(*)'] = count;
    return data;
  }
}