import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:imdumb/features/movies/data/models/category_model.dart';
import 'package:imdumb/features/movies/data/models/movies_model.dart';
import 'package:imdumb/features/movies/domain/usecases/get_category_usecase.dart';
import 'package:imdumb/features/movies/domain/usecases/get_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetCategoryUseCase getCategoryUseCase;
  final GetMoviesUseCase getMoviesUseCase;
  MoviesBloc(
      {
        required this.getCategoryUseCase,
        required this.getMoviesUseCase,
      }) : super(MoviesState.initialState) {

    on<GetCategoryEvent>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        List<CategoryModel> categoryModelList = await getCategoryUseCase();
        emit(state.copyWith(
            categoryModelList: categoryModelList,
            loading: false
        ));
      } catch (e) {
        emit(state.copyWith(
          loading: false,
          message: e.toString(),
        ));
      }
    });
    on<GetMoviesEvent>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        List<MoviesModel> moviesModelList = await getMoviesUseCase(categoryId: event.categoryId);
        emit(state.copyWith(
            moviesModelList: moviesModelList,
            loading: false
        ));
      } catch (e) {
        emit(state.copyWith(
          loading: false,
          message: e.toString(),
        ));
      }
    });
  }
}