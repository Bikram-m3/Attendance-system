import 'dart:convert';

List<deviceIDModel> deviceIDModelFromJson(String str) => List<deviceIDModel>.from(json.decode(str).map((x) => deviceIDModel.fromJson(x)));

class deviceIDModel {
  deviceIDModel({
    this.uid,
  });

  String? uid;

  factory deviceIDModel.fromJson(Map<String, dynamic> json) => deviceIDModel(
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
  };
}