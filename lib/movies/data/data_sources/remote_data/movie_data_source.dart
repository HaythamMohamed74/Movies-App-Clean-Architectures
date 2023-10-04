import 'package:dio/dio.dart';
import 'package:movies_app_clean_architectures/core/network/error_model.dart';
import 'package:movies_app_clean_architectures/movies/data/models/movie_details_model.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_movie_details.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_recommendations.dart';

import '../../../../core/error/server_exeption.dart';
import '../../../../core/utills/contants.dart';
import '../../models/movie_model.dart';
import '../../models/recommdation_model.dart';

abstract class MoviesDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameters parameters);
  Future<List<RecommendationModel>> getRecommendationMovies(
      MovieRecommendationParameters parameters);
}

class RemoteMovieDataSource implements MoviesDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    Dio dio = Dio();
    final response = await dio.get(AppConstants.nowPlayingPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      return throw ServerException(
          errorModel: ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    Dio dio = Dio();
    final response = await dio.get(AppConstants.popularMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      return throw ServerException(
          errorModel: ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await Dio().get(AppConstants.topRatedMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      return throw ServerException(
          errorModel: ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(parameters) async {
    final response =
        await Dio().get(AppConstants.movieDetailsPath(parameters.movieId));
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson((response.data));
    } else {
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendationMovies(
      MovieRecommendationParameters parameters) async {
    final response = await Dio()
        .get(AppConstants.recommendationMoviesPath(parameters.movieId));

    if (response.statusCode == 200) {
      return (List<RecommendationModel>.from((response.data['results'] as List)
          .map((e) => RecommendationModel.fromJson(e))));
    } else {
      throw ServerException(errorModel: ErrorModel.fromJson(response.data));
    }
  }
}
