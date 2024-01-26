import 'dart:io';

import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv_series/presentation/pages/season_detail_page.dart';
import 'package:tv_series/tv_series.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init(await ioClient());
  runApp(const MyApp());
}

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<IOClient> ioClient() async {
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);
  return ioClient;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<NowPlayingBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<NowPlayingTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailWatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSeriesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSeriesWatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SeasonDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TV_SERIES_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case TV_SERIES_ROUTE:
              return MaterialPageRoute(
                  builder: (_) => const HomeTvSeriesPage());
            case POPULAR_TV_SERIES_ROUTE:
              return MaterialPageRoute(
                  builder: (_) => const PopularTvSeriesPage());
            case TOP_RATED_TV_SERIES_ROUTE:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedTvSeriesPage());
            case WatchlistTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistTvSeriesPage());
            case NowPlayingMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const NowPlayingMoviesPage());
            case NowPlayingTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const NowPlayingTvSeriesPage());
            case SEARCH_TV_SERIES_ROUTE:
              return MaterialPageRoute(
                  builder: (_) => const SearchPageTvSeries());
            case SeasonDetailPage.ROUTE_NAME:
              Map<String, dynamic> params =
                  settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => SeasonDetailPage(
                  tvSeriesID: params['tv_series_id'],
                  seasonNumber: params['season_number'],
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
