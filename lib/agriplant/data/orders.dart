import 'package:instagram_clone_flutter/agriplant/data/products.dart';
import 'package:instagram_clone_flutter/agriplant/modelsag/order.dart';

List<Order> orders = [
  Order(
    id: "202404a5",
    products: products.reversed.take(3).toList(),
    date: DateTime.utc(2024),
  ),
  Order(
    id: "202304jm",
    products: products.take(1).toList(),
    date: DateTime.utc(2023),
  ),
  Order(
    id: "202004vc",
    products: products.reversed.skip(2).toList(),
    date: DateTime.utc(2020),
  ),
];
