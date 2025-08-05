part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class LoadingState extends ProductState {}

class LoadedAllProductsState extends ProductState {
  final List<ProductEntity> products;

  const LoadedAllProductsState(this.products);

  @override
  List<Object> get props => [products];
}

class LoadedSingleProductState extends ProductState {
  final ProductEntity product;

  const LoadedSingleProductState(this.product);

  @override
  List<Object> get props => [product];
}

class ErrorState extends ProductState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedSuccessState extends ProductState {}