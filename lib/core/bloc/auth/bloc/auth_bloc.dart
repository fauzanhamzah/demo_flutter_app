import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demo_flutter_app/core/constants/enums/auth_enums.dart';
import 'package:demo_flutter_app/core/init/cache/auth_cache_manager.dart';
import 'package:demo_flutter_app/core/service/interface_auth_service.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService authService;
  final AuthCacheManager authCacheManager;

  AuthBloc(this.authService, this.authCacheManager)
      : super(const AuthState.unknown()) {
    on<AppStarted>((event, emit) async {
      try {
        if (await authCacheManager.isLoggedIn()) {
          await authCacheManager.updateTokenFromStorage();
          emit(const AuthState.authenticated());
        } else {
          emit((await authCacheManager.isFirstEntry())
              ? const AuthState.firstEntry()
              : const AuthState.guest());
        }
      } on SocketException {
        emit(const AuthState.error(error: AuthError.hostUnreachable));
      } catch (e) {
        log(e.toString());
        emit(const AuthState.error());
      }
    });

    on<LoginRequested>(
      (event, emit) async {
        print("Masuk ke event Login Request");
        final String? response = await authService.login(
            userName: event.userName, password: event.password);
        print(response);
        if (response != null) {
          await authCacheManager.updateToken(response);
          await authCacheManager.updateLoggedIn(true);
          emit(const AuthState.authenticated());
        } else {
          add(LogoutRequested());
          emit(const AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );

    on<LogoutRequested>((event, emit) async {
      try {
        await authCacheManager.signOut();
        emit(const AuthState.guest());
      } catch (_) {}
    });
  }
}
