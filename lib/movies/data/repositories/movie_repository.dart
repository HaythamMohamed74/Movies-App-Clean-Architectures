import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_architectures/core/error/server_exeption.dart';
import 'package:movies_app_clean_architectures/movies/data/data_sources/remote_data/movie_data_source.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_architectures/movies/domain/repositories/base_movie_repository.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_movie_details.dart';

import '../../../core/error/failure.dart';
import '../../domain/entities/recommendations.dart';
import '../../domain/use_cases/get_recommendations.dart';

class MovieRepository implements BaseRepository {
  final MoviesDataSource moviesDataSource;

  MovieRepository(this.moviesDataSource);
  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await moviesDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerException catch (fail) {
      return Left(ServerFailure(message: fail.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPopularMovies() async {
    final result = await moviesDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerException catch (fail) {
      return Left(ServerFailure(message: fail.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    final result = await moviesDataSource.getTopRatedMovies();
    try {
      return Right(result);
    } on ServerException catch (fail) {
      return Left(ServerFailure(message: fail.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final result = await moviesDataSource.getMovieDetails(parameters);
    try {
      return Right(result);
    } on ServerException catch (fail) {
      return Left(ServerFailure(message: fail.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendations>>> getRecommendations(
      MovieRecommendationParameters parameters) async {
    final result = await moviesDataSource.getRecommendationMovies(parameters);
    try {
      return Right(result);
    } on ServerException catch (fail) {
      return Left(ServerFailure(message: fail.errorModel.statusMessage));
    }
  }
}
