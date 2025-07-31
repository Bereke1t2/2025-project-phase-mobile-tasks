import 'package:ecommerce_app/core/platform/networkinfo.dart';
import 'package:ecommerce_app/futures/product/data/data_sources/local/product_local_data_source.dart';
import 'package:ecommerce_app/futures/product/data/data_sources/remote/product_remote_data_sources.dart';
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
}