import 'package:cleanarchitechgetx/main.dart';
import 'package:cleanarchitechgetx/presentation/home/home_controller.dart';
import 'package:cleanarchitechgetx/presentation/routes/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  final HomeController controller = Get.find<HomeController>();

  Future<void> _logout() async {
    await controller.logout();
    Get.offAllNamed(AppRoutes.splash);
  }

  void _onChangeTheme(bool isDark) {
    controller.onChangeTheme(isDark);
    Get.changeTheme(isDark ? dark : light);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.user.value;

      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: user.image != ''
                    ? Image.network(user.image)
                    : Container(
                        color: Colors.red,
                      ),
              ),
              Text(user.name),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Dark Mode'),
                  Switch(
                    value: controller.isDarkMode.value,
                    onChanged: _onChangeTheme,
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  )
                ],
              ),
              LogoutWidget(
                onPress: _logout,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(UniconsLine.sign_out_alt),
          Text("logout"),
        ],
      ),
      onPressed: onPress,
    );
  }
}
