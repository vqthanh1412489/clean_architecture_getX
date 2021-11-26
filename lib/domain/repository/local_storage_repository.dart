import '../models/user.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<String> saveToken(String token);
  Future<void> clearAllData();
  Future<User> getUser();
  Future<User> saveUser(User user);
  Future<void> saveDarkMode(bool isDarkMode);
  Future<bool?> isDarkMode();
}
