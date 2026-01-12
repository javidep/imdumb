import 'dart:convert';

List<MoviesModel> moviesModelFromJson(String str) => List<MoviesModel>.from(json.decode(str).map((x) => MoviesModel.fromJson(x)));

String moviesModelToJson(List<MoviesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviesModel {
  final String movieId;
  final String recommend;
  final List<String> actors;
  final String categoryId;
  final String des;
  final List<String> images;
  final String name;
  final int score;

  MoviesModel({
    required this.movieId,
    required this.recommend,
    required this.actors,
    required this.categoryId,
    required this.des,
    required this.images,
    required this.name,
    required this.score,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
    movieId: json["movieId"],
    recommend: json["Recommend"],
    actors: List<String>.from(json["actors"].map((x) => x)),
    categoryId: json["categoryId"],
    des: json["des"],
    images: List<String>.from(json["images"].map((x) => x)),
    name: json["name"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "movieId": movieId,
    "Recommend": recommend,
    "actors": List<dynamic>.from(actors.map((x) => x)),
    "categoryId": categoryId,
    "des": des,
    "images": List<dynamic>.from(images.map((x) => x)),
    "name": name,
    "score": score,
  };
}