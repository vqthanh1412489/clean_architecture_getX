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

    validateSession().then((value) {
      if (value) {
        return Get.offNamed(AppRoutes.home);
      }

      return Get.offNamed(AppRoutes.login);
    });

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

  Future<bool> validateSession() async {
    final token = await localRepositoryInterface.getToken();

    if (token != null) {
      try {
        final user = await apiRepositoryInterface.getUserFromToeken(token);
        if (user is User) {
          await localRepositoryInterface.saveUser(user);
          return true;
        }
      } on AuthException catch (_) {
        return false;
      }
    }

    return false;
  }
}
