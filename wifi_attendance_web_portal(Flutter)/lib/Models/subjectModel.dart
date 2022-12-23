import 'dart:convert';

List<subjectModel> subjectModelFromJson(String str) => List<subjectModel>.from(json.decode(str).map((x) => subjectModel.fromJson(x)));

class subjectModel {
  String? faculty;
  int? sem;
  String? subject;

  subjectModel({this.faculty, this.sem, this.subject});

  subjectModel.fromJson(Map<String, dynamic> json) {
    faculty = json['faculty'];
    sem = json['sem'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['faculty'] = faculty;
    data['sem'] = sem;
    data['subject'] = subject;
    return data;
  }
}

