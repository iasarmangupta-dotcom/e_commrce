import 'package:flutter/material.dart';
import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;
  Color selectedColor;

  CartItemModel({
    required this.product,
    this.quantity = 1,
    required this.selectedColor,
  });

  double get totalPrice => product.price * quantity;
}
