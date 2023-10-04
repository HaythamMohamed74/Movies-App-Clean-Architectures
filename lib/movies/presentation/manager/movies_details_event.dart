import 'package:equatable/equatable.dart';

abstract class MoviesDetailsEvent extends Equatable {
  const MoviesDetailsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetMovieDetailsEvent extends MoviesDetailsEvent {
  final int id;
  const GetMovieDetailsEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetRecommendationEvent extends MoviesDetailsEvent {
  final int id;
  const GetRecommendationEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
