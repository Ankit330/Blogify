import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParam> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failures, User>> call(NoParam p) async {
    return await authRepository.currentUser();
  }
}
