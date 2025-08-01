import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../../core/const/const.dart';
import '../../../data/models/product_model.dart';

abstract class ProductRemoteDataSources {
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> fetchProductById(String id);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}




class ProductRemoteDataSourcesImpl implements ProductRemoteDataSources {
  final http.Client client;
  ProductRemoteDataSourcesImpl({required this.client});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<ProductModel> fetchProductById(String id) async {
    final response = await client.get(Uri.parse('$baseUrl$id'));

    if (response.statusCode == 200) {
      final jsonData =  json.decode(response.body);
      return ProductModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add product');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final response  = await client.put(
      Uri.parse('$baseUrl${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse('$baseUrl$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete product');
    }
  }
}