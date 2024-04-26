import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, User>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failures, User>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> currentUser();

  Future<Either<Failures, Future<void>>> userSignOut();
}
