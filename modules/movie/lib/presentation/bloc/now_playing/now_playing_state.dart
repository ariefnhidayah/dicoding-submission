part of 'now_playing_bloc.dart';

class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

final class NowPlayingEmpty extends NowPlayingState {}

final class NowPlayingLoading extends NowPlayingState {}

final class NowPlayingError extends NowPlayingState {
  final String message;

  const NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

final class NowPlayingHasData extends NowPlayingState {
  final List<Movie> result;

  const NowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}
