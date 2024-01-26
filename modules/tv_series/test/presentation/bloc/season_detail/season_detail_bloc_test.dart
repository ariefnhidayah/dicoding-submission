import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'season_detail_bloc_test.mocks.dart';

@GenerateMocks([GetDetailSeason])
void main() {
  late SeasonDetailBloc seasonDetailBloc;
  late MockGetDetailSeason mockGetDetailSeason;

  setUp(() {
    mockGetDetailSeason = MockGetDetailSeason();
    seasonDetailBloc = SeasonDetailBloc(mockGetDetailSeason);
  });

  test('initial state should be empty', () {
    expect(seasonDetailBloc.state, SeasonDetailEmpty());
  });

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'should be emit [Loading, HasData] when get data is successfully',
    build: () {
      when(mockGetDetailSeason.execute(1, 1))
          .thenAnswer((_) async => const Right(testSeasonDetail));
      return seasonDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchSeasonDetail(1, 1)),
    expect: () => [
      SeasonDetailLoading(),
      const SeasonDetailHasData(testSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockGetDetailSeason.execute(1, 1));
    },
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'should emit [Loading, Error] when get data is unsuccessfully',
    build: () {
      when(mockGetDetailSeason.execute(1, 1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seasonDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchSeasonDetail(1, 1)),
    expect: () => [
      SeasonDetailLoading(),
      const SeasonDetailError("Server Failure"),
    ],
    verify: (bloc) {
      verify(mockGetDetailSeason.execute(1, 1));
    },
  );
}
