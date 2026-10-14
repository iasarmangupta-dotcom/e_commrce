import 'package:flutter/material.dart';
import 'models/address_model.dart';
import 'models/cart_item_model.dart';
import 'models/product_model.dart';

class DummyData {
  static List<Map<String, dynamic>> categories = [
    {"name": "Shoes", "icon": Icons.directions_run_rounded},
    {"name": "Beauty", "icon": Icons.face_retouching_natural_rounded},
    {"name": "Women's\nFashion", "icon": Icons.woman_rounded},
    {"name": "Jewelry", "icon": Icons.diamond_outlined},
    {"name": "Men's\nFashion", "icon": Icons.man_rounded},
  ];

  static List<ProductModel> products = [
    ProductModel(
      id: "1",
      title: "Wireless Headphone",
      category: "Electronics",
      price: 120.00,
      rating: 4.8,
      reviewCount: 320,
      seller: "Tariqul islam",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Placeat in semper vitae a. Blandit amet purus eget sed vitae morbi tellus. Integer ornare.",
      imageUrl:
          "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=600",
      colors: [Colors.black, Colors.indigo, Colors.brown, Colors.grey.shade300],
      isFavorite: true,
    ),
    ProductModel(
      id: "2",
      title: "Woman Sweter",
      category: "Woman Fashion",
      price: 120.00,
      rating: 4.5,
      reviewCount: 180,
      seller: "Fashion Store",
      description:
          "Comfortable stylish winter sweater for women made from premium cotton blend material with sleek aesthetic design.",
      imageUrl:
          "https://images.unsplash.com/photo-1576995853123-5a10305d93c0?q=80&w=600",
      colors: [Colors.pink.shade200, Colors.deepOrange, Colors.purple.shade300],
      isFavorite: false,
    ),
    ProductModel(
      id: "3",
      title: "Smart Watch",
      category: "Electronics",
      price: 55.00,
      rating: 4.7,
      reviewCount: 210,
      seller: "TechZone",
      description:
          "Smart fitness tracker watch with heart rate monitor, step counter, full touch display and long battery backup.",
      imageUrl:
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=600",
      colors: [Colors.black, Colors.blue, Colors.grey],
      isFavorite: false,
    ),
    ProductModel(
      id: "4",
      title: "Running Sneakers",
      category: "Shoes",
      price: 95.00,
      rating: 4.9,
      reviewCount: 450,
      seller: "Nike Official",
      description:
          "High performance breathable sport shoes designed for max comfort and speed during daily running sessions.",
      imageUrl:
          "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=600",
      colors: [Colors.red, Colors.orange, Colors.black],
      isFavorite: true,
    ),
  ];

  static List<CartItemModel> cartItems = [
    CartItemModel(
      product: products[1],
      quantity: 1,
      selectedColor: Colors.pink.shade200,
    ),
    CartItemModel(
      product: products[2],
      quantity: 1,
      selectedColor: Colors.black,
    ),
    CartItemModel(
      product: products[0],
      quantity: 1,
      selectedColor: Colors.black,
    ),
  ];

  static List<AddressModel> addresses = [
    AddressModel(
      id: "1",
      name: "John Doe",
      phone: "+91 98765 43210",
      houseNo: "Flat 402, Sunshine Apartments",
      street: "Main Ring Road, Sector 12",
      city: "New Delhi",
      state: "Delhi",
      pincode: "110001",
      type: "Home",
      isDefault: true,
    ),
    AddressModel(
      id: "2",
      name: "John Doe (Office)",
      phone: "+91 98765 43210",
      houseNo: "Plot No. 15, Tech Tower",
      street: "Cyber Hub, Phase 2",
      city: "Gurugram",
      state: "Haryana",
      pincode: "122002",
      type: "Work",
      isDefault: false,
    ),
  ];
}
