import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  static const String _tokenKey = 'access_token';
  static const String _userKey = 'user';

  final ApiService _apiService = ApiService();

  Future<User> login(String email, String password) async {
    final response = await _apiService.login(email, password);
    await _saveToken(response.accessToken);
    await _saveUser(response.user);
    return response.user;
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = {
      'id': user.id,
      'username': user.username,
      'email': user.email,
      'full_name': user.fullName,
    };
    await prefs.setString(_userKey, userJson.toString());
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<User?> getCurrentUser() async {
    // For simplicity, we'll just check if token exists
    // In a production app, you might want to decode and store user data properly
    final token = await getToken();
    return token != null ? null : null; // Return null for now, user will be set after login
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
