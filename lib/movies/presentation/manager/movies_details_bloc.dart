import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_clean_architectures/core/utills/enum_request_state.dart';
import 'package:movies_app_clean_architectures/movies/domain/use_cases/get_movie_details.dart';

import '../../domain/use_cases/get_recommendations.dart';
import 'movies_details_event.dart';
import 'movies_details_state.dart';

class MoviesDetailsBloc extends Bloc<MoviesDetailsEvent, MoviesDetailsState> {
  MovieDetailsUseCase movieDetailsUseCase;
  RecommendationUseCase recommendationUseCase;

  MoviesDetailsBloc(this.movieDetailsUseCase, this.recommendationUseCase)
      : super(const MoviesDetailsState()) {
    on<GetMovieDetailsEvent>((event, emit) async {
      final data = await movieDetailsUseCase(MovieDetailsParameters(event.id));
      data.fold(
          (l) => emit(state.copyWith(
              detailsMessage: state.detailsMessage,
              detailsRequestState: RequestState.error)),
          (r) => emit(state.copyWith(
              movieDetails: r, detailsRequestState: RequestState.loaded)));
    });

    on<GetRecommendationEvent>((event, emit) async {
      final data =
          await recommendationUseCase(MovieRecommendationParameters(event.id));
      data.fold(
          (l) => emit(state.copyWith(
              recommendationsMessage: state.detailsMessage,
              recommendationsRequestState: RequestState.error)),
          (r) => emit(state.copyWith(
              recommendations: r,
              recommendationsRequestState: RequestState.loaded)));
    });
  }
}
