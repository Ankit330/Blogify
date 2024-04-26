import 'dart:developer';

import 'package:blogapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/features/auth/domain/usecases/current_user.dart';
import 'package:blogapp/features/auth/domain/usecases/user_login.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_out.dart';
import 'package:blogapp/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserSignOut _userSignOut;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required UserSignOut userSignOut,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userSignOut = userSignOut,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onSignUp);
    on<AuthLogin>(_onlogin);
    on<AuthUserLoggedIn>(_isUserLoggedIn);
    on<AuthUserSignOut>(_onSignOut);
  }

  void _isUserLoggedIn(
    AuthUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParam());

    res.fold((f) => emit(AuthFailure(f.message)), (user) {
      log(user.name);
      log(user.email);
      _emitAuthSuccess(user, emit);
    });
  }

  void _onSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    log(event.name);
    final response = await _userSignUp(UserSignUpParams(
      name: event.name,
      email: event.email,
      password: event.passwrod,
    ));

    response.fold((f) => emit(AuthFailure(f.message)),
        (user) => _emitAuthSuccess(user, emit));

    log(response.toString());
  }

  void _onlogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.passwrod,
      ),
    );

    response.fold((f) => emit(AuthFailure(f.message)),
        (user) => _emitAuthSuccess(user, emit));

    log(response.toString());
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  Future<void> _onSignOut(
    AuthUserSignOut event,
    Emitter<AuthState> emit,
  ) async {
    await _userSignOut(NoParam());
  }
}
