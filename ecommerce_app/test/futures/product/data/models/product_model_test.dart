import 'package:ecommerce_app/futures/product/data/models/product_model.dart';
import 'package:ecommerce_app/futures/product/domain/entities/product_entity.dart';
import 'package:test/test.dart';

void main() {
  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'This is a test product',
    price: 99.99,
    imageUrl: 'http://example.com/image.jpg',
  );

  test('ProductModel should be a subclass of ProductEntity', () {
    expect(tProductModel, isA<ProductEntity>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      final jsonMap = {
        'id': '1',
        'name': 'Test Product',
        'description': 'This is a test product',
        'price': 99.99,
        'imageUrl': 'http://example.com/image.jpg',
      };

      final result = ProductModel.fromJson(jsonMap);

      expect(result, tProductModel);
    
    });

  });
  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      final result = tProductModel.toJson();

      final expectedMap = {
        'id': '1',
        'name': 'Test Product',
        'description': 'This is a test product',
        'price': 99.99,
        'imageUrl': 'http://example.com/image.jpg',
      };

      expect(result, expectedMap);
    });
  });

}