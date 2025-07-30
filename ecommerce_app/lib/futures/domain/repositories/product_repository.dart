
import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../entities/product_entity.dart';



abstract class ProductRepository {
  Future<Either<Failure, void>> insertProduct(ProductEntity product);
  Future<Either<Failure, void>> updateProduct(ProductEntity product);
  Future<Either<Failure, void>> deleteProduct(String productId);
  Future<Either<Failure, ProductEntity>> getProductById(String productId);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
}