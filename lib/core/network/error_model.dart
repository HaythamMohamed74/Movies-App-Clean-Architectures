import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String statusMessage;
  final bool success;
  final int statusCode;
  const ErrorModel(
      {required this.statusMessage,
      required this.success,
      required this.statusCode});
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        statusMessage: json['status_message'],
        success: json['success'],
        statusCode: json['status_code']);
  }

  @override
  List<Object?> get props => [statusCode, success, statusMessage];
}
