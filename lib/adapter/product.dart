import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 1)
class Product {
  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.price
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  String price;

  @HiveField(3)
  String category;

  @HiveField(4)
  Uint8List image;

  // @HiveField(2)
  // List<Product> products;
}
