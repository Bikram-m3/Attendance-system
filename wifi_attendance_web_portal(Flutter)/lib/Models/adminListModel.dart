import 'dart:convert';

List<adminListModel> adminListModelFromJson(String str) => List<adminListModel>.from(json.decode(str).map((x) => adminListModel.fromJson(x)));

class adminListModel {
  String? name;
  String? username;
  int? roll;
  String? phone;
  int? role;
  String? uid;
  String? sem;
  String? depart;
  String? shift;

  adminListModel(
      {this.name, this.username, this.roll, this.phone, this.role, this.uid,this.sem,this.depart,this.shift});

  adminListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    roll = json['roll'];
    phone = json['phone'];
    role = json['role'];
    uid = json['uid'];
    shift = json['shift'];
    sem = json['sem'];
    depart = json['faculty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['roll'] = this.roll;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['uid'] = this.uid;
    data['shift'] = this.shift;
    data['sem'] = this.sem;
    data['faculty'] = this.depart;
    return data;
  }
}