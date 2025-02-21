import 'package:aes_flutter_technical/features/authentication/domain/usecase/login_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data_source/local/local_data_source.dart';
import '../../data/data_source/remote/remote_data_source.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/entity/user_entity.dart';

// Dio provider
final dioProvider = Provider<Dio>((ref) => Dio());

// Repository provider
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(ApiService(dio), DatabaseService.instance);
});

// Use case provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

// State notifier for login
class AuthState {
  final bool isLoading;
  final String? message;
  final User? user;

  AuthState({this.isLoading = false, this.message, this.user});

  AuthState copyWith({bool? isLoading, String? message, User? user}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;

  AuthNotifier(this.loginUseCase) : super(AuthState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, message: null);
    try {
      final user = await loginUseCase(username, password);
      state = state.copyWith(
        isLoading: false,
        user: user,
        message: 'Login successful',
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, message: e.toString());
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  return AuthNotifier(loginUseCase);
});
