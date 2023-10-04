import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app_clean_architectures/core/error/failure.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_architectures/movies/domain/repositories/base_movie_repository.dart';

import '../../../core/usecase/usecases.dart';

class MovieDetailsUseCase
    extends BaseUseCases<MovieDetails, MovieDetailsParameters> {
  final BaseRepository baseRepository;
  MovieDetailsUseCase(this.baseRepository);

  @override
  Future<Either<Failure, MovieDetails>> call(
      MovieDetailsParameters parameter) async {
    return await baseRepository.getMovieDetails(parameter);
  }
}

class MovieDetailsParameters extends Equatable {
  final int movieId;
  const MovieDetailsParameters(this.movieId);
  @override
  List<Object?> get props => [];
}
