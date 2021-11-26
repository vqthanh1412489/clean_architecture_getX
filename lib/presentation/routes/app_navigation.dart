import 'package:cleanarchitechgetx/presentation/home/home_binding.dart';
import 'package:cleanarchitechgetx/presentation/home/home_screen.dart';
import 'package:cleanarchitechgetx/presentation/login/login_binding.dart';
import 'package:cleanarchitechgetx/presentation/login/login_screen.dart';
import 'package:cleanarchitechgetx/presentation/main_binding.dart';
import 'package:cleanarchitechgetx/presentation/splash/splash_binding.dart';
import 'package:cleanarchitechgetx/presentation/splash/splash_screen.dart';
import 'package:get/route_manager.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
}

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.splash,
        page: () => SplashScreen(),
        bindings: [SplashBinding(), MainBinding()]),
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginScreen(),
        bindings: [LoginBinding(), MainBinding()]),
    GetPage(
        name: AppRoutes.home, page: () => HomeScreen(), binding: HomeBinding()),
  ];
}
