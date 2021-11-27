import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.username,
    required this.name,
    required this.image,
  });

  final String username;
  final String name;
  final String image;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "image": image,
      };

  factory User.empty() => const User(username: '', name: '', image: '');

  @override
  List<Object?> get props => [username, name, image];
}
