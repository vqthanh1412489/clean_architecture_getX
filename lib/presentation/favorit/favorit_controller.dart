import 'package:cleanarchitechgetx/domain/models/product.dart';
import 'package:cleanarchitechgetx/domain/models/product_card.dart';
import 'package:cleanarchitechgetx/domain/repository/api_repository.dart';
import 'package:get/get.dart';

class FavoritController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  FavoritController({required this.apiRepositoryInterface});

  RxList<ProductCard> cardList = <ProductCard>[].obs;
  RxInt totalItems = 0.obs;
  RxDouble totalCost = 0.0.obs;

  void add(Product product) {
    final temp = List<ProductCard>.from(cardList);

    bool found = false;

    for (ProductCard p in temp) {
      if (p.product.name == product.name) {
        p.quantity += 1;
        found = true;
        break;
      }
    }

    if (!found) {
      temp.add(ProductCard(product: product));
    }

    cardList.value = List<ProductCard>.from(temp);
    caculateTotal();
  }

  void increment(ProductCard productCard) {
    productCard.quantity += 1;
    cardList.value = List<ProductCard>.from(cardList);
    caculateTotal();
  }

  void decrement(ProductCard productCard) {
    if (productCard.quantity == 1) {
      delete(productCard);
    } else {
      productCard.quantity -= 1;
    }
    cardList.value = List<ProductCard>.from(cardList);
    caculateTotal();
  }

  void delete(ProductCard productCard) {
    cardList.remove(productCard);
    caculateTotal();
  }

  void caculateTotal() {
    var countItems = 0;
    var countCost = 0.0;
    for (ProductCard p in cardList) {
      countItems += p.quantity;
      countCost += p.quantity * p.product.pirce;
    }
    totalItems(countItems);
    totalCost(countCost);
  }

  void caculateTotalCost() {
    var result = 0.0;
    for (ProductCard p in cardList) {
      result += p.quantity * p.product.pirce;
    }

    totalCost(result);
  }
}
