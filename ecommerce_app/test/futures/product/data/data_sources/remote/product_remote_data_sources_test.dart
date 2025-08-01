import 'package:ecommerce_app/core/const/const.dart';
import 'package:ecommerce_app/futures/product/data/data_sources/remote/product_remote_data_sources.dart';
import 'package:ecommerce_app/futures/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_remote_data_sources_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourcesImpl productRemoteDataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    productRemoteDataSource =
        ProductRemoteDataSourcesImpl(client: mockHttpClient);
  });

  test('ProductRemoteDataSourceImpl can be instantiated', () {
    expect(productRemoteDataSource, isA<ProductRemoteDataSourcesImpl>());
  });

  group('fetchProducts', () {
    test('should return list of products from remote API', () async {
      final response = http.Response(
        '[{"id":"1","name":"Test","description":"Test","price":10.0,"imageUrl":"test.jpg"}]',
        200,
      );

      when(mockHttpClient.get(Uri.parse(baseUrl)))
          .thenAnswer((_) async => response);

      final result = await productRemoteDataSource.fetchProducts();

      expect(result, isA<List<ProductModel>>());
      expect(result.length, 1);
      expect(result.first.id, '1');
    });
  });

  group('fetchProductById', () {
    test('should return product from remote API', () async {
      final response = http.Response(
        '{"id":"1","name":"Test","description":"Test","price":10.0,"imageUrl":"test.jpg"}',
        200,
      );

      when(mockHttpClient.get(Uri.parse('$baseUrl${1}')))
          .thenAnswer((_) async => response);

      final result = await productRemoteDataSource.fetchProductById('1');

      expect(result, isA<ProductModel>());
      expect(result.id, '1');
    });
  });

  

}
