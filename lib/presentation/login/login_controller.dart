import 'package:cleanarchitechgetx/domain/exception/auth_exception.dart';
import 'package:cleanarchitechgetx/domain/repository/api_repository.dart';
import 'package:cleanarchitechgetx/domain/repository/local_storage_repository.dart';
import 'package:cleanarchitechgetx/domain/request/login_request.dart';
import 'package:cleanarchitechgetx/domain/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

enum LoginState {
  loading,
  initial,
}

class LoginController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;

  LoginController(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var loginState = LoginState.initial.obs;

  Future<bool> onLogin() async {
    final username = usernameController.text;
    final password = passwordController.text;
    print('username $username');
    print('username $password');

    try {
      loginState(LoginState.loading);
      final loginResponse = await apiRepositoryInterface
          .login(LoginRequest(username: username, password: password));

      if (loginResponse is LoginResponse) {
        await localRepositoryInterface.saveUser(loginResponse.user);
        await localRepositoryInterface.saveToken(loginResponse.token);
        return true;
      }
      loginState(LoginState.initial);
      return false;
    } on AuthException catch (_) {
      loginState(LoginState.initial);
      return false;
    }
  }
}
