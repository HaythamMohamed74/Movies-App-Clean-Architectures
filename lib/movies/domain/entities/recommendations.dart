import 'package:equatable/equatable.dart';

class Recommendations extends Equatable {
  final String imgPath;
  final int id;


  const Recommendations(
      {required this.imgPath,
      required this.id});

  @override
  List<Object> get props => [
        imgPath,
        id,

      ];
}
