import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/tv_series.dart';

class SeasonDetailPage extends StatefulWidget {
  final int tvSeriesID;
  final int seasonNumber;

  static const ROUTE_NAME = '/season-detail';

  const SeasonDetailPage(
      {super.key, required this.tvSeriesID, required this.seasonNumber});

  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<SeasonDetailBloc>()
        .add(FetchSeasonDetail(widget.tvSeriesID, widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
        builder: (context, state) {
          if (state is SeasonDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonDetailHasData) {
            final season = state.result;
            return SafeArea(
              child: DetailContentSeason(
                season: season,
              ),
            );
          } else if (state is SeasonDetailError) {
            return Center(
              child: Text(
                state.message,
                key: const Key("error_message"),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContentSeason extends StatelessWidget {
  final SeasonDetail season;
  const DetailContentSeason({super.key, required this.season});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: season.posterPath.isNotEmpty
              ? 'https://image.tmdb.org/t/p/w500${season.posterPath}'
              : "https://snapbuilder.com/code_snippet_generator/image_placeholder_generator/500x750/808080/DDDDDD/Image%20Not%20Found",
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              season.name,
                              style: kHeading5,
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: season.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${season.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              season.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Episode",
                              style: kHeading6,
                            ),
                            Column(
                              children: [
                                for (Episode episode in season.episodes)
                                  EpisodeCardList(episode: episode),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
