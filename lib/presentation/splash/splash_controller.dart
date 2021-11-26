import 'package:cleanarchitechgetx/domain/exception/auth_exception.dart';
import 'package:cleanarchitechgetx/domain/models/user.dart';
import 'package:cleanarchitechgetx/domain/repository/api_repository.dart';
import 'package:cleanarchitechgetx/domain/repository/local_storage_repository.dart';
import 'package:cleanarchitechgetx/main.dart';
import 'package:cleanarchitechgetx/presentation/routes/app_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SplashController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  SplashController(
      {required this.localRepositoryInterface,
      required this.apiRepositoryInterface});

  @override
  void onReady() {
    validateTheme();
    validateSession();
    super.onReady();
  }

  void validateTheme() async {
    final isDarkMode = await localRepositoryInterface.isDarkMode();

    if (isDarkMode != null) {
      Get.changeTheme(isDarkMode ? dark : light);
    } else {
      Get.changeTheme(Get.isDarkMode ? dark : light);
    }
  }

  void validateSession() async {
    final token = await localRepositoryInterface.getToken();

    if (token != null) {
      try {
        final user = await apiRepositoryInterface.getUserFromToeken(token);
        if (user is User) {
          await localRepositoryInterface.saveUser(user);
          Get.offNamed(AppRoutes.home);
        }
      } on AuthException catch (_) {
        Get.offNamed(AppRoutes.login);
      }
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }
}
