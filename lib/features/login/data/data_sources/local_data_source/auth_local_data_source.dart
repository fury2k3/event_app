import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken({
    required String token,
  });
  Future<String?> getToken();
  Future<void> removeToken();

  Future<void> saveUserId({
    required String userId,
  });
  Future<String?> getUserId();
  Future<void> removeUserId();

  Future<void> saveRole({
    required String role,
  });
  Future<String?> getRole();
  Future<void> removeRole();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
  static const String _tokenKey = 'token_key';
  static const String _userIdKey = 'user_id_key';
  static const String _roleKey = 'role_key';

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  Future<void> removeToken() async {
    await sharedPreferences.remove(_tokenKey);
  }

  @override
  Future<void> saveToken({
    required String token,
  }) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<String?> getRole() async {
    return sharedPreferences.getString(_roleKey);
  }

  @override
  Future<String?> getUserId() async {
    return sharedPreferences.getString(_userIdKey);
  }

  @override
  Future<void> removeRole() async {
    await sharedPreferences.remove(_roleKey);
  }

  @override
  Future<void> removeUserId() async {
    await sharedPreferences.remove(_userIdKey);
  }

  @override
  Future<void> saveRole({
    required String role,
  }) async {
    await sharedPreferences.setString(_roleKey, role);
  }

  @override
  Future<void> saveUserId({
    required String userId,
  }) async {
    await sharedPreferences.setString(_userIdKey, userId);
  }
}
