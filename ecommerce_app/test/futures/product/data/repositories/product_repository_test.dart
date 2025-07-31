import 'package:ecommerce_app/core/networks/networkinfo.dart';
import 'package:ecommerce_app/futures/product/data/data_sources/local/product_local_data_source.dart';
import 'package:ecommerce_app/futures/product/data/data_sources/remote/product_remote_data_sources.dart';
import 'package:ecommerce_app/futures/product/data/models/product_model.dart';
import 'package:ecommerce_app/futures/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Create mock classes
class MockProductRemoteDataSources extends Mock implements ProductRemoteDataSources {}
class MockProductLocalDataSources extends Mock implements ProductLocalDataSources {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl productRepository;
  late MockProductRemoteDataSources mockRemoteDataSource;
  late MockProductLocalDataSources mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSources();
    mockLocalDataSource = MockProductLocalDataSources();
    mockNetworkInfo = MockNetworkInfo();
    productRepository = ProductRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockNetworkInfo,
    );
  });

  test('ProductRepositoryImpl can be instantiated', () {
    expect(productRepository, isA<ProductRepositoryImpl>());
  });

  group('getAllProducts', () {
    test('should return remote products when connected to the network', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.fetchProducts()).thenAnswer((_) async => []);

      final result = await productRepository.getAllProducts();

      expect(result.isRight(), true);
      verify(mockRemoteDataSource.fetchProducts()).called(1);
    });

    test('should return local products when not connected to the network', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.fetchProducts()).thenAnswer((_) async => []);

      final result = await productRepository.getAllProducts();

      expect(result.isRight(), true);
      verify(mockLocalDataSource.fetchProducts()).called(1);
    });
  });

  group('getProductById', () {
    const productId = '1';

    test('should return remote product when connected to the network', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.fetchProductById(productId)).thenAnswer((_) async => ProductModel(id: productId, name: 'Test', description: 'Test', price: 10.0, imageUrl: 'test.jpg'));

      final result = await productRepository.getProductById(productId);

      expect(result.isRight(), true);
      verify(mockRemoteDataSource.fetchProductById(productId)).called(1);
    });


  });


  group('updateProduct', () {
    final product = ProductModel(id: '1', name: 'Test', description: 'Test', price: 10.0, imageUrl: 'test.jpg');

    test('should call remote data source when connected to the network', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(product)).thenAnswer((_) async => Future.value());

      final result = await productRepository.updateProduct(product);

      expect(result.isRight(), true);
      verify(mockRemoteDataSource.updateProduct(product)).called(1);
    });

  });

  group('deleteProduct', () {
    const productId = '1';

    test('should call remote data source when connected to the network', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct(productId)).thenAnswer((_) async => Future.value());

      final result = await productRepository.deleteProduct(productId);

      expect(result.isRight(), true);
      verify(mockRemoteDataSource.deleteProduct(productId)).called(1);
    });


  });

  group('insertProduct', () {
    final product = ProductModel(id: '1', name: 'Test', description: 'Test', price: 10.0, imageUrl: 'test.jpg');

    test('should call remote data source when connected to the network', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addProduct(product)).thenAnswer((_) async => Future.value());

      final result = await productRepository.insertProduct(product);

      expect(result.isRight(), true);
      verify(mockRemoteDataSource.addProduct(product)).called(1);
    });
  });
}