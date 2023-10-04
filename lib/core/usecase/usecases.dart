import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_architectures/core/error/failure.dart';

abstract class BaseUseCases<T, Parameter> {
  Future<Either<Failure, T>> call(Parameter parameter);
}
