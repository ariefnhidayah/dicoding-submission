part of 'season_detail_bloc.dart';

class SeasonDetailState extends Equatable {
  const SeasonDetailState();

  @override
  List<Object> get props => [];
}

final class SeasonDetailEmpty extends SeasonDetailState {}

final class SeasonDetailLoading extends SeasonDetailState {}

final class SeasonDetailError extends SeasonDetailState {
  final String message;

  const SeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}

final class SeasonDetailHasData extends SeasonDetailState {
  final SeasonDetail result;

  const SeasonDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
