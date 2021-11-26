import 'package:cleanarchitechgetx/domain/repository/local_storage_repository.dart';
import 'package:cleanarchitechgetx/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _pref_token = 'TOKEN';
const String _pref_username = 'USERNAME';
const String _pref_name = 'NAME';
const String _pref_image = 'IMAGE';
const String _pref_isDarkMode = 'IS_DARK_MODE';

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_pref_token);
  }

  @override
  Future<String> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_pref_token, token);
    return token;
  }

  @override
  Future<User> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final username = sharedPreferences.getString(_pref_username);
    final name = sharedPreferences.getString(_pref_name);
    final image = sharedPreferences.getString(_pref_image);

    if (username != null && name != null && image != null) {
      var user = User(username: username, name: name, image: image);

      return user;
    }

    return User.empty();
  }

  @override
  Future<User> saveUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_pref_username, user.username);
    sharedPreferences.setString(_pref_name, user.name);
    sharedPreferences.setString(_pref_image, user.image);

    return user;
  }

  @override
  Future<bool?> isDarkMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(_pref_isDarkMode);
  }

  @override
  Future<void> saveDarkMode(bool isDarkMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_pref_isDarkMode, isDarkMode);
  }
}
