import 'package:equatable/equatable.dart';

import 'genere.dart';

class MovieDetails extends Equatable {
  final String imgPath;
  final List<Genre> genres;
  final String title;
  final int id;
  final String overView;
  final String releaseDate;
  final double voteAvg;
  final int runTime;
  const MovieDetails(
      {required this.imgPath,
      required this.genres,
      required this.title,
      required this.id,
      required this.overView,
      required this.releaseDate,
      required this.voteAvg,
      required this.runTime});

  @override
  List<Object?> get props =>
      [title, releaseDate, runTime, voteAvg, imgPath, overView, id, genres];
}
