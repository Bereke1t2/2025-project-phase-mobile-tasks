import 'package:ecommerce_app/futures/product/data/data_sources/local/product_local_data_source.dart';
import 'package:ecommerce_app/futures/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ProductLocalDataSources localDataSource = ProductLocalDataSourceImpl(prefs);

  group('ProductLocalDataSource Tests', () {
    test('should fetch products from local storage', () async {
      final products = await localDataSource.fetchProducts();
      expect(products, isA<List<ProductModel>>());
    });

    test('should cache products to local storage', () async {
      final product = const ProductModel(id: '1', name: 'Test Product', price: 10.0, description: '', imageUrl: '');
      await localDataSource.cacheProducts([product]);
      final cachedProducts = await localDataSource.fetchProducts();
      expect(cachedProducts.length, 1);
      expect(cachedProducts.first.id, '1');
    });

    test('should fetch product by id from local storage', () async {
      final product = await localDataSource.fetchProductById('1');
      expect(product.id, '1');
    });

    test('should add a product to local storage', () async {
      final newProduct = const ProductModel(id: '2', name: 'New Product', price: 20.0, description: '', imageUrl: '');
      await localDataSource.addProduct(newProduct);
      final products = await localDataSource.fetchProducts();
      expect(products.any((p) => p.id == '2'), true);
    });
  });
}