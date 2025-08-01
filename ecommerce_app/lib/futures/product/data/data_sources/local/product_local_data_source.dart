import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/product_model.dart';

abstract class ProductLocalDataSources {
  Future<List<ProductModel>> fetchProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<ProductModel> fetchProductById(String id);
  Future<void> addProduct(ProductModel product);
}


class ProductLocalDataSourceImpl implements ProductLocalDataSources {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<List<ProductModel>> fetchProducts() async {
    final productJsonList = sharedPreferences.getStringList('products') ?? [];
    return productJsonList
        .map((jsonStr) => ProductModel.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final productJsonList =
        products.map((product) => jsonEncode(product.toJson())).toList();
    await sharedPreferences.setStringList('products', productJsonList);
  }

  @override
  Future<ProductModel> fetchProductById(String id) async {
    final productJsonList = sharedPreferences.getStringList('products') ?? [];
    final productJsonStr = productJsonList.firstWhere(
      (jsonStr) => ProductModel.fromJson(jsonDecode(jsonStr)).id == id,
      orElse: () => '',
    );
    if (productJsonStr.isEmpty) {
      throw Exception('Product not found');
    }
    return ProductModel.fromJson(jsonDecode(productJsonStr));
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    final productJsonList = sharedPreferences.getStringList('products') ?? [];
    productJsonList.add(jsonEncode(product.toJson()));
    await sharedPreferences.setStringList('products', productJsonList);
  }

}