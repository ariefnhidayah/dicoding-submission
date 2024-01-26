import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class SearchPageTvSeries extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search-tv-series';
  const SearchPageTvSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchTvSeriesBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
              builder: (context, state) {
                if (state is SearchTvSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvSeriesHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvSeries = result[index];
                        return TvCardList(tvSeries: tvSeries);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchTvSeriesError) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        key: const Key('error_message'),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    key: Key('error_message'),
                    child: Text("Not Found"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
