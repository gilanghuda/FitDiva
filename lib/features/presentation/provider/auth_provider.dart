import 'package:fitdiva/features/data/datasource/auth_service.dart';
import 'package:fitdiva/features/data/models/user_model.dart';
import 'package:fitdiva/features/domain/usecases/login_user.dart';
import 'package:fitdiva/features/domain/usecases/register_user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AuthProvider with ChangeNotifier {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final FirebaseAuthService authService;

  AuthProvider({
    required this.loginUser,
    required this.registerUser,
    required this.authService,
  });

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String? get userDisplayName {
    final user = authService.getCurrentUser();
    return user?.displayName;
  }

  Future<void> login(String email, String password, BuildContext context) async {
    _setLoading(true);
    _clearError();
    try {
      await loginUser(LoginParams(email: email, password: password));
      if (context.mounted) {
        context.go('/home');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(String email, String username, String password, BuildContext context, List<String> disabilityOptions) async {
    _setLoading(true);
    _clearError();
    try {
      await authService.register(email, password);
      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> signInWithGoogle(BuildContext context) async {
    _setLoading(true);
    _clearError();
    try {
      await authService.signInWithGoogle(context);
      if (context.mounted) {
        context.go('/home');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    _setLoading(true);
    _clearError();
    try {
      await authService.signOut(context);
      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<UserModel> getCurrentUserProfile() async {
    return await authService.getCurrentUserProfile();
  }

  Future<void> updateProfile(String username, String email, String? photoUrl) async {
    _setLoading(true);
    _clearError();
    try {
      await authService.updateProfile(username, email, photoUrl);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message.replaceAll('Exception: ', '');
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}