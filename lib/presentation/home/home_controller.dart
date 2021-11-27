import 'package:cleanarchitechgetx/domain/models/user.dart';
import 'package:cleanarchitechgetx/domain/repository/api_repository.dart';
import 'package:cleanarchitechgetx/domain/repository/local_storage_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  HomeController(
      {required this.localRepositoryInterface,
      required this.apiRepositoryInterface});

  Rx<User> user = User.empty().obs;
  RxInt currentIndex = 0.obs;

  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    loadCurrentTheme();
    super.onInit();
  }

  @override
  void onReady() {
    loadUser();

    super.onReady();
  }

  void onIndexSelected(int index) {
    currentIndex(index);
  }

  void loadCurrentTheme() {
    localRepositoryInterface.isDarkMode().then((value) => isDarkMode(value));
  }

  Future<bool> onChangeTheme(bool isDark) async {
    await localRepositoryInterface.saveDarkMode(isDark);
    isDarkMode(isDark);
    return isDark;
  }

  Future<void> loadUser() async {
    user(await localRepositoryInterface.getUser());
  }

  Future<void> logout() async {
    final token = await localRepositoryInterface.getToken();
    if (token != null) {
      await apiRepositoryInterface.logout(token);
    }
    await localRepositoryInterface.clearAllData();
  }
}
