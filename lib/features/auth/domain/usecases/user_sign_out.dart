import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements UseCase<void, NoParam> {
  final AuthRepository authRepository;

  UserSignOut(this.authRepository);

  @override
  Future<Either<Failures, void>> call(NoParam p) async {
    return await authRepository.userSignOut();
  }
}
