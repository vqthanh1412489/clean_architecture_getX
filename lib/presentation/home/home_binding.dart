import 'package:cleanarchitechgetx/presentation/favorit/favorit_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
          localRepositoryInterface: Get.find(),
          apiRepositoryInterface: Get.find(),
        ));

    // Move to ProductScreen to have more way to try.
    // Get.lazyPut(() => ProductController(
    //       apiRepositoryInterface: Get.find(),
    //     ));

    Get.lazyPut(() => FavoritController(
          apiRepositoryInterface: Get.find(),
        ));
  }
}
