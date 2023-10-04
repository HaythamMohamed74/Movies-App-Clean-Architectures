import 'package:movies_app_clean_architectures/core/network/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  const ServerException({required this.errorModel});
}
