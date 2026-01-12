part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCategoryEvent extends MoviesEvent {}

class GetMoviesEvent extends MoviesEvent {
  final String categoryId;
  GetMoviesEvent({
    required this.categoryId
  });
}