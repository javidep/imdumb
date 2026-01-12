import 'package:imdumb/features/movies/data/datasources/movies_datasource_remote.dart';
import 'package:imdumb/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:imdumb/features/movies/domain/repositories/movies_repository.dart';
import 'package:imdumb/features/movies/domain/usecases/get_category_usecase.dart';
import 'package:imdumb/features/movies/domain/usecases/get_movies_usecase.dart';
import 'package:imdumb/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {

  ////////////////////BLOC////////////////////////
  // Movies Bloc
  sl.registerFactory(
    () => MoviesBloc(
      getCategoryUseCase: sl(),
      getMoviesUseCase: sl()
    ),
  );

  /////////////////////Use cases/////////////////////

  //movies use cases
  sl.registerLazySingleton(() => GetCategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMoviesUseCase(repository: sl()));

  /////////////////////Repositories/////////////////////
  // get category Repository
  sl.registerLazySingleton<MoviesRepositories>(
    () => MoviesRepositoriesImpl(
      moviesDatasourceRemote: sl(),
    ),
  );

  /////////////////////Data sources/////////////////////
  // Register business Data sources
  sl.registerLazySingleton<MoviesDatasourceRemote>(
        () => MoviesDatasourceRemote(),
  );

  ///////////////////External////////////////////////
  sl.registerLazySingleton(() => Dio());
}
