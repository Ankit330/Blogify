import 'package:blogapp/core/expections/server_expections.dart';
import 'package:blogapp/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDataSource {
  Session? get currentUserSession;
  Future<UserModel> signInWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
  Future<void> userLogout();
}

class AuthSupabaseDataSourceImp implements AuthSupabaseDataSource {
  final SupabaseClient supabaseClient;

  AuthSupabaseDataSourceImp(
    this.supabaseClient,
  );

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerExpection('User is null!!');
      }
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: currentUserSession!.user.email,
      );
    } on AuthException catch (e) {
      throw ServerExpection(e.message);
    } catch (e) {
      throw ServerExpection(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (password.length <= 6) {
        throw const AuthException('Password must be strong and lengthy');
      }
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw ServerExpection('User is null!!');
      }
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: currentUserSession!.user.email,
      );
    } on AuthException catch (e) {
      throw ServerExpection(e.message);
    } catch (e) {
      throw ServerExpection(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession == null) {
        return null;
      }
      final userData = await supabaseClient.from('profiles').select().eq(
            'id',
            currentUserSession!.user.id,
          );

      return UserModel.fromJson(userData.first).copyWith(
        email: currentUserSession!.user.email,
      );
    } on AuthException catch (e) {
      throw ServerExpection(e.message);
    } catch (e) {
      throw ServerExpection(e.toString());
    }
  }

  @override
  Future<void> userLogout() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw ServerExpection(e.message);
    } catch (e) {
      throw ServerExpection(e.toString());
    }
  }
}
