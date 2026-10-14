import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../helper/api_helper.dart';
import '../models/product_model.dart';
import '../../Domin/app_urls.dart';

class ProductRepository {
  final ApiHelper apiHelper;

  ProductRepository({required this.apiHelper});

  Future<List<ProductModel>> getProducts() async {
    try {
      dynamic response = await apiHelper.getAPI(url: AppUrls.urlProducts);
      List<dynamic> listData = [];

      if (response is List) {
        listData = response;
      } else if (response is Map<String, dynamic>) {
        if (response['data'] is List) {
          listData = response['data'];
        } else if (response['products'] is List) {
          listData = response['products'];
        }
      }

      if (listData.isEmpty) {
        return DummyData.products;
      }

      List<ProductModel> products = listData.map((item) {
        return ProductModel(
          id: item['id']?.toString() ?? item['_id']?.toString() ?? '0',
          title: item['title'] ?? item['name'] ?? item['product_name'] ?? 'Product',
          category: item['category'] ?? item['category_name'] ?? 'General',
          price: double.tryParse(item['price']?.toString() ?? '0') ?? 99.0,
          rating: double.tryParse(item['rating']?.toString() ?? '4.5') ?? 4.5,
          reviewCount: int.tryParse(item['review_count']?.toString() ?? '120') ?? 120,
          seller: item['seller'] ?? item['vendor'] ?? 'Official Store',
          description: item['description'] ?? 'High quality product made with durable materials.',
          imageUrl: (item['imageUrl'] ?? item['image'] ?? item['product_image'] ?? '').toString().startsWith('http')
              ? item['imageUrl'] ?? item['image'] ?? item['product_image']
              : 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=600',
          colors: [Colors.black, Colors.deepOrange, Colors.blue, Colors.grey],
          isFavorite: false,
        );
      }).toList();

      return products.isNotEmpty ? products : DummyData.products;
    } catch (e) {
      // Return local dummy products if API is offline or throws exception
      return DummyData.products;
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      dynamic response = await apiHelper.getAPI(url: AppUrls.urlCategories);
      List<dynamic> listData = [];

      if (response is List) {
        listData = response;
      } else if (response is Map<String, dynamic> && response['data'] is List) {
        listData = response['data'];
      }

      if (listData.isEmpty) {
        return DummyData.categories;
      }

      List<Map<String, dynamic>> categories = listData.map((cat) {
        return {
          "name": cat['name'] ?? cat['category_name'] ?? 'Category',
          "icon": _getCategoryIcon(cat['name']?.toString() ?? ''),
        };
      }).toList();

      return categories.isNotEmpty ? categories : DummyData.categories;
    } catch (e) {
      return DummyData.categories;
    }
  }

  IconData _getCategoryIcon(String name) {
    String lower = name.toLowerCase();
    if (lower.contains('shoe') || lower.contains('foot')) return Icons.directions_run_rounded;
    if (lower.contains('beauty') || lower.contains('cosmetic')) return Icons.face_retouching_natural_rounded;
    if (lower.contains('women') || lower.contains('lady')) return Icons.woman_rounded;
    if (lower.contains('jewel') || lower.contains('ring')) return Icons.diamond_outlined;
    if (lower.contains('men') || lower.contains('man')) return Icons.man_rounded;
    return Icons.category_outlined;
  }
}
