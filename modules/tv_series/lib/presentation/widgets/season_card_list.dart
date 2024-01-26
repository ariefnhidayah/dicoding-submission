import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/presentation/pages/season_detail_page.dart';

class SeasonCardList extends StatelessWidget {
  final Season season;
  final int tvSeriesID;

  const SeasonCardList(
      {super.key, required this.season, required this.tvSeriesID});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            SeasonDetailPage.ROUTE_NAME,
            arguments: {
              "tv_series_id": tvSeriesID,
              "season_number": season.seasonNumber,
            },
          );
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: season.posterPath.isNotEmpty
                      ? '$BASE_IMAGE_URL${season.posterPath}'
                      : "https://snapbuilder.com/code_snippet_generator/image_placeholder_generator/500x750/808080/DDDDDD/Image%20Not%20Found",
                  width: 80,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80 - 16 - 50,
                  child: Text(
                    season.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: season.voteAverage / 2,
                      itemCount: 5,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: kMikadoYellow,
                      ),
                      itemSize: 14,
                    ),
                    Text(
                      '${season.voteAverage}',
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
