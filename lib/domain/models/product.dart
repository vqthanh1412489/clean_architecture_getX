import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.name,
    required this.pirce,
    required this.image,
  });

  final String name;
  final int pirce;
  final String image;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        pirce: json["pirce"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "pirce": pirce,
        "image": image,
      };

  @override
  List<Object?> get props => [name, pirce, image];
}
