import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_architectures/movies/domain/repositories/base_movie_repository.dart';

import '../../../core/error/failure.dart';

class TopRatedMoviesUseCase {
  final BaseRepository baseRepository;

  TopRatedMoviesUseCase(this.baseRepository);
  Future<Either<Failure, List<Movie>>> call() async {
    return await baseRepository.getTopRatedMovies();
  }
}
