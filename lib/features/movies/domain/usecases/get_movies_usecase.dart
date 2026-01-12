import 'package:imdumb/features/movies/data/models/movies_model.dart';
import 'package:imdumb/features/movies/domain/repositories/movies_repository.dart';

class GetMoviesUseCase {
  GetMoviesUseCase({
    required MoviesRepositories repository,
  }) : _repository = repository;

  final MoviesRepositories _repository;

  Future<List<MoviesModel>> call({required String categoryId}) async {
    return await _repository.getMovies(categoryId: categoryId);
  }
}