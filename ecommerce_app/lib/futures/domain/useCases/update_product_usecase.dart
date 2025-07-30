import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  Future<Either<Failure, void>> call(ProductEntity product) {
    return repository.updateProduct(product);
  }
}


