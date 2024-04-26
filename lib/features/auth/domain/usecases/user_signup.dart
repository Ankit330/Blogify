import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failures, User>> call(UserSignUpParams p) async {
    return await authRepository.signUpWithEmail(
        name: p.name, email: p.email, password: p.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
