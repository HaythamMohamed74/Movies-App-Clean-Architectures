import 'package:movies_app_clean_architectures/movies/data/models/genre_model.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel(
      {required super.imgPath,
      required super.genres,
      required super.title,
      required super.id,
      required super.overView,
      required super.releaseDate,
      required super.voteAvg,
      required super.runTime});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
        imgPath: json['backdrop_path'],
        genres: List<GenreModel>.from(
            (json['genres'].map((e) => GenreModel.fromJson(e)))),
        title: json['title'],
        id: json['id'],
        overView: json['overview'],
        releaseDate: json['release_date'],
        voteAvg: json['vote_average'],
        runTime: json['runtime']);
  }
}
