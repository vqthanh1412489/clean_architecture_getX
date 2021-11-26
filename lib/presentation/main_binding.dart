import 'package:cleanarchitechgetx/data/datasource/api_repository_impl.dart';
import 'package:cleanarchitechgetx/data/datasource/local_repository_impl.dart';
import 'package:cleanarchitechgetx/domain/repository/api_repository.dart';
import 'package:cleanarchitechgetx/domain/repository/local_storage_repository.dart';
import 'package:get/instance_manager.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalRepositoryInterface>(() => LocalRepositoryImpl());
    Get.lazyPut<ApiRepositoryInterface>(() => ApiRepositoryImpl());
  }
}
