part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductsEvent extends ProductEvent {
  
}


class LoadSingleProductEvent extends ProductEvent {
  final String productId;

  const LoadSingleProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}


class InsertProductEvent extends ProductEvent {
  final ProductEntity product;

  const InsertProductEvent(this.product);

  @override
  List<Object> get props => [product];
}


class DeleteProductEvent extends ProductEvent {
  final String productId;

  const DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;

  const UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}