import 'package:imdumb/features/movies/data/models/category_model.dart';
import 'package:imdumb/features/movies/data/models/movies_model.dart';

abstract class MoviesRepositories {
  Future<List<CategoryModel>> getCategory();
  Future<List<MoviesModel>> getMovies({required String categoryId});
}