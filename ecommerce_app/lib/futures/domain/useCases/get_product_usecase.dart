import 'package:dartz/dartz.dart';


import '../../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<Either<Failure, ProductEntity>> call(String productId) {
    return repository.getProductById(productId);
  }
}
