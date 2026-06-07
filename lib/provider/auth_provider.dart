import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/provider/auth_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthState {
  final AuthUser? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({
    AuthUser? user,
    bool? isLoading,
    String? error,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      user: clearUser ? null : user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }

  bool get isLoggedIn => user != null;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> loginFunction(String username, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final response = await login({
        'username': username.trim(),
        'password': password,
      }, {});

      // Adjust field names to match your actual API response shape
      final data = response as Map<String, dynamic>;
      state = state.copyWith(
        isLoading: false,
        user: AuthUser(
          accessToken: data["accessToken"],
          refreshToken: data["refreshToken"],
          student: data["student"],
        ),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _parseError(e));
    }
  }

  void logout() => state = const AuthState();

  String _parseError(Object e) {
    // Adjust to your error/exception shape
    print(e);
    if (e is Exception) return e.toString().replaceFirst('Exception: ', '');
    return 'An unexpected error occurred.';
  }
}

// --- Provider ---
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
