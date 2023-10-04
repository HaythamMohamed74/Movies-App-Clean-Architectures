import 'package:get_it/get_it.dart';
import 'package:movies_app_clean_architectures/movies/domain/repositories/base_movie_repository.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_now_playing_movies.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_popular_movies.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_top_rated_movies.dart';
import 'package:movies_app_clean_architectures/movies/presentation/manager/movies_bloc.dart';
import 'package:movies_app_clean_architectures/movies/presentation/manager/movies_details_bloc.dart';

import '../../movies/data/data_sources/remote_data/movie_data_source.dart';
import '../../movies/data/repositories/movie_repository.dart';
import '../../movies/domain/use_cases/get_movie_details.dart';
import '../../movies/domain/use_cases/get_recommendations.dart';

final getIt = GetIt.instance;

class ServerLoc {
  setup() {
    //Data source
    getIt
        .registerLazySingleton<MoviesDataSource>(() => RemoteMovieDataSource());

    //Repository
    getIt.registerLazySingleton<BaseRepository>(() => MovieRepository(getIt()));

    // Now Playing  UseCase
    getIt.registerLazySingleton<NowPlayingMoviesUseCase>(
        () => NowPlayingMoviesUseCase(getIt()));
    // Popular  UseCase
    getIt.registerLazySingleton<PopularMoviesUseCase>(
        () => PopularMoviesUseCase(getIt()));
    // TopRated UseCase
    getIt.registerLazySingleton<TopRatedMoviesUseCase>(
        () => TopRatedMoviesUseCase(getIt()));

    getIt.registerLazySingleton<MovieDetailsUseCase>(
        () => MovieDetailsUseCase(getIt()));

    getIt.registerLazySingleton<RecommendationUseCase>(
        () => RecommendationUseCase(getIt()));

    //Bloc
    getIt.registerFactory<MoviesBloc>(
        () => MoviesBloc(getIt(), getIt(), getIt()));
    getIt.registerFactory<MoviesDetailsBloc>(
        () => MoviesDetailsBloc(getIt(), getIt()));
  }
}
