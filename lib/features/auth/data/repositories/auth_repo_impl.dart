import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/expections/server_expections.dart';
import 'package:blogapp/core/network/interner_connection.dart';
import 'package:blogapp/features/auth/data/dataSources/auth_supabase_data.dart';
import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoriesImpl implements AuthRepository {
  final AuthSupabaseDataSource supabaseDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoriesImpl(this.supabaseDataSource, this.connectionChecker);

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failures('No Internet Connection!!'));
      }
      final user = await supabaseDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failures(''));
      }
      return right(user);
    } on ServerExpection catch (e) {
      return left(Failures(e.msg));
    }
  }

  @override
  Future<Either<Failures, User>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await supabaseDataSource.loginWithEmail(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failures, User>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await supabaseDataSource.signInWithEmail(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failures, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failures(' No Internet Connection'));
      }
      final user = await fn();

      return right(user);
    } on ServerExpection catch (e) {
      return left(Failures(e.msg));
    }
  }

  @override
  Future<Either<Failures, Future<void>>> userSignOut() async {
    try {
      Future<void> res = await supabaseDataSource.userLogout() as Future;

      return right(res);
    } on ServerExpection catch (e) {
      return left(Failures(e.msg));
    }
  }
}
