
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  Future<Either<Failure, void>> call(String productId) {
    return repository.deleteProduct(productId);
  }
}
