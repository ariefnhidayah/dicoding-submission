part of 'popular_movies_bloc.dart';

class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchPopularMovies extends PopularMoviesEvent {}
