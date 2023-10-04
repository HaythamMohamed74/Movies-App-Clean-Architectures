import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_architectures/movies/domain/repositories/base_movie_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';

class NowPlayingMoviesUseCase {
  final BaseRepository baseRepository;

  NowPlayingMoviesUseCase(this.baseRepository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await baseRepository.getNowPlayingMovies();
  }
}
