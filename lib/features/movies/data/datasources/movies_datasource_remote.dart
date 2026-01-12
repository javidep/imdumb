import 'package:dio/dio.dart';
import 'package:imdumb/core/api/api_helper.dart';
import 'package:imdumb/features/movies/data/models/category_model.dart';
import 'package:imdumb/features/movies/data/models/movies_model.dart';

class MoviesDatasourceRemote {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final Dio? dio;

  MoviesDatasourceRemote({this.dio});

  Future<List<CategoryModel>> getCategory() async {
    var url = 'https://dev-api-42989598603.us-central1.run.app/dev/get-movie-category';
    var response = await _helper.get(url);
    var data = response as List;
    List<CategoryModel> categoryModelList = data.map<CategoryModel>((e) => CategoryModel.fromJson(e)).toList();
    return categoryModelList;
  }

  Future<List<MoviesModel>> getMovies({required String categoryId}) async {
    var url = 'https://dev-api-42989598603.us-central1.run.app/dev/get-movies/$categoryId';
    var response = await _helper.get(url);
    var data = response as List;
    List<MoviesModel> moviesModelList = data.map<MoviesModel>((e) => MoviesModel.fromJson(e)).toList();
    return moviesModelList;
  }

}