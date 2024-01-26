import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EpisodeCardList extends StatelessWidget {
  final Episode episode;

  const EpisodeCardList({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: episode.stillPath.isNotEmpty
                      ? '$BASE_IMAGE_URL${episode.stillPath}'
                      : 'https://snapbuilder.com/code_snippet_generator/image_placeholder_generator/500x281/808080/DDDDDD/Image%20Not%20Found',
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
                    episode.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: episode.voteAverage / 2,
                      itemCount: 5,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: kMikadoYellow,
                      ),
                      itemSize: 14,
                    ),
                    Text(
                      '${episode.voteAverage}',
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
