import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_architectures/core/utills/enum_request_state.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/movie.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_now_playing_movies.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_popular_movies.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_top_rated_movies.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final NowPlayingMoviesUseCase nowPlayingMoviesUseCase;
  final PopularMoviesUseCase popularMoviesUseCase;
  final TopRatedMoviesUseCase topRatedMoviesUseCase;
  MoviesBloc(
    this.nowPlayingMoviesUseCase,
    this.popularMoviesUseCase,
    this.topRatedMoviesUseCase,
  ) : super(const MoviesState()) {
    on<GetPlayingMoviesNowEvent>((event, emit) async {
      final result = await nowPlayingMoviesUseCase();
      result.fold(
          (l) => emit(state.copyWith(
              messagePlayingNow: l.message,
              playingNowRequestState: RequestState.error)),
          (r) => emit(state.copyWith(
              playingMoviesNow: r,
              playingNowRequestState: RequestState.loaded)));
    });
    on<GetPopularMoviesEvent>((event, emit) async {
      final result = await popularMoviesUseCase();
      result.fold(
          (l) => emit(state.copyWith(
              popularMoviesRequestState: RequestState.error,
              messagePopular: l.message)),
          (r) => emit(state.copyWith(
              popularMovies: r,
              popularMoviesRequestState: RequestState.loaded)));
    });
    on<GetTopRatedMoviesEvent>((event, emit) async {
      final result = await topRatedMoviesUseCase();
      // TopRatedMoviesUseCase(getIt()).execute();
      result.fold(
          (l) => emit(state.copyWith(
              topRatedMoviesRequestState: RequestState.error,
              messageTopRated: l.message)),
          (r) => emit(state.copyWith(
              topRatedMovies: r,
              topRatedMoviesRequestState: RequestState.loaded)));
    });
  }
}
