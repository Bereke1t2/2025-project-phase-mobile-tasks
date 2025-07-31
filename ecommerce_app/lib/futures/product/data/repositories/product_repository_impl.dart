import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
// import '../../data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/remote/product_remote_data_sources.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {

  final ProductRemoteDataSources productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final products = await productRemoteDataSource.fetchProducts();
      return Right(products);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    try {
      final product = await productRemoteDataSource.fetchProductById(id);
      return Right(product);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
  @override
  Future<Either<Failure, void>> insertProduct(ProductEntity product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      await productRemoteDataSource.addProduct(productModel);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      await productRemoteDataSource.updateProduct(productModel);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await productRemoteDataSource.deleteProduct(id);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}