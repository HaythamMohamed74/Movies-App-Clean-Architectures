import 'package:movies_app_clean_architectures/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required super.imgPath,
      required super.title,
      required super.releaseDate,
      required super.overView,
      required super.voteAvg,
      required super.genreId,
      required super.id});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        imgPath: json['backdrop_path'] ?? '',
        title: json['title'],
        releaseDate: json['release_date'],
        overView: json['overview'],
        voteAvg: (json['vote_average']).toDouble(),
        genreId: List<int>.from(json['genre_ids'].map((e) => e)),
        id: json['id']);
  }
}
