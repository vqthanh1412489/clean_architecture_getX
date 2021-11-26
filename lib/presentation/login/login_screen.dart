import 'package:cleanarchitechgetx/presentation/login/login_controller.dart';
import 'package:cleanarchitechgetx/presentation/routes/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  Future<void> _onLogin() async {
    final result = await controller.onLogin();
    if (result) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar('Error', 'Invalid Account');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.green[100],
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Login'),
                  const SizedBox(
                    height: 100,
                  ),
                  TextField(
                      controller: controller.usernameController,
                      decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontStyle: FontStyle.italic))),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                          labelText: 'password',
                          labelStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontStyle: FontStyle.italic))),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(onPressed: _onLogin, child: const Text('Login'))
                ],
              ),
            ),
            Positioned.fill(
              child: Obx(() {
                if (controller.loginState.value == LoginState.loading) {
                  return Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return const SizedBox.shrink();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
