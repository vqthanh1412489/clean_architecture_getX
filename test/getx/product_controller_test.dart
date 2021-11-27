import 'package:cleanarchitechgetx/domain/models/product.dart';
import 'package:cleanarchitechgetx/domain/models/user.dart';
import 'package:cleanarchitechgetx/presentation/home/home_controller.dart';
import 'package:cleanarchitechgetx/presentation/products/products_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'splash_controller_test.mocks.dart';

// @GenerateMocks([ApiRepositoryMock, LocalRepositoryMock])
void main() {
  final apiMock = MockApiRepositoryMock();
  final localMock = MockLocalRepositoryMock();

  final bindings = BindingsBuilder(() {
    Get.lazyPut(() => ProductController(apiRepositoryInterface: apiMock));
  });

  bindings.builder();

  final ProductController controller = Get.find<ProductController>();

  group('ProductController Test', () {
    test('Validate Product List is Empty ', () async {
      when(apiMock.getProducts()).thenAnswer((_) => Future.value([]));

      await controller.loadProducts();
      expect(controller.productList.length, 0);
    });

    test('Validate Product List have data ', () async {
      final List<Product> productList = [
        const Product(
            name: 'name product 1',
            pirce: 100,
            image: 'https://picsum.photos/100'),
        const Product(
            name: 'name product 2',
            pirce: 200,
            image: 'https://picsum.photos/100'),
        const Product(
            name: 'name product 3',
            pirce: 300,
            image: 'https://picsum.photos/100'),
      ];

      when(apiMock.getProducts()).thenAnswer((_) => Future.value(productList));

      await controller.loadProducts();
      expect(controller.productList.length, 3);
    });
  });
}
