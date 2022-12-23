import 'dart:convert';

List<DepartModel> departModelFromJson(String str) => List<DepartModel>.from(json.decode(str).map((x) => DepartModel.fromJson(x)));

class DepartModel {
  DepartModel({
    required this.dipart,
  });

  String dipart;

  factory DepartModel.fromJson(Map<String, dynamic> json) => DepartModel(
    dipart: json["dipart"],
  );

  Map<String, dynamic> toJson() => {
    "dipart": dipart,
  };
}
