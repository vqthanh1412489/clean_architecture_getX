import 'package:cleanarchitechgetx/domain/models/user.dart';
import 'package:cleanarchitechgetx/presentation/splash/splash_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/api_repository_mock.dart';
import '../mocks/local_repository_mock.dart';
import 'splash_controller_test.mocks.dart';

@GenerateMocks([ApiRepositoryMock, LocalRepositoryMock])
void main() {
  final apiMock = MockApiRepositoryMock();
  final localMock = MockLocalRepositoryMock();

  final bindings = BindingsBuilder(() {
    Get.lazyPut(() => SplashController(
        localRepositoryInterface: localMock, apiRepositoryInterface: apiMock));
  });

  bindings.builder();

  final SplashController splashController = Get.find<SplashController>();

  test('Validate Sesstion  Invalid', () async {
    when(localMock.getToken()).thenAnswer((_) => Future.value(null));

    final result = await splashController.validateSession();

    expect(result, isFalse);
  });
  test('Validate Sesstion  Valid', () async {
    when(localMock.getToken()).thenAnswer((_) => Future.value('token1'));
    when(apiMock.getUserFromToeken('token1')).thenAnswer((_) =>
        Future.value(User(username: 'username', name: 'name', image: 'image')));
    when(localMock.saveUser(any)).thenAnswer((_) =>
        Future.value(User(username: 'username', name: 'name', image: 'image')));

    final result = await splashController.validateSession();

    expect(result, isTrue);
  });
}
