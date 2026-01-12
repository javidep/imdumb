part of 'movies_bloc.dart';

@immutable
class MoviesState extends Equatable {
  const MoviesState({
    this.categoryModelList,
    this.moviesModelList,
    this.loading,
    this.message,
  });

  final List<CategoryModel>? categoryModelList;
  final List<MoviesModel>? moviesModelList;
  final bool? loading;
  final String? message;

  @override
  List<Object?> get props => [
    categoryModelList,
    moviesModelList,
    loading,
    message,
  ];

  static MoviesState get initialState => const MoviesState(
    categoryModelList: [],
    moviesModelList: [],
    loading: false,
    message: '',
  );

  MoviesState copyWith({
    List<CategoryModel>? categoryModelList,
    List<MoviesModel>? moviesModelList,
    bool? loading,
    String? message,
  }) {
    return MoviesState(
      categoryModelList: categoryModelList ?? this.categoryModelList,
      moviesModelList: moviesModelList ?? this.moviesModelList,
      loading: loading ?? this.loading,
      message: message ?? this.message,
    );
  }
}
