import 'dart:convert';

import 'package:ecommerce_app/futures/product/data/data_sources/local/product_local_data_source.dart';
import 'package:ecommerce_app/futures/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';


@GenerateMocks([SharedPreferences , ProductLocalDataSourceImpl])
import 'proudct_local_data_sources_test.mocks.dart' show MockSharedPreferences;

void main() {
  late ProductLocalDataSourceImpl productLocalDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    productLocalDataSource = ProductLocalDataSourceImpl(mockSharedPreferences);
  });

  test('ProductLocalDataSourceImpl can be instantiated', () {
    expect(productLocalDataSource, isA<ProductLocalDataSourceImpl>());
  });

  group('fetchProducts', () {
    test('should return list of products from SharedPreferences', () async {
      when(mockSharedPreferences.getStringList('products'))
          .thenReturn(['{"id":"1","name":"Test","description":"Test","price":10.0,"imageUrl":"test.jpg"}']);

      final result = await productLocalDataSource.fetchProducts();

      expect(result, isA<List<ProductModel>>());
      expect(result.length, 1);
      expect(result.first.id, '1');
    });
  });

  group('cacheProducts', () {
    test('should cache products in SharedPreferences', () async {
      final products = [
        const ProductModel(id: '1', name: 'Test', description: 'Test', price: 10.0, imageUrl: 'test.jpg')
      ];

      when(mockSharedPreferences.setStringList(
        'products',
        [jsonEncode(products.first.toJson())],
      )).thenAnswer((_) async => true);

      await productLocalDataSource.cacheProducts(products);
      
      verify(mockSharedPreferences.setStringList(
        'products',
        [jsonEncode(products.first.toJson())],
      )).called(1);
    });
  });
}
 