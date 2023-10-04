part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final List<Movie> playingMoviesNow;
  final RequestState playingNowRequestState;
  final String messagePlayingNow;
  final List<Movie> popularMovies;
  final RequestState popularMoviesRequestState;
  final String messagePopular;
  final List<Movie> topRatedMovies;
  final RequestState topRatedMoviesRequestState;
  final String messageTopRated;

  const MoviesState({
    this.playingNowRequestState = RequestState.loading,
    this.messagePlayingNow = '',
    this.playingMoviesNow = const [],
    this.popularMovies = const [],
    this.popularMoviesRequestState = RequestState.loading,
    this.messagePopular = '',
    this.topRatedMovies = const [],
    this.topRatedMoviesRequestState = RequestState.loading,
    this.messageTopRated = '',
  });

  MoviesState copyWith({
    List<Movie>? playingMoviesNow,
    RequestState? playingNowRequestState,
    String? messagePlayingNow,
    List<Movie>? popularMovies,
    RequestState? popularMoviesRequestState,
    String? messagePopular,
    List<Movie>? topRatedMovies,
    RequestState? topRatedMoviesRequestState,
    String? messageTopRated,
  }) {
    return MoviesState(
      playingMoviesNow: playingMoviesNow ?? this.playingMoviesNow,
      playingNowRequestState:
          playingNowRequestState ?? this.playingNowRequestState,
      messagePlayingNow: messagePlayingNow ?? this.messagePlayingNow,
      popularMovies: popularMovies ?? this.popularMovies,
      popularMoviesRequestState:
          popularMoviesRequestState ?? this.popularMoviesRequestState,
      messagePopular: messagePopular ?? this.messagePopular,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedMoviesRequestState:
          topRatedMoviesRequestState ?? this.topRatedMoviesRequestState,
      messageTopRated: messageTopRated ?? this.messageTopRated,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        playingMoviesNow,
        playingNowRequestState,
        messagePlayingNow,
        popularMovies,
        popularMoviesRequestState,
        messagePopular,
        topRatedMovies,
        topRatedMoviesRequestState,
        messageTopRated
      ];
}
