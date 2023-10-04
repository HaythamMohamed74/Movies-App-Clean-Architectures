import 'package:movies_app_clean_architectures/movies/domain/entities/recommendations.dart';

class RecommendationModel extends Recommendations {
  const RecommendationModel({required super.imgPath, required super.id});

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
        imgPath: json['backdrop_path'] ?? '', id: json['id']);
  }
}
