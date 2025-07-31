import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

import '../../../../core/errors/failure.dart';
// import '../../data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/local/product_local_data_source.dart';
import '../data_sources/remote/product_remote_data_sources.dart';
import '../models/product_model.dart';
import '../../../../core/platform/networkinfo.dart';

class ProductRepositoryImpl implements ProductRepository {

  final ProductRemoteDataSources productRemoteDataSource;
  final ProductLocalDataSources productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(this.productRemoteDataSource, this.productLocalDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    throw UnimplementedError();
  }
  @override
  Future<Either<Failure, void>> insertProduct(ProductEntity product) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    throw UnimplementedError();
  }
}