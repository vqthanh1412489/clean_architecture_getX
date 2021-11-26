import 'dart:convert';

import 'package:cleanarchitechgetx/domain/models/product.dart';

class ProductCard {
  ProductCard({
    required this.product,
    this.quantity = 1,
  });

  final Product product;
  int quantity;

  factory ProductCard.fromRawJson(String str) =>
      ProductCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCard.fromJson(Map<String, dynamic> json) => ProductCard(
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
      };
}
