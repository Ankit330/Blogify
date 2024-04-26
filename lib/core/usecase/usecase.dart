import 'package:blogapp/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<Success, Params> {
  Future<Either<Failures, Success>> call(Params p);
}

class NoParam {}
