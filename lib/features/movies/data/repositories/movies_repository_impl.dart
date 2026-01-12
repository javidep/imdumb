import 'package:imdumb/features/movies/data/datasources/movies_datasource_remote.dart';
import 'package:imdumb/features/movies/data/models/movies_model.dart';
import 'package:imdumb/features/movies/data/models/category_model.dart';
import 'package:imdumb/features/movies/domain/repositories/movies_repository.dart';

class  MoviesRepositoriesImpl implements MoviesRepositories {
  final MoviesDatasourceRemote moviesDatasourceRemote;

  MoviesRepositoriesImpl({
    required this.moviesDatasourceRemote,
  });

  @override
  Future<List<CategoryModel>> getCategory() async {
    return await moviesDatasourceRemote.getCategory();
  }

  @override
  Future<List<MoviesModel>> getMovies({required String categoryId}) async {
    return await moviesDatasourceRemote.getMovies(categoryId: categoryId);
  }

}