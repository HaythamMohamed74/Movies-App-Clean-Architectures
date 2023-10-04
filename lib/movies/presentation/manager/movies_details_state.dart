import 'package:equatable/equatable.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/recommendations.dart';

import '../../../core/utills/enum_request_state.dart';

class MoviesDetailsState extends Equatable {
  final MovieDetails? movieDetails;
  final RequestState detailsRequestState;
  final String detailsMessage;
  final List<Recommendations>? recommendations;
  final String recommendationsMessage;
  final RequestState recommendationsRequestState;

  const MoviesDetailsState(
      {this.recommendations = const [],
      this.recommendationsMessage = '',
      this.recommendationsRequestState = RequestState.loading,
      this.movieDetails,
      this.detailsRequestState = RequestState.loading,
      this.detailsMessage = ''});
  MoviesDetailsState copyWith({
    MovieDetails? movieDetails,
    RequestState? detailsRequestState,
    String? detailsMessage,
    List<Recommendations>? recommendations,
    String? recommendationsMessage,
    RequestState? recommendationsRequestState,
  }) {
    return MoviesDetailsState(
        movieDetails: movieDetails ?? this.movieDetails,
        detailsRequestState: detailsRequestState ?? this.detailsRequestState,
        detailsMessage: detailsMessage ?? this.detailsMessage,
        recommendations: recommendations ?? this.recommendations,
        recommendationsRequestState:
            recommendationsRequestState ?? this.recommendationsRequestState,
        recommendationsMessage:
            recommendationsMessage ?? this.recommendationsMessage);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        movieDetails,
        detailsMessage,
        detailsRequestState,
        recommendations,
        recommendationsMessage,
        recommendationsRequestState
      ];
}
