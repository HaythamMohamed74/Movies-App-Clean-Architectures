import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_architectures/core/error/failure.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/recommendations.dart';

import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../use_cases/get_movie_details.dart';
import '../use_cases/get_recommendations.dart';

abstract class BaseRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getNowPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetails>> getMovieDetails(
      MovieDetailsParameters parameters);
  Future<Either<Failure, List<Recommendations>>> getRecommendations(
      MovieRecommendationParameters parameters);
}
