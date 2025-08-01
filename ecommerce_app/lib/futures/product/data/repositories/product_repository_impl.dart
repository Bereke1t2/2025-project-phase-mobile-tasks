import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/networks/networkinfo.dart';
// import '../../data/models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/local/product_local_data_source.dart';
import '../data_sources/remote/product_remote_data_sources.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {

  final ProductRemoteDataSources productRemoteDataSource;
  final ProductLocalDataSources productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(this.productRemoteDataSource, this.productLocalDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDataSource.fetchProducts();
        await productLocalDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts.map((model) => ProductModel.toEntity(model)).toList());

      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await productLocalDataSource.fetchProducts();
        return Right(localProducts.map((model) => ProductModel.toEntity(model)).toList());
      } catch (e) {
        return const Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDataSource.fetchProductById(id);
        return Right(ProductModel.toEntity(remoteProduct));
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel.fromEntity(product);
        await productRemoteDataSource.addProduct(productModel);
        await productLocalDataSource.addProduct(productModel);
        return const Right(null);

      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel.fromEntity(product);
        await productRemoteDataSource.updateProduct(productModel);
        return const Right(null);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource.deleteProduct(id);
        return const Right(null);
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
