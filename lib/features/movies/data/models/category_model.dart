import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  final String categoryId;
  final String name;
  final String posterUrl;

  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.posterUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryId: json["categoryId"],
    name: json["name"],
    posterUrl: json["posterUrl"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "name": name,
    "posterUrl": posterUrl,
  };
}