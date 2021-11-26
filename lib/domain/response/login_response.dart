import 'package:cleanarchitechgetx/domain/models/user.dart';

class LoginResponse {
  LoginResponse({required this.token, required this.user});

  final String token;
  final User user;
}
