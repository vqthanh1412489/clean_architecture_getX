import 'package:cleanarchitechgetx/domain/models/product.dart';
import 'package:cleanarchitechgetx/domain/repository/api_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  ProductController({required this.apiRepositoryInterface});

  RxList<Product> productList = <Product>[].obs;

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  Future<void> loadProducts() async {
    var result = await apiRepositoryInterface.getProducts();

    productList.value = result;
  }
}
