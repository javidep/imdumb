import 'package:imdumb/features/movies/data/models/category_model.dart';
import 'package:imdumb/features/movies/domain/repositories/movies_repository.dart';

class GetCategoryUseCase {
  GetCategoryUseCase({
    required MoviesRepositories repository,
  }) : _repository = repository;

  final MoviesRepositories _repository;

  Future<List<CategoryModel>> call() async {
    return await _repository.getCategory();
  }
}