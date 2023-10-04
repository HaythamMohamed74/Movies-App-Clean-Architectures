import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String imgPath;
  final String title;
  final List<int> genreId;
  final int id;
  final String releaseDate;
  final String overView;
  final double voteAvg;

  const Movie(
      {required this.imgPath,
      required this.title,
      required this.releaseDate,
      required this.overView,
      required this.voteAvg,
      required this.genreId,
      required this.id});

  @override
  List<Object> get props => [
        imgPath,
        title,
        genreId,
        id,
        overView,
        voteAvg,
        releaseDate,
      ];
}
