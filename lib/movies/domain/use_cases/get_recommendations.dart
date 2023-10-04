import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app_clean_architectures/core/error/failure.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/recommendations.dart';
import 'package:movies_app_clean_architectures/movies/domain/repositories/base_movie_repository.dart';

import '../../../core/usecase/usecases.dart';

class RecommendationUseCase
    extends BaseUseCases<List<Recommendations>, MovieRecommendationParameters> {
  final BaseRepository baseRepository;

  RecommendationUseCase(this.baseRepository);

  @override
  Future<Either<Failure, List<Recommendations>>> call(
      MovieRecommendationParameters parameter) async {
    return await baseRepository.getRecommendations(parameter);
  }
}

class MovieRecommendationParameters extends Equatable {
  final int movieId;
  const MovieRecommendationParameters(this.movieId);
  @override
  List<Object?> get props => [movieId];
}
