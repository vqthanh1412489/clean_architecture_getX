import 'package:cleanarchitechgetx/domain/models/user.dart';
import 'package:cleanarchitechgetx/presentation/home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'splash_controller_test.mocks.dart';

// @GenerateMocks([ApiRepositoryMock, LocalRepositoryMock])
void main() {
  final apiMock = MockApiRepositoryMock();
  final localMock = MockLocalRepositoryMock();

  final bindings = BindingsBuilder(() {
    Get.lazyPut(() => HomeController(
        localRepositoryInterface: localMock, apiRepositoryInterface: apiMock));
  });

  bindings.builder();

  final HomeController controller = Get.find<HomeController>();

  group('Home Contrller Test', () {
    test('Validate User is Exists ', () async {
      when(localMock.getUser()).thenAnswer((_) => Future.value(
          User(username: 'username', name: 'name', image: 'image')));

      await controller.loadUser();
      expect(controller.user, isNotNull);
    });

    test('Validate User is empty ', () async {
      when(localMock.getUser()).thenAnswer((_) => Future.value(User.empty()));
      await controller.loadUser();

      final isMatchObject = controller.user.value == User.empty();
      expect(isMatchObject, true);

      // expect(controller.user.value, User.empty());
    });

    test('Validate index selected', () {
      expect(controller.currentIndex.value, 0);
      controller.onIndexSelected(2);
      expect(controller.currentIndex.value, 2);
    });
  });
}
